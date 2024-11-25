class NewsModel {
  final String category;
  final int timestamp;
  final int read;
  final List<Cluster> clusters;

  NewsModel({
    required this.category,
    required this.timestamp,
    required this.read,
    required this.clusters,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      category: json['category'],
      timestamp: json['timestamp'],
      read: json['read'],
      clusters: (json['clusters'] as List<dynamic>)
          .map((e) => Cluster.fromJson(e))
          .toList(),
    );
  }
}

class Cluster {
  final int clusterNumber;
  final int uniqueDomains;
  final int numberOfTitles;
  final String category;
  final String title;
  final String shortSummary;
  final String didYouKnow;
  final List<String> talkingPoints;
  final String quote;
  final String quoteAuthor;
  final String quoteSourceUrl;
  final String quoteSourceDomain;
  final String location;
  final List<Perspective> perspectives;
  final String emoji;
  final String geopoliticalContext;
  final String historicalBackground;
  final List<String> internationalReactions;
  final String humanitarianImpact;
  final String economicImplications;
  final List<String> timeline;
  final String futureOutlook;
  final List<String> keyPlayers;
  // final String technicalDetails;
  final String businessAngleText;
  final List<String> businessAnglePoints;
  final List<String> userActionItems;
  final List<String> scientificSignificance;
  final List<String> travelAdvisory;
  final String destinationHighlights;
  final String culinarySignificance;
  final List<String> performanceStatistics;
  final String leagueStandings;
  final String diyTips;
  final String designPrinciples;
  final String userExperienceImpact;
  final List<String> gameplayMechanics;
  final List<String> industryImpact;
  final String technicalSpecifications;
  final List<Article> articles;
  final List<Domain> domains;

  List<String> getImages() {
    List<String> images = [];
    for (final article in articles) {
      if (article.image.isNotEmpty) {
        images.add(article.image);
      }
    }
    return images;
  }

  Cluster({
    required this.clusterNumber,
    required this.uniqueDomains,
    required this.numberOfTitles,
    required this.category,
    required this.title,
    required this.shortSummary,
    required this.didYouKnow,
    required this.talkingPoints,
    required this.quote,
    required this.quoteAuthor,
    required this.quoteSourceUrl,
    required this.quoteSourceDomain,
    required this.location,
    required this.perspectives,
    required this.emoji,
    required this.geopoliticalContext,
    required this.historicalBackground,
    required this.internationalReactions,
    required this.humanitarianImpact,
    required this.economicImplications,
    required this.timeline,
    required this.futureOutlook,
    required this.keyPlayers,
    // required this.technicalDetails,
    required this.businessAngleText,
    required this.businessAnglePoints,
    required this.userActionItems,
    required this.scientificSignificance,
    required this.travelAdvisory,
    required this.destinationHighlights,
    required this.culinarySignificance,
    required this.performanceStatistics,
    required this.leagueStandings,
    required this.diyTips,
    required this.designPrinciples,
    required this.userExperienceImpact,
    required this.gameplayMechanics,
    required this.industryImpact,
    required this.technicalSpecifications,
    required this.articles,
    required this.domains,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) {
    return Cluster(
      clusterNumber: json['cluster_number'],
      uniqueDomains: json['unique_domains'],
      numberOfTitles: json['number_of_titles'],
      category: json['category'],
      title: json['title'],
      shortSummary: json['short_summary'],
      didYouKnow: json['did_you_know'],
      talkingPoints: List<String>.from(json['talking_points']),
      quote: json['quote'],
      quoteAuthor: json['quote_author'],
      quoteSourceUrl: json['quote_source_url'],
      quoteSourceDomain: json['quote_source_domain'],
      location: json['location'],
      perspectives: (json['perspectives'] as List<dynamic>)
          .map((e) => Perspective.fromJson(e))
          .toList(),
      emoji: json['emoji'],
      geopoliticalContext: json['geopolitical_context'],
      historicalBackground: json['historical_background'],
      internationalReactions: json['international_reactions'] is String
          ? [json['international_reactions']]
          : List<String>.from(json['international_reactions'] ?? []),
      humanitarianImpact: json['humanitarian_impact'],
      economicImplications: json['economic_implications'],
      timeline: List<String>.from(json['timeline']) is String
          ? [json['timeline']]
          : List<String>.from(json['timeline'] ?? []),
      futureOutlook: json['future_outlook'],
      keyPlayers: List<String>.from(json['key_players']),
      // technicalDetails: json['technical_details'],
      businessAngleText: json['business_angle_text'],
      businessAnglePoints: List<String>.from(json['business_angle_points']),
      userActionItems: List<String>.from(json['user_action_items']),
      scientificSignificance:
          List<String>.from(json['scientific_significance']),
      travelAdvisory: List<String>.from(json['travel_advisory']),
      destinationHighlights: json['destination_highlights'],
      culinarySignificance: json['culinary_significance'],
      performanceStatistics: List<String>.from(json['performance_statistics']),
      leagueStandings: json['league_standings'],
      diyTips: json['diy_tips'],
      designPrinciples: json['design_principles'],
      userExperienceImpact: json['user_experience_impact'],
      gameplayMechanics: List<String>.from(json['gameplay_mechanics']),
      industryImpact: List<String>.from(json['industry_impact']),
      technicalSpecifications: json['technical_specifications'],
      articles: (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e))
          .toList(),
      domains: (json['domains'] as List<dynamic>)
          .map((e) => Domain.fromJson(e))
          .toList(),
    );
  }
}

class Domain {
  final String name;
  final String favIcon;

  Domain({required this.name, required this.favIcon});

  factory Domain.fromJson(Map<String, dynamic> json) {
    return Domain(name: json["name"], favIcon: json["favicon"]);
  }
}

class Perspective {
  final String text;
  final List<Source> sources;

  Perspective({
    required this.text,
    required this.sources,
  });

  factory Perspective.fromJson(Map<String, dynamic> json) {
    return Perspective(
      text: json['text'],
      sources: (json['sources'] as List<dynamic>)
          .map((e) => Source.fromJson(e))
          .toList(),
    );
  }
}

class Source {
  final String name;
  final String url;

  Source({
    required this.name,
    required this.url,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json['name'],
      url: json['url'],
    );
  }
}

class UserActionItem {
  final String action;

  UserActionItem({required this.action});

  factory UserActionItem.fromJson(Map<String, dynamic> json) {
    return UserActionItem(
      action: "json",
    );
  }
}

class Article {
  final String title;
  final String link;
  final String domain;
  final String date;
  final String image;

  Article({
    required this.title,
    required this.link,
    required this.domain,
    required this.date,
    required this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      link: json['link'],
      domain: json['domain'],
      date: json['date'],
      image: json['image'],
    );
  }
}
