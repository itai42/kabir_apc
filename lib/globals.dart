import 'package:flutter/material.dart';
import 'package:kabir_apc/ds/comment.dart';
import 'package:kabir_apc/ds/entry.dart';
import 'package:kabir_apc/ds/rating.dart';
import 'package:kabir_apc/ds/user.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'utils/utils.dart';

List<KabUser> users = [
  KabUser(handle: 'a', name: 'A a', isDev: false),
  KabUser(handle: 'b', name: 'B b', isDev: false),
  KabUser(handle: 'c', name: 'C c', isDev: false),
  KabUser(handle: 'dev', name: 'Dev dave', isDev: true),
  KabUser(handle: 'e', name: 'E e', isDev: false),
];
KabUser currentUser = users[0];
List<KabEntry> entries = [
  KabEntry(
    title: 'entryA qqwwee',
    byUser: users[0],
    text: 'entryA  qqwwdd',
    comments: {
      'pro': [
        KabComment(byUser: users[1], title: 'BP title', comment: 'B is pro just because', rating: {
          'up': [
            KarmaVoteRating(byUser: users[4], ofFlavor: 'up', weight: 1.0),
            KarmaVoteRating(byUser: users[2], ofFlavor: 'up', weight: 1.0),
          ],
          'down': [
            KarmaVoteRating(byUser: users[1], ofFlavor: 'down', weight: 1.0),
          ],
        }),
        KabComment(byUser: users[4], title: 'EP title', comment: 'E is pro just because', rating: {}),
        KabComment(byUser: users[3], title: 'DevPro title', comment: 'Dev is pro just because', rating: {}),
      ],
      'con': [
        KabComment(byUser: users[2], title: 'CC title', comment: 'C is con just because', rating: {}),
      ],
    },
  ),
  KabEntry(
    title: 'entryB:',
    byUser: users[1],
    text: 'entryB qqwwdd',
    comments: {
      'pro': [
        KabComment(byUser: users[0], title: 'AP title', comment: 'A is pro just because', rating: {
          'up': [
            KarmaVoteRating(byUser: users[0], ofFlavor: 'up', weight: 1.0),
          ],
          'down': [
            KarmaVoteRating(byUser: users[4], ofFlavor: 'down'),
            KarmaVoteRating(byUser: users[3], ofFlavor: 'down'),
          ],
        }),
      ],
      'con': [
        KabComment(byUser: users[2], title: 'CC title', comment: 'C is con just because', rating: {}),
      ],
    },
  ),
  KabEntry(title: 'entryC', byUser: users[2], text: 'entryC'),
  KabEntry(title: 'entryD', byUser: users[2], text: 'entryD'),
  KabEntry(
    title: 'entryE:',
    byUser: users[3],
    text: 'entryE dd',
    comments: {
      'pro': [
        KabComment(byUser: users[0], title: 'AP title', comment: 'A is pro just because', rating: {
          'up': [
            KarmaVoteRating(byUser: users[1], ofFlavor: 'up', weight: 1.0),
          ],
          'down': [
            KarmaVoteRating(byUser: users[1], ofFlavor: 'down', weight: 1.0),
            KarmaVoteRating(byUser: users[2], ofFlavor: 'down', weight: 1.0),
            KarmaVoteRating(byUser: users[4], ofFlavor: 'down', weight: 1.0),
          ],
        }),
      ],
      'con': [
        KabComment(byUser: users[1], comment: 'B is con just because', title: 'BC title', rating: {
          'down': [
            KarmaVoteRating(byUser: users[1], ofFlavor: 'down', weight: 1.0),
          ],
        }),
      ],
    },
  ),
];

PausableChangeNotifier<bool> isShiftDown = PausableChangeNotifier<bool>(value: false);
PausableChangeNotifier<bool> isCtlDown = PausableChangeNotifier<bool>(value: false);
PausableChangeNotifier<bool> isAltDown = PausableChangeNotifier<bool>(value: false);
bool isADown = false;
bool isSpaceDown = false;
// SingleValueChangeNotifier<LaAction?> targetActionNotifier = SingleValueChangeNotifier<LaAction?>(null);
SingleValueChangeNotifier<Size> desktopSizeNotifier = SingleValueChangeNotifier<Size>(const Size(400,400));
SingleValueChangeNotifier<Offset> currentDesktopPositionNotifier = SingleValueChangeNotifier<Offset>(const Offset(0,0));
SingleValueChangeNotifier<Size> currentDesktopScaleNotifier = SingleValueChangeNotifier<Size>(const Size(1,1));
SingleValueChangeNotifier<Offset> currentDesktopTopLeftNotifier = SingleValueChangeNotifier<Offset>(const Offset(0,0));
// ChangeNotifierProvider
// ChangeNotifierProvider<SingleValueChangeNotifier<LaAction?>> targetActionProvider = ChangeNotifierProvider<SingleValueChangeNotifier<LaAction?>>((ref) => targetActionNotifier);
ChangeNotifierProvider<SingleValueChangeNotifier<Offset>> currentDesktopPositionProvider = ChangeNotifierProvider<SingleValueChangeNotifier<Offset>>((ref) => currentDesktopPositionNotifier);
ChangeNotifierProvider<SingleValueChangeNotifier<Size>> currentDesktopScaleProvider = ChangeNotifierProvider<SingleValueChangeNotifier<Size>>((ref) => currentDesktopScaleNotifier);
ChangeNotifierProvider<SingleValueChangeNotifier<Offset>> currentDesktopTopLeftProvider = ChangeNotifierProvider<SingleValueChangeNotifier<Offset>>((ref) => currentDesktopTopLeftNotifier);
