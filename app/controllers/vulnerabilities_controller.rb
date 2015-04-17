class VulnerabilitiesController < ApplicationController

	require "ChecklistParser"

	def index
		@vulnerabilities = Vulnerability.all
	end

	def new
	end

	def create
		uploaded_io = params[:checklist]
        parser = ChecklistParser.new

		all_the_things = parser.get_all_the_things(uploaded_io)

		checklist = Checklist.new
		checklist.name = all_the_things[:checklist]

		asset = Asset.new
		asset.asset_type = all_the_things[:asset][:asset_type]
		asset.host_name = all_the_things[:asset][:host_name]
		asset.ip_address = all_the_things[:asset][:ip_address]
		asset.mac_address = all_the_things[:asset][:mac_address]

		all_the_things[:vulnerabilities].each do |vulnerability|
			vuln_db = Vulnerability.new
			vuln_db.status = vulnerability[:STATUS]
			vuln_db.finding_details = vulnerability[:FINDING_DETAILS]
			vuln_db.comments = vulnerability[:COMMENTS]
			vuln_db.severity_override = vulnerability[:SEVERITY_OVERRIDE]
			vuln_db.severity_justification = vulnerability[:SEVERITY_JUSTIFICATION]
			vuln_db.vulnerability_number = vulnerability[:VULN_NUM]
			vuln_db.severity = vulnerability[:SEVERITY]
			vuln_db.group_title = vulnerability[:GROUP_TITLE]
			vuln_db.rule_id = vulnerability[:RULE_ID]
			vuln_db.rule_ver = vulnerability[:RULE_VER]
			vuln_db.rule_title = vulnerability[:RULE_TITLE]
			vuln_db.vuln_discussion = vulnerability[:VULN_DISCUSSION]
			vuln_db.ia_controls = vulnerability[:IA_CONTROLS]
			vuln_db.check_content = vulnerability[:CHECK_CONTENT]
			vuln_db.fix_text = vulnerability[:FIX_TEXT]
			vuln_db.cci_ref = vulnerability[:CCI_REF]

			vuln_db.checklist = checklist
			vuln_db.asset = asset

			vuln_db.save
		end

		redirect_to vulnerabilities_path
	end
end
