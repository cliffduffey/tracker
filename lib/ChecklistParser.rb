class ChecklistParser

  require 'nokogiri'

  def get_all_the_things(ckl_file)
    return nil unless (xml_data = extract_xml(ckl_file))  

    asset = Hash.new
    asset_section = xml_data.at_xpath('//ASSET')
    asset[:asset_type] = asset_section.at_xpath('//ASSET_TYPE').content
    asset[:host_name] = asset_section.at_xpath('//HOST_NAME').content
    asset[:ip_address] = asset_section.at_xpath('//HOST_IP').content
    asset[:mac_address] = asset_section.at_xpath('//HOST_MAC').content

    checklist = xml_data.at_xpath('//CHECKLIST/STIG_INFO/STIG_TITLE').content

    vulnerabilities = Array.new
    xml_data.xpath('//CHECKLIST/VULN').each do |vuln_data|
       vulnerability = Hash.new
       vuln_data.xpath('STIG_DATA').each do |stig_data|
         key = stig_data.at_xpath('VULN_ATTRIBUTE').content.upcase
         value = stig_data.at_xpath('ATTRIBUTE_DATA').content
         vulnerability[key.to_sym] = value
       end

       vulnerability[:STATUS] = vuln_data.at_xpath('STATUS').content
       vulnerability[:FINDING_DETAILS] = vuln_data.at_xpath('FINDING_DETAILS').content
       vulnerability[:COMMENTS] = vuln_data.at_xpath('COMMENTS').content
       vulnerability[:SEVERITY_OVERRIDE] = vuln_data.at_xpath('SEVERITY_OVERRIDE').content
       vulnerability[:SEVERITY_JUSTIFICATION] = vuln_data.at_xpath('SEVERITY_JUSTIFICATION').content 

       vulnerabilities += [vulnerability]
    end

    all_the_things = Hash.new
    all_the_things[:asset] = asset
    all_the_things[:checklist] = checklist
    all_the_things[:vulnerabilities] = vulnerabilities

    return all_the_things
  end

  private

  def extract_xml(ckl_file)
    doc = Nokogiri::XML(ckl_file)
    return doc
  end

end
