import 'package:flutter/material.dart';
import 'package:langchain_openai/langchain_openai.dart';

import 'ds_widgets/entry_list.dart';

// import 'up_down_vote.dart';

//cat ../kabir_apc_keys/dreamhost-git-key.pub | ssh dh_zmr4k4@iad1-shared-e1-05.dreamhost.com "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"
//git remote add dreamhost ssh://dh_zmr4k4@iad1-shared-e1-05.dreamhost.com/~/kumar.semform.com.git

import 'package:fss/fss.dart';
import 'widgets/panels_page.dart';
const OPENAI_API_KEY='sk-111111111111111111111111111111111111111111111111';
const OPENAI_API_BASE='http://127.0.0.1:5001';

final llm = ChatOpenAI(apiKey: OPENAI_API_KEY, temperature: 0.9, apiClient: OpenAIClient.local(OPENAI_API_BASE), model: 'TheBloke_airoboros-13B-gpt4-1.3-GPTQ');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI plans',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const PanelsPage(title: 'AI plans list'),
    );
  }
}
