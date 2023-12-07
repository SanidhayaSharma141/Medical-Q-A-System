import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuestionAnswerWidget extends StatefulWidget {
  @override
  _QuestionAnswerWidgetState createState() => _QuestionAnswerWidgetState();
}

class _QuestionAnswerWidgetState extends State<QuestionAnswerWidget> {
  TextEditingController _questionController = TextEditingController();
  String _answer = '';

  Future<void> _getAnswer() async {
    String question = _questionController.text;
    // String context =
    //     "A heart attack, clinically referred to as a myocardial infarction (MI), is a critical and potentially life-threatening cardiovascular event that arises from a disruption in the blood supply to a part of the heart muscle. This interruption is commonly triggered by the abrupt formation of a blood clot within a coronary artery, impeding the flow of oxygenated blood to the heart. Often occurring in the context of atherosclerosis, where fatty deposits accumulate along the arterial walls, a heart attack manifests as a severe ischemic injury to the affected cardiac tissue. The hallmark symptom of a heart attack is intense chest pain or discomfort, typically characterized by a crushing or squeezing sensation. This pain may radiate to the arms, neck, jaw, or back and is frequently accompanied by associated symptoms such as shortness of breath, nausea, lightheadedness, and profuse sweating. The expeditious recognition of these signs is paramount, as immediate medical attention significantly influences the prognosis. In a medical emergency, timely interventions such as thrombolytic therapy to dissolve the clot, percutaneous coronary intervention (PCI) or angioplasty to restore blood flow, and, in severe cases, coronary artery bypass grafting (CABG) may be employed. Post-heart attack, a comprehensive cardiac rehabilitation program, including lifestyle modifications, medications, and regular monitoring, is crucial for optimal recovery and reducing the risk of recurrent events. The multifaceted nature of heart attacks underscores the importance of public awareness, proactive risk factor management, and ongoing advancements in cardiovascular research and healthcare delivery to combat this pervasive and life-altering medical condition. The coronavirus, specifically the novel coronavirus SARS-CoV-2, has had an indelible impact on global health, societies, and economies. First identified in Wuhan, China, in late 2019, the virus quickly spread, leading to the declaration of a pandemic by the World Health Organization in March 2020. The COVID-19 disease, caused by the virus, presents a spectrum of symptoms ranging from mild respiratory issues to severe pneumonia, acute respiratory distress syndrome (ARDS), and, in some cases, death. The virus primarily spreads through respiratory droplets, prompting widespread public health measures such as social distancing, mask-wearing, and lockdowns to curb transmission. The pandemic has strained healthcare systems worldwide, exposing vulnerabilities and necessitating rapid adaptations to cope with the surge in cases. Efforts to combat the virus have included extensive vaccination campaigns, the development and deployment of various vaccines at an unprecedented pace, and ongoing research to understand the virus's variants and their potential implications. Beyond the immediate health impact, the pandemic has triggered economic challenges, disrupted global supply chains, and highlighted societal inequities. The response to the coronavirus has showcased both the resilience of communities and the need for international collaboration in the face of global health crises. As the world continues to grapple with the virus, ongoing vaccination efforts, scientific research, and public health strategies remain critical to overcoming the challenges posed by COVID-19 and preventing future pandemics. Cancer, a complex and pervasive group of diseases, is characterized by the uncontrolled and abnormal growth of cells that can invade and spread to other parts of the body. This condition, which can affect virtually any tissue or organ, represents a formidable challenge to global health. Cancer manifests in various forms, each with distinct characteristics, behaviors, and treatment strategies. The disease often arises due to genetic mutations, environmental factors, or a combination of both, leading to the disruption of normal cellular functions that regulate growth and division. Diagnosing cancer involves a combination of imaging studies, biopsies, and laboratory tests to determine the type, stage, and grade of the malignancy. Treatment modalities encompass surgery, chemotherapy, radiation therapy, immunotherapy, and targeted therapies, with the choice depending on the cancer type and its stage. While advancements in medical research have improved early detection and treatment outcomes, cancer remains a leading cause of morbidity and mortality worldwide. The physical and emotional toll on individuals facing a cancer diagnosis, as well as their families and caregivers, is profound. Beyond the clinical realm, efforts to address cancer extend to preventive measures, lifestyle modifications, and ongoing research into the molecular and genetic underpinnings of the disease. Cancer research has paved the way for innovative therapies, personalized medicine approaches, and a deeper understanding of the complex factors contributing to cancer development. Moreover, the importance of cancer awareness, screening programs, and support networks cannot be overstated in fostering a comprehensive approach to cancer care. As the scientific and medical communities continue their dedicated efforts, a holistic understanding of cancer, coupled with advancements in prevention, early detection, and treatment, holds the promise of mitigating the impact of this formidable health challenge on individuals and societies globally.Mental health, an integral component of overall well-being, encompasses emotional, psychological, and social aspects that contribute to an individual's ability to cope with stress, navigate life's challenges, and maintain fulfilling relationships. It is not merely the absence of mental disorders but rather a state of mental well-being where individuals can realize their own potential, cope with the normal stresses of life, work productively, and contribute to their communities. Mental health conditions, ranging from mood and anxiety disorders to more severe illnesses such as schizophrenia, affect millions of people globally. These conditions can result from a combination of genetic, biological, environmental, and lifestyle factors. The stigma surrounding mental health often hampers open discussions and seeking help, leading to delayed or inadequate treatment. Mental health care involves a multifaceted approach, encompassing therapy, counseling, medication, and support networks. Prevention efforts emphasize the importance of early intervention, stress management, and promoting resilience. The recognition of mental health as a global public health priority has grown, prompting advocacy for increased awareness, improved access to mental health services, and destigmatization. The impact of mental health extends beyond the individual, influencing families, workplaces, and communities at large. As societies grapple with the challenges posed by mental health, fostering supportive environments, promoting mental health education, and ensuring access to quality mental health care are critical components of a comprehensive approach to enhancing mental well-being for all.";

    try {
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5000/answer'), // Replace with your server address
        headers: {'Content-Type': 'application/json'},

        body: jsonEncode({'question': question, 'context': selectedOption}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _answer = data['answer'];
        });
      } else {
        setState(() {
          _answer = 'Failed to get answer';
        });
      }
    } catch (e) {
      setState(() {
        _answer = 'Error: $e';
      });
    }
  }

  String selectedOption = "Not Selected";

  final contextData = {
    "Not Selected":
        "A heart attack, scientifically known as a myocardial infarction, is a critical and potentially life-threatening medical event that occurs when blood flow to a part of the heart muscle is blocked. This obstruction is often the result of a blood clot forming in a coronary artery, which supplies the heart with oxygen and nutrients. The lack of blood flow leads to damage or death of the heart muscle cells. The most common cause of heart attacks is the buildup of fatty deposits, cholesterol, and other substances, collectively termed plaque, on the inner walls of coronary arteries. When a plaque ruptures, it triggers the formation of a blood clot that can block the flow of blood to the heart. Cancer is a complex and multifaceted group of diseases characterized by the uncontrolled division and growth of abnormal cells in the body. It can occur in virtually any tissue or organ, and there are more than 100 different types of cancer, each with its unique characteristics and behavior. The development of cancer is often driven by genetic mutations that accumulate over time, disrupting the normal regulatory mechanisms that control cell growth and division. Diabetes is a chronic medical condition characterized by elevated levels of blood glucose, commonly referred to as blood sugar. The two main types of diabetes are Type 1 and Type 2, with distinct causes and characteristics. In Type 1 diabetes, the immune system mistakenly attacks and destroys the insulin-producing beta cells in the pancreas, leading to a deficiency of insulin—a hormone crucial for regulating blood sugar. On the other hand, Type 2 diabetes involves the body's inability to use insulin effectively or produce enough of it. This often relates to lifestyle factors, including poor diet, sedentary behavior, and obesity. Diabetes can result in a range of complications, affecting various organs and systems, such as the eyes, kidneys, nerves, and cardiovascular system. Mental health is a critical aspect of overall well-being, encompassing emotional, psychological, and social dimensions. It is not merely the absence of mental disorders but a state of balance that allows individuals to cope with the stresses of life, work productively, build positive relationships, and contribute to their communities. Mental health conditions, ranging from anxiety and depression to more severe disorders like schizophrenia, affect millions of people worldwide. These conditions can be influenced by a combination of genetic, biological, environmental, and lifestyle factors. The stigma surrounding mental health often prevents individuals from seeking help, exacerbating the impact of these conditions. he coronavirus, specifically referring to the novel coronavirus SARS-CoV-2 and the disease it causes, COVID-19, has profoundly impacted the global landscape. First identified in late 2019 in Wuhan, China, the virus rapidly spread across the world, leading to a pandemic. COVID-19 is primarily transmitted through respiratory droplets, prompting widespread public health measures such as social distancing, mask-wearing, and lockdowns to mitigate its spread. The virus has demonstrated a wide range of symptoms, from mild respiratory issues to severe pneumonia, with certain populations, particularly the elderly and those with underlying health conditions, being more vulnerable to severe outcomes. ",
    "Heart attack":
        "A heart attack, scientifically known as a myocardial infarction, is a critical and potentially life-threatening medical event that occurs when blood flow to a part of the heart muscle is blocked. This obstruction is often the result of a blood clot forming in a coronary artery, which supplies the heart with oxygen and nutrients. The lack of blood flow leads to damage or death of the heart muscle cells. The most common cause of heart attacks is the buildup of fatty deposits, cholesterol, and other substances, collectively termed plaque, on the inner walls of coronary arteries. When a plaque ruptures, it triggers the formation of a blood clot that can block the flow of blood to the heart. The symptoms of a heart attack can vary but often include chest pain or discomfort, shortness of breath, nausea, lightheadedness, and sweating. Prompt medical attention is crucial in the event of a heart attack, as timely intervention can minimize damage to the heart muscle and improve the chances of survival. Treatment may involve medications to dissolve clots, procedures such as angioplasty to open blocked arteries, or in severe cases, surgery to bypass the blocked artery. Lifestyle changes, including a heart-healthy diet, regular exercise, and smoking cessation, are essential for long-term recovery and reducing the risk of future heart events. Public awareness and education on recognizing and responding to the symptoms of a heart attack play a crucial role in saving lives and promoting cardiovascular health.",
    "Cancer":
        "Cancer is a complex and multifaceted group of diseases characterized by the uncontrolled division and growth of abnormal cells in the body. It can occur in virtually any tissue or organ, and there are more than 100 different types of cancer, each with its unique characteristics and behavior. The development of cancer is often driven by genetic mutations that accumulate over time, disrupting the normal regulatory mechanisms that control cell growth and division. These mutations can be caused by a variety of factors, including genetic predisposition, exposure to carcinogens such as tobacco smoke and certain chemicals, as well as viral infections. Cancer cells have the ability to invade surrounding tissues and can metastasize, spreading to other parts of the body through the bloodstream or lymphatic system. The impact of cancer on individuals and their families is profound, encompassing physical, emotional, and financial challenges. Diagnosis often marks the beginning of a difficult journey involving aggressive treatments such as surgery, chemotherapy, radiation therapy, immunotherapy, or a combination of these approaches. The side effects of these treatments can be debilitating, affecting not only the cancer cells but also healthy tissues. Additionally, the emotional toll of cancer, for both patients and their loved ones, is immense, requiring resilience, support, and a comprehensive approach to care. Advancements in medical research and technology have led to significant progress in understanding the molecular mechanisms of cancer and developing targeted therapies tailored to specific genetic abnormalities. Early detection through screening and improved diagnostic tools has also played a crucial role in enhancing treatment outcomes. However, challenges persist, and the quest for more effective treatments and ultimately a cure remains a top priority in the global fight against cancer. Cancer awareness, prevention, and education are integral components of comprehensive cancer control strategies. Encouraging healthy lifestyle choices, promoting vaccination against cancer-associated viruses, and fostering early detection through regular screenings are vital for reducing the burden of cancer on individuals and society as a whole. Supportive care, including psychosocial and palliative interventions, is essential to enhance the quality of life for those affected by cancer. Moreover, fostering a collaborative and interdisciplinary approach among healthcare professionals, researchers, policymakers, and the community is fundamental to addressing the multifaceted challenges posed by cancer and working towards a future where cancer is not only treatable but preventable.",
    "Diabetes":
        "Diabetes is a chronic medical condition characterized by elevated levels of blood glucose, commonly referred to as blood sugar. The two main types of diabetes are Type 1 and Type 2, with distinct causes and characteristics. In Type 1 diabetes, the immune system mistakenly attacks and destroys the insulin-producing beta cells in the pancreas, leading to a deficiency of insulin—a hormone crucial for regulating blood sugar. On the other hand, Type 2 diabetes involves the body's inability to use insulin effectively or produce enough of it. This often relates to lifestyle factors, including poor diet, sedentary behavior, and obesity. Diabetes can result in a range of complications, affecting various organs and systems, such as the eyes, kidneys, nerves, and cardiovascular system. Common symptoms include increased thirst, frequent urination, unexplained weight loss, and fatigue. Proper management of diabetes involves lifestyle modifications, including a healthy diet, regular physical activity, and, in some cases, medication or insulin therapy. Monitoring blood sugar levels, maintaining a healthy weight, and regular medical check-ups are crucial components of diabetes care. Education and awareness about the condition are essential for prevention and early intervention, reducing the risk of complications and improving the overall well-being of individuals living with diabetes.",
    "Mental Health":
        "Mental health is a critical aspect of overall well-being, encompassing emotional, psychological, and social dimensions. It is not merely the absence of mental disorders but a state of balance that allows individuals to cope with the stresses of life, work productively, build positive relationships, and contribute to their communities. Mental health conditions, ranging from anxiety and depression to more severe disorders like schizophrenia, affect millions of people worldwide. These conditions can be influenced by a combination of genetic, biological, environmental, and lifestyle factors. The stigma surrounding mental health often prevents individuals from seeking help, exacerbating the impact of these conditions. Efforts to promote mental health involve destigmatizing conversations, fostering supportive communities, and increasing access to mental health services. Prevention and early intervention are key components of effective mental health care, emphasizing the importance of education, awareness, and creating environments that prioritize emotional well-being. Recognizing mental health as an integral part of overall health is crucial for building a society that values and supports the mental well-being of every individual.",
    "Coronavirus":
        "The coronavirus, specifically referring to the novel coronavirus SARS-CoV-2 and the disease it causes, COVID-19, has profoundly impacted the global landscape. First identified in late 2019 in Wuhan, China, the virus rapidly spread across the world, leading to a pandemic. COVID-19 is primarily transmitted through respiratory droplets, prompting widespread public health measures such as social distancing, mask-wearing, and lockdowns to mitigate its spread. The virus has demonstrated a wide range of symptoms, from mild respiratory issues to severe pneumonia, with certain populations, particularly the elderly and those with underlying health conditions, being more vulnerable to severe outcomes. The pandemic has strained healthcare systems, challenged economies, and altered daily life for billions of people. Vaccination campaigns have been a critical tool in combating the virus, offering hope for eventual control and a return to normalcy. The pandemic has also highlighted the importance of global collaboration in addressing public health crises and the need for preparedness to navigate the complex challenges posed by emerging infectious diseases.",
  };
  // List<DropdownMenuItem> items[]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Q/A System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          DropdownButton<String>(
            value: selectedOption,
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue!;
              });
            },
            items: [
              "Not Selected",
              "Heart attack",
              "Cancer",
              "Diabetes",
              "Mental Health",
              "Coronavirus",
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextField(
            controller: _questionController,
            decoration: InputDecoration(labelText: 'Enter your question'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _getAnswer,
            child: Text('Get Answer'),
          ),
          SizedBox(height: 16.0),
          Text(
            'Answer: $_answer',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QuestionAnswerWidget(),
  ));
}
