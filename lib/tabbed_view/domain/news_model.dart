import 'package:flutter/foundation.dart';

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
    T decodeField<T>(String key, T Function() decode) {
      try {
        return decode();
      } catch (e) {
        debugPrint('Error decoding field "$key": $e');
        rethrow;
      }
    }

    return Cluster(
      clusterNumber:
          decodeField('cluster_number', () => json['cluster_number']),
      uniqueDomains:
          decodeField('unique_domains', () => json['unique_domains']),
      numberOfTitles:
          decodeField('number_of_titles', () => json['number_of_titles']),
      category: decodeField('category', () => json['category']),
      title: decodeField('title', () => json['title']),
      shortSummary: decodeField('short_summary', () => json['short_summary']),
      didYouKnow: decodeField('did_you_know', () => json['did_you_know']),
      talkingPoints: decodeField(
          'talking_points', () => List<String>.from(json['talking_points'])),
      quote: decodeField('quote', () => json['quote']),
      quoteAuthor: decodeField('quote_author', () => json['quote_author']),
      quoteSourceUrl:
          decodeField('quote_source_url', () => json['quote_source_url']),
      quoteSourceDomain:
          decodeField('quote_source_domain', () => json['quote_source_domain']),
      location: decodeField('location', () => json['location']),
      perspectives: decodeField(
          'perspectives',
          () => (json['perspectives'] as List<dynamic>)
              .map((e) => Perspective.fromJson(e))
              .toList()),
      emoji: decodeField('emoji', () => json['emoji']),
      geopoliticalContext: decodeField(
          'geopolitical_context', () => json['geopolitical_context']),
      historicalBackground: decodeField(
          'historical_background', () => json['historical_background']),
      internationalReactions: decodeField(
          'international_reactions',
          () => json['international_reactions'] is String
              ? []
              : List<String>.from(json['international_reactions'] ?? [])),
      humanitarianImpact:
          decodeField('humanitarian_impact', () => json['humanitarian_impact']),
      economicImplications: decodeField(
          'economic_implications', () => json['economic_implications']),
      timeline: decodeField(
          'timeline',
          () => json['timeline'] is String
              ? []
              : List<String>.from(json['timeline'] ?? [])),
      futureOutlook:
          decodeField('future_outlook', () => json['future_outlook']),
      keyPlayers: decodeField(
          'key_players', () => List<String>.from(json['key_players'] ?? [])),
      businessAngleText:
          decodeField('business_angle_text', () => json['business_angle_text']),
      businessAnglePoints: decodeField('business_angle_points',
          () => List<String>.from(json['business_angle_points'] ?? [])),
      userActionItems: decodeField(
          'user_action_items',
          () => json['user_action_items'] is String
              ? []
              : List<String>.from(json['user_action_items'] ?? [])),
      scientificSignificance: decodeField('scientific_significance',
          () => List<String>.from(json['scientific_significance'] ?? [])),
      travelAdvisory: decodeField('travel_advisory',
          () => List<String>.from(json['travel_advisory'] ?? [])),
      destinationHighlights: decodeField(
          'destination_highlights', () => json['destination_highlights']),
      culinarySignificance: decodeField(
          'culinary_significance', () => json['culinary_significance']),
      performanceStatistics: decodeField('performance_statistics',
          () => List<String>.from(json['performance_statistics'] ?? [])),
      leagueStandings:
          decodeField('league_standings', () => json['league_standings']),
      diyTips: decodeField('diy_tips', () => json['diy_tips']),
      designPrinciples:
          decodeField('design_principles', () => json['design_principles']),
      userExperienceImpact: decodeField(
          'user_experience_impact', () => json['user_experience_impact']),
      gameplayMechanics: decodeField('gameplay_mechanics',
          () => List<String>.from(json['gameplay_mechanics'] ?? [])),
      industryImpact: decodeField('industry_impact',
          () => List<String>.from(json['industry_impact'] ?? [])),
      technicalSpecifications: decodeField(
          'technical_specifications', () => json['technical_specifications']),
      articles: decodeField(
          'articles',
          () => (json['articles'] as List<dynamic>)
              .map((e) => Article.fromJson(e))
              .toList()),
      domains: decodeField(
          'domains',
          () => (json['domains'] as List<dynamic>)
              .map((e) => Domain.fromJson(e))
              .toList()),
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
