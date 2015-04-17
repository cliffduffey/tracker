class CreateVulnerabilities < ActiveRecord::Migration
  def change
    create_table :vulnerabilities do |t|
      t.string :status
      t.string :finding_details
      t.text :comments
      t.string :severity_override
      t.text :severity_justification
      t.string :vulnerability_number
      t.string :severity
      t.string :group_title
      t.string :rule_id
      t.string :rule_ver
      t.string :rule_title
      t.text :vuln_discussion
      t.string :ia_controls
      t.text :check_content
      t.text :fix_text
      t.string :cci_ref
      t.references :checklist, index: true
      t.references :asset, index: true

      t.timestamps
    end
  end
end
