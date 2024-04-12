module Census::Ohio
  def self.code = "OH"

  def self.congressional_seats = 15

  def self.lower_chamber_size = 99

  def self.upper_chamber_size = 33

  def self.elections
    [
      {day: "03/07/2000", election_type: "P", vote_column: 46},
      {day: "11/07/2000", election_type: "G", vote_column: 47},
      {day: "05/08/2001", election_type: "S", vote_column: 48},
      {day: "11/06/2001", election_type: "G", vote_column: 49},
      {day: "05/07/2002", election_type: "P", vote_column: 50},
      {day: "11/05/2002", election_type: "G", vote_column: 51},
      {day: "05/06/2003", election_type: "S", vote_column: 52},
      {day: "11/04/2003", election_type: "G", vote_column: 53},
      {day: "03/02/2004", election_type: "P", vote_column: 54},
      {day: "11/02/2004", election_type: "G", vote_column: 55},
      {day: "02/08/2005", election_type: "S", vote_column: 56},
      {day: "05/03/2005", election_type: "P", vote_column: 57},
      {day: "09/13/2005", election_type: "P", vote_column: 58},
      {day: "11/08/2005", election_type: "G", vote_column: 59},
      {day: "02/07/2006", election_type: "S", vote_column: 60},
      {day: "05/02/2006", election_type: "P", vote_column: 61},
      {day: "11/07/2006", election_type: "G", vote_column: 62},
      {day: "05/08/2007", election_type: "P", vote_column: 63},
      {day: "09/11/2007", election_type: "P", vote_column: 64},
      {day: "11/06/2007", election_type: "G", vote_column: 65},
      {day: "11/06/2007", election_type: "P", vote_column: 66},
      {day: "12/11/2007", election_type: "G", vote_column: 67},
      {day: "03/04/2008", election_type: "P", vote_column: 68},
      {day: "10/14/2008", election_type: "P", vote_column: 69},
      {day: "11/04/2008", election_type: "G", vote_column: 70},
      {day: "11/18/2008", election_type: "G", vote_column: 71},
      {day: "05/05/2009", election_type: "P", vote_column: 72},
      {day: "09/08/2009", election_type: "P", vote_column: 73},
      {day: "09/15/2009", election_type: "P", vote_column: 74},
      {day: "09/29/2009", election_type: "P", vote_column: 75},
      {day: "11/03/2009", election_type: "G", vote_column: 76},
      {day: "05/04/2010", election_type: "P", vote_column: 77},
      {day: "07/13/2010", election_type: "P", vote_column: 78},
      {day: "09/07/2010", election_type: "P", vote_column: 79},
      {day: "11/02/2010", election_type: "G", vote_column: 80},
      {day: "05/03/2011", election_type: "P", vote_column: 81},
      {day: "09/13/2011", election_type: "P", vote_column: 82},
      {day: "11/08/2011", election_type: "G", vote_column: 83},
      {day: "03/06/2012", election_type: "P", vote_column: 84},
      {day: "11/06/2012", election_type: "G", vote_column: 85},
      {day: "05/07/2013", election_type: "P", vote_column: 86},
      {day: "09/10/2013", election_type: "P", vote_column: 87},
      {day: "10/01/2013", election_type: "P", vote_column: 88},
      {day: "11/05/2013", election_type: "G", vote_column: 89},
      {day: "05/06/2014", election_type: "P", vote_column: 90},
      {day: "11/04/2014", election_type: "G", vote_column: 91},
      {day: "05/05/2015", election_type: "P", vote_column: 92},
      {day: "09/15/2015", election_type: "P", vote_column: 93},
      {day: "11/03/2015", election_type: "G", vote_column: 94},
      {day: "03/15/2016", election_type: "P", vote_column: 95},
      {day: "06/07/2016", election_type: "G", vote_column: 96},
      {day: "09/13/2016", election_type: "P", vote_column: 97},
      {day: "11/08/2016", election_type: "G", vote_column: 98},
      {day: "05/02/2017", election_type: "P", vote_column: 99},
      {day: "09/12/2017", election_type: "P", vote_column: 100},
      {day: "11/07/2017", election_type: "G", vote_column: 101},
      {day: "05/08/2018", election_type: "P", vote_column: 102},
      {day: "08/07/2018", election_type: "S", vote_column: 103},
      {day: "11/06/2018", election_type: "G", vote_column: 104},
      {day: "05/07/2019", election_type: "P", vote_column: 105},
      {day: "09/10/2019", election_type: "P", vote_column: 106},
      {day: "11/05/2019", election_type: "G", vote_column: 107},
      {day: "03/17/2020", election_type: "P", vote_column: 108},
      {day: "11/03/2020", election_type: "G", vote_column: 109},
      {day: "05/04/2021", election_type: "P", vote_column: 110},
      {day: "08/03/2021", election_type: "P", vote_column: 111},
      {day: "09/14/2021", election_type: "P", vote_column: 112},
      {day: "11/02/2021", election_type: "G", vote_column: 113},
      {day: "05/03/2022", election_type: "P", vote_column: 114},
      {day: "08/02/2022", election_type: "P", vote_column: 115},
      {day: "11/08/2022", election_type: "G", vote_column: 116},
      {day: "02/28/2023", election_type: "S", vote_column: 117},
      {day: "05/02/2023", election_type: "P", vote_column: 118},
      {day: "08/08/2023", election_type: "S", vote_column: 119},
      {day: "09/12/2023", election_type: "S", vote_column: 120},
      {day: "10/03/2023", election_type: "P", vote_column: 121},
      {day: "11/07/2023", election_type: "G", vote_column: 122},
      {day: "12/05/2023", election_type: "S", vote_column: 123}
    ]
  end

  def self.counties
    [
      {code: "01", name: "Adams"},
      {code: "02", name: "Allen"},
      {code: "03", name: "Ashland"},
      {code: "04", name: "Ashtabula"},
      {code: "05", name: "Athens"},
      {code: "06", name: "Auglaize"},
      {code: "07", name: "Belmont"},
      {code: "08", name: "Brown"},
      {code: "09", name: "Butler"},
      {code: "10", name: "Carroll"},
      {code: "11", name: "Champaign"},
      {code: "12", name: "Clark"},
      {code: "13", name: "Clermont"},
      {code: "14", name: "Clinton"},
      {code: "15", name: "Columbiana"},
      {code: "16", name: "Coshocton"},
      {code: "17", name: "Crawford"},
      {code: "18", name: "Cuyahoga"},
      {code: "19", name: "Darke"},
      {code: "20", name: "Defiance"},
      {code: "21", name: "Delaware"},
      {code: "22", name: "Erie"},
      {code: "23", name: "Fairfield"},
      {code: "24", name: "Fayette"},
      {code: "25", name: "Franklin"},
      {code: "26", name: "Fulton"},
      {code: "27", name: "Gallia"},
      {code: "28", name: "Geauga"},
      {code: "29", name: "Greene"},
      {code: "30", name: "Guernsey"},
      {code: "31", name: "Hamilton"},
      {code: "32", name: "Hancock"},
      {code: "33", name: "Hardin"},
      {code: "34", name: "Harrison"},
      {code: "35", name: "Henry"},
      {code: "36", name: "Highland"},
      {code: "37", name: "Hocking"},
      {code: "38", name: "Holmes"},
      {code: "39", name: "Huron"},
      {code: "40", name: "Jackson"},
      {code: "41", name: "Jefferson"},
      {code: "42", name: "Knox"},
      {code: "43", name: "Lake"},
      {code: "44", name: "Lawrence"},
      {code: "45", name: "Licking"},
      {code: "46", name: "Logan"},
      {code: "47", name: "Lorain"},
      {code: "48", name: "Lucas"},
      {code: "49", name: "Madison"},
      {code: "50", name: "Mahoning"},
      {code: "51", name: "Marion"},
      {code: "52", name: "Medina"},
      {code: "53", name: "Meigs"},
      {code: "54", name: "Mercer"},
      {code: "55", name: "Miami"},
      {code: "56", name: "Monroe"},
      {code: "57", name: "Montgomery"},
      {code: "58", name: "Morgan"},
      {code: "59", name: "Morrow"},
      {code: "60", name: "Muskingum"},
      {code: "61", name: "Noble"},
      {code: "62", name: "Ottawa"},
      {code: "63", name: "Paulding"},
      {code: "64", name: "Perry"},
      {code: "65", name: "Pickaway"},
      {code: "66", name: "Pike"},
      {code: "67", name: "Portage"},
      {code: "68", name: "Preble"},
      {code: "69", name: "Putnam"},
      {code: "70", name: "Richland"},
      {code: "71", name: "Ross"},
      {code: "72", name: "Sandusky"},
      {code: "73", name: "Scioto"},
      {code: "74", name: "Seneca"},
      {code: "75", name: "Shelby"},
      {code: "76", name: "Stark"},
      {code: "77", name: "Summit"},
      {code: "78", name: "Trumbull"},
      {code: "79", name: "Tuscarawas"},
      {code: "80", name: "Union"},
      {code: "81", name: "Van Wert"},
      {code: "82", name: "Vinton"},
      {code: "83", name: "Warren"},
      {code: "84", name: "Washington"},
      {code: "85", name: "Wayne"},
      {code: "86", name: "Williams"},
      {code: "87", name: "Wood"},
      {code: "88", name: "Wyandot"}
    ]
  end

  def self.political_parties
    [
      {code: "D", name: "Democrat", icon: "democrat"},
      {code: "R", name: "Republican", icon: "republican"},
      {code: "G", name: "Green", icon: "dove"},
      {code: "L", name: "Libertarian", icon: "balance-scale"},
      {code: "U", name: "Unaffiliated"},
      {code: "C", name: "Constitution", icon: "scroll-old"},
      {code: "S", name: "Socialist", icon: "hands-holding"}
    ]
  end

  def self.voter_statuses
    [
      {code: "A", name: "Active"},
      {code: "I", name: "Inactive"},
      {code: "C", name: "Confirmation"},
      {code: "N", name: "Not Eligible"},
      {code: "NR", name: "Not Registered"}
    ]
  end
end