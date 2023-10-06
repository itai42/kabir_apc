import 'package:flutter/material.dart';
import 'package:kabir_apc/ds/entry.dart';
import 'package:sem_form_core/sem_form_core.dart';
import 'package:simple_html_css/simple_html_css.dart';

class AbstractSlate extends StatelessWidget {
  final KabEntry entry;
  final bool includeSummary;

  const AbstractSlate(this.entry, {super.key, this.includeSummary = false});

  @override
  Widget build(BuildContext context) {
    return includeSummary ? buildWithSummary(context) : buildNoSummary(context);
  }

  Widget buildNoSummary(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            RichText(
              text: HTML.toTextSpan(
                context,
                '<B><a href="#title_clicked"><div style="font-size: 16px;color: green; text-decoration: none;">${entry.title.addPostfix(":")}</div></a></B>',
                linksCallback: (p0) {
                  print(p0);
                },
              ),
            ),
            TextFormField(
              initialValue: entry.text,
              // 'One recent approach formalizes agents as systems that would adapt their policy if their actions influenced the world in a different way. Notice the close connection to empowerment, which suggests a related definition that agents are systems which maintain power potential over the future: having action output streams with high channel capacity to future world states. This all suggests that agency is a very general extropic concept and relatively easy to recognize.',
              minLines: 1,
              maxLines: 5,
              readOnly: true,
              decoration: const InputDecoration(hintText: '', filled: false, border: InputBorder.none, isCollapsed: true),
              style: theme.textTheme.bodyMedium,
            ),
          ]),
        ));
  }

  Widget buildWithSummary(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  RichText(
                    text: HTML.toTextSpan(context, '<B><div style="font-size: 16px;">${entry.title.addPostfix(":")}</div></B>'),
                  ),
                  TextFormField(
                    initialValue: entry.text,
                    // 'One recent approach formalizes agents as systems that would adapt their policy if their actions influenced the world in a different way. Notice the close connection to empowerment, which suggests a related definition that agents are systems which maintain power potential over the future: having action output streams with high channel capacity to future world states. This all suggests that agency is a very general extropic concept and relatively easy to recognize.',
                    minLines: 1,
                    maxLines: 5,
                    readOnly: true,

                    decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: '',
                      filled: false,
                      contentPadding: const EdgeInsets.only(bottom: 4),
                      alignLabelWithHint: true,
                      // border: InputBorder.none,
                      // isCollapsed: true,
                      counter: Wrap(
                        children: [
                          Tooltip(waitDuration: const Duration(milliseconds: 350), decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: const BorderRadius.all(Radius.circular(8))),
                            richMessage: HTML.toTextSpan(
                              context,
                              '<a href="#title_tooltip_pro_clicked"><ul style="font-size: 12px; text-decoration: none;"><li><B><U>Pro Comments:</U></B></li><BR/>${entry.proComments.map((c) => '<li><B>${c.title}:</B> ${c.comment}</li>').join('')}</ul></a>',
                              linksCallback: (p0) {
                                print('tooltip pro link: $p0');
                              },
                            ),
                            child: RichText(
                              softWrap: true,
                              text: HTML.toTextSpan(context, '<B>${entry.proComments.length}</B> pro comments,'),
                              // text: HTML.toTextSpan(context, '<a href="#title_tooltip_pro_clicked"><div style="font-size: 12px; text-decoration: none;">${entry.proComments.map((c) => '<B>${c.title}:</B> ${c.comment}</B>').join('<BR/>')}</div></a>',)
                            ),),
                          Tooltip(waitDuration: const Duration(milliseconds: 350), decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: const BorderRadius.all(Radius.circular(8))),
                            richMessage: HTML.toTextSpan(
                              context,
                              '<B><a href="#title_tooltip_con_clicked"><ul style="font-size: 12px; text-decoration: none;"><li><B><U>Con Comments:</U></B></li>${entry.conComments.map((c) => '<li><B>${c.title}:</B> ${c.comment}</li>').join('')}</ul></a>',
                              linksCallback: (p0) {
                                final t = '<a href="#title_tooltip_pro_clicked">qqq<div style="font-size: 12px; text-decoration: none;">${entry.proComments.map((c) => '<B>${c.title}:</B> ${c.comment}</B>').join('<BR/>')}</div></a>';
                                print('$t \n tooltip con link: $p0');
                              },
                            ),
                            child: RichText(
                              softWrap: true,
                              text: HTML.toTextSpan(context, ' <B>${entry.conComments.length}</B> con comments'),
                            ),),
                        ],
                      ),
                    ),
                    style: theme.textTheme.bodyMedium,
                  ),
                ]),
              ))),
      const Divider(color: Color(0xAA337ACB), height: 3, thickness: 3),
    ]);
  }
}
