module Census::Arkansas
  def self.code = "AR"

  def self.congressional_seats = 4

  def self.lower_chamber_size = 100

  def self.upper_chamber_size = 35

  def self.elections
    [
      # {day: "00/00/2011", election_type: "G", sos_election_id_column: 64, vote_column: 66}, # LG24
      # {day: "00/00/2011", election_type: "P", sos_election_id_column: 68, vote_column: 68}, # LG54
      # {day: "00/00/2011", election_type: "PR", sos_election_id_column: 72, vote_column: 74}, # LG54
      # {day: "00/00/2011", election_type: "G", sos_election_id_column: 76, vote_column: 78}, # LG54
      {day: "11/08/2011", election_type: "S", sos_election_id_column: 80, vote_column: 82}, # highway bonds
      {day: "05/22/2012", election_type: "P", sos_election_id_column: 84, vote_column: 86},
      # {day: "00/00/2012", election_type: "PR", sos_election_id_column: 88, vote_column: 90},
      {day: "11/06/2012", election_type: "G", sos_election_id_column: 92, vote_column: 94},
      {day: "10/08/2013", election_type: "P", sos_election_id_column: 96, vote_column: 98}, # SD21
      {day: "11/12/2013", election_type: "PR", sos_election_id_column: 100, vote_column: 102}, # SD21
      {day: "01/14/2014", election_type: "G", sos_election_id_column: 104, vote_column: 106}, # SD21
      {day: "05/20/2014", election_type: "P", sos_election_id_column: 108, vote_column: 110},
      {day: "06/10/2014", election_type: "PR", sos_election_id_column: 112, vote_column: 114},
      {day: "11/04/2014", election_type: "G", sos_election_id_column: 116, vote_column: 118},
      # {day: "00/00/2016", election_type: "P", sos_election_id_column: 120, vote_column: 122}, # SPSN16
      # {day: "00/00/2016", election_type: "PR", sos_election_id_column: 124, vote_column: 124}, # SPSN16
      {day: "11/08/2016", election_type: "G", sos_election_id_column: 128, vote_column: 130}, # SPSN16
      {day: "03/01/2016", election_type: "P", sos_election_id_column: 132, vote_column: 134},
      {day: "03/22/2016", election_type: "PR", sos_election_id_column: 136, vote_column: 138},
      {day: "11/08/2016", election_type: "G", sos_election_id_column: 140, vote_column: 142},
      # {day: "00/00/2018", election_type: "P", sos_election_id_column: 144, vote_column: 146}, # special
      # {day: "00/00/2018", election_type: "PR", sos_election_id_column: 148, vote_column: 150},
      {day: "05/22/2018", election_type: "P", sos_election_id_column: 152, vote_column: 154}, # preferential primary
      {day: "06/19/2018", election_type: "PR", sos_election_id_column: 156, vote_column: 158},
      {day: "11/06/2018", election_type: "G", sos_election_id_column: 160, vote_column: 162},
      {day: "12/05/2018", election_type: "GR", sos_election_id_column: 163, vote_column: 165},
      {day: "03/03/2020", election_type: "P", sos_election_id_column: 168, vote_column: 170}, # preferential primary
      {day: "03/31/2020", election_type: "PR", sos_election_id_column: 172, vote_column: 172},
      {day: "11/03/2020", election_type: "G", sos_election_id_column: 176, vote_column: 178},
      {day: "05/24/2022", election_type: "P", sos_election_id_column: 180, vote_column: 182},
      {day: "06/21/2022", election_type: "PR", sos_election_id_column: 184, vote_column: 186},
      {day: "11/08/2022", election_type: "G", sos_election_id_column: 188, vote_column: 190},
      {day: "12/06/2022", election_type: "GR", sos_election_id_column: 192, vote_column: 194}
    ]
  end

  def self.counties
    [
      {code: "Arkansas", name: "Arkansas"},
      {code: "Ashley", name: "Ashley"},
      {code: "Baxter", name: "Baxter"},
      {code: "Benton", name: "Benton"},
      {code: "Boone", name: "Boone"},
      {code: "Bradley", name: "Bradley"},
      {code: "Calhoun", name: "Calhoun"},
      {code: "Carroll", name: "Carroll"},
      {code: "Chicot", name: "Chicot"},
      {code: "Clark", name: "Clark"},
      {code: "Clay", name: "Clay"},
      {code: "Cleburne", name: "Cleburne"},
      {code: "Cleveland", name: "Cleveland"},
      {code: "Columbia", name: "Columbia"},
      {code: "Conway", name: "Conway"},
      {code: "Craighead", name: "Craighead"},
      {code: "Crawford", name: "Crawford"},
      {code: "Crittenden", name: "Crittenden"},
      {code: "Cross", name: "Cross"},
      {code: "Dallas", name: "Dallas"},
      {code: "Desha", name: "Desha"},
      {code: "Drew", name: "Drew"},
      {code: "Faulkner", name: "Faulkner"},
      {code: "Franklin", name: "Franklin"},
      {code: "Fulton", name: "Fulton"},
      {code: "Garland", name: "Garland"},
      {code: "Grant", name: "Grant"},
      {code: "Greene", name: "Greene"},
      {code: "Hempstead", name: "Hempstead"},
      {code: "Hot Spring", name: "Hot Spring"},
      {code: "Howard", name: "Howard"},
      {code: "Independence", name: "Independence"},
      {code: "Izard", name: "Izard"},
      {code: "Jackson", name: "Jackson"},
      {code: "Jefferson", name: "Jefferson"},
      {code: "Johnson", name: "Johnson"},
      {code: "Lafayette", name: "Lafayette"},
      {code: "Lawrence", name: "Lawrence"},
      {code: "Lee", name: "Lee"},
      {code: "Lincoln", name: "Lincoln"},
      {code: "Little River", name: "Little River"},
      {code: "Logan", name: "Logan"},
      {code: "Lonoke", name: "Lonoke"},
      {code: "Madison", name: "Madison"},
      {code: "Marion", name: "Marion"},
      {code: "Miller", name: "Miller"},
      {code: "Mississippi", name: "Mississippi"},
      {code: "Monroe", name: "Monroe"},
      {code: "Montgomery", name: "Montgomery"},
      {code: "Nevada", name: "Nevada"},
      {code: "Newton", name: "Newton"},
      {code: "Ouachita", name: "Ouachita"},
      {code: "Perry", name: "Perry"},
      {code: "Phillips", name: "Phillips"},
      {code: "Pike", name: "Pike"},
      {code: "Poinsett", name: "Poinsett"},
      {code: "Polk", name: "Polk"},
      {code: "Pope", name: "Pope"},
      {code: "Prairie", name: "Prairie"},
      {code: "Pulaski", name: "Pulaski"},
      {code: "Randolph", name: "Randolph"},
      {code: "Saline", name: "Saline"},
      {code: "Scott", name: "Scott"},
      {code: "Searcy", name: "Searcy"},
      {code: "Sebastian", name: "Sebastian"},
      {code: "Sevier", name: "Sevier"},
      {code: "Sharp", name: "Sharp"},
      {code: "St. Francis", name: "St. Francis"},
      {code: "Stone", name: "Stone"},
      {code: "Union", name: "Union"},
      {code: "Van Buren", name: "Van Buren"},
      {code: "Washington", name: "Washington"},
      {code: "White", name: "White"},
      {code: "Woodruff", name: "Woodruff"},
      {code: "Yell", name: "Yell"}
    ]
  end

  def self.political_parties
    [
      {code: "D", name: "Democratic", icon: "democrat"},
      {code: "R", name: "Republican", icon: "republican"},
      {code: "G", name: "Green", icon: "dove"},
      {code: "L", name: "Libertarian", icon: "balance-scale"},
      {code: "O", name: "Optional"},
      {code: "S", name: "Special Ballot"},
      {code: "NP", name: "Nonpartisan Judicial"}
      # I     I
      # RF    Rf
      # U     U
      # NON   Non
      # IM    IM
      # Y     Y
    ]
  end

  def self.voter_statuses
    [
      {code: "A", name: "Active"},
      {code: "I", name: "Inactive"},
      {code: "N", name: "Not Eligible"},
      {code: "R", name: "Removable"},
      {code: "S", name: "Suspense"},
      {code: "NR", name: "Not Registered"}
    ]
  end

  def self.voter_status_reason
    [
      {code: "AAC", name: "Re-activated (Conf Mailing)"},
      {code: "ACR", name: "Voting Right Elsewhere"},
      {code: "ADD", name: "Unprecinctable Address"},
      {code: "AMI", name: "Mental Incomp. Judgment"},
      {code: "ANP", name: "No Valid Precinct Sp"},
      {code: "ARG", name: "Re-activated (ReRegistered)"},
      {code: "AVC", name: "Re-activated (Vote Cast)"},
      {code: "AVR", name: "Per Voter Request"},
      {code: "AVU", name: "Re-activated (Updated Record)"},
      {code: "B18", name: "Became 18"},
      {code: "CNR", name: "No Conf Response"},
      {code: "CON", name: "Convicted Felon"},
      {code: "CUN", name: "Conf Undeliverable"},
      {code: "CUT", name: "Election Cut-Off"},
      {code: "DUP", name: "Duplicate Registration"},
      {code: "FV", name: "Federal Voter"},
      {code: "IFC", name: "Inactive Status/2 Fed Gen Elec Cycles"},
      {code: "INC", name: "Incomplete Application"},
      {code: "NUC", name: "Not US Citizen"},
      {code: "OYM", name: "Odd Year Mailing"},
      {code: "PCH", name: "Precinct Change"},
      {code: "REG", name: "Registered"},
      {code: "RQV", name: "Request By Voter"},
      {code: "STW", name: "Sent Twice"},
      {code: "U18", name: "Under 18"},
      {code: "VER", name: "Verification Sent"},
      {code: "XCV", name: "Conversion Issue"},
      {code: "XDE", name: "Death Notification"},
      {code: "XMO", name: "Moved Out of County"}
    ]
  end

  def self.voting_methods
    [
      {code: "P", name: "Polling Place"},
      {code: "A", name: "Absentee"},
      {code: "E", name: "Early"},
      {code: "V", name: "Provisional"},
      {code: "B", name: "Provisional Absentee"},
      {code: "Y", name: "Provisional Early"},
      {code: "F", name: "New/Former Resident"}
    ]
  end
end
