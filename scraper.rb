require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new

page = agent.get("http://www.rfs.nsw.gov.au/fire-information/fdr-and-tobans")

table = page.at('table.danger-ratings-table')

table.search('tbody tr').each do |table_row|
  fire_area = {
    area_name: table_row.search('td')[0].text,
    fire_danger_today: table_row.search('td')[1].text,
    councils_effected: table_row.search('td')[-1].text
  }

  ScraperWiki.save_sqlite([:area_name], fire_area)
end