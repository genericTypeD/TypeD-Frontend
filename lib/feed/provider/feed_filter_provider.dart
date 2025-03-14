import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FeedFilter { all, review, sentence }

final feedFilterProvider = StateProvider<FeedFilter>((ref) => FeedFilter.all);
