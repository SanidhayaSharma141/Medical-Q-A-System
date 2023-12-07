from flask import Flask, request, jsonify
from transformers import BertTokenizer, BertForQuestionAnswering
import torch
app = Flask(__name__)





contextData = {
    "Not Selected": "hi",
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
  }
# Load the BERT model and tokenizer
model = BertForQuestionAnswering.from_pretrained('deepset/bert-base-cased-squad2')
tokenizer = BertTokenizer.from_pretrained('deepset/bert-base-cased-squad2')

@app.route('/answer', methods=['POST'])
def answer_question():
    data = request.json
    answer= "Sorry, but no matches found."
    user_question = data.get('question', '')
    user_co = data.get('context', '')
    user_context=contextData[user_co]
    if user_co!="Not Selected":
        # If context is provided, use it for inference
        input_data = tokenizer(user_question, user_context, return_tensors="pt")
        output = model(**input_data)
        start_index = output.start_logits.argmax()
        end_index = output.end_logits.argmax() + 1
        answer = tokenizer.decode(input_data.input_ids[0, start_index:end_index])
    else:
       answer= "Sorry, but no matches found."



    return jsonify({'answer': answer})


# @app.route('/answer', methods=['POST'])
# def answer_question():
#     data = request.json
#     # print(contextData)
#     user_question = data.get('question', '')
#     print(user_question)
#     context_data = contextData

#     best_answer = None
#     best_score = float('-inf')

#     for context_name, user_context in context_data.items():
#         # Tokenize the input for each context
#         input_data = tokenizer(user_question, user_context, return_tensors="pt", truncation=True, padding=True)

#         # Perform inference
#         output = model(**input_data)
#         start_index = output.start_logits.argmax()
#         end_index = output.end_logits.argmax() + 1
#         answer = tokenizer.decode(input_data.input_ids[0, start_index:end_index])

#         # Use the score to determine the best answer
#         score = output.start_logits[start_index] + output.end_logits[end_index - 1]

#         if answer and score > best_score:

#             best_score = score
#             best_answer = answer

#     return jsonify({'answer': best_answer})


if __name__ == '__main__':
    app.run(debug=True)



# from flask import Flask, request, jsonify
# from transformers import BertTokenizer, BertForQuestionAnswering
# import torch

# app = Flask(__name__)

# # Load the BERT model and tokenizer
# model = BertForQuestionAnswering.from_pretrained('deepset/bert-base-cased-squad2')
# tokenizer = BertTokenizer.from_pretrained('deepset/bert-base-cased-squad2')
# medical_paragraphs = [
#     "Cardiovascular diseases, including heart attacks and strokes, continue to be leading causes of mortality globally. Efforts to combat these diseases involve preventive measures such as lifestyle modifications, early detection, and advanced medical interventions like coronary artery bypass surgery and angioplasty.",
    
#     "The human nervous system, a complex network of neurons, plays a vital role in transmitting signals between the brain and various parts of the body. Neurological disorders, such as Alzheimer's disease and Parkinson's disease, present significant challenges in terms of understanding their etiology and developing effective treatments.",
    
#     "In the realm of infectious diseases, the ongoing global fight against viruses and bacteria underscores the importance of vaccinations, antibiotics, and antiviral medications. Recent advances in vaccine technology have played a crucial role in combating outbreaks of diseases like COVID-19.",
    
#     "Cancer, characterized by uncontrolled cell growth, remains a major health concern worldwide. Comprehensive cancer care involves a combination of surgery, chemotherapy, radiation therapy, and immunotherapy, with ongoing research focused on targeted therapies and personalized medicine approaches.",
    
#     "The field of genetics and genomics has witnessed remarkable progress in unraveling the genetic basis of various medical conditions. Genetic testing and personalized medicine are becoming integral components of healthcare, providing tailored treatments based on an individual's genetic profile.",
    
#     "Mental health, a critical aspect of overall well-being, has gained increased attention in recent years. Addressing mental health challenges involves a holistic approach, including therapy, medication, and community support, with an emphasis on reducing stigma and promoting mental health education.",
    
#     "Advancements in medical imaging technologies, such as MRI and CT scans, have revolutionized the diagnosis and monitoring of various medical conditions. These non-invasive techniques offer detailed insights into the structure and function of organs, aiding in precise medical interventions.",
    
#     "The importance of a well-functioning healthcare system is evident in the ongoing efforts to improve accessibility, affordability, and quality of medical care. Health policy, medical ethics, and healthcare innovations play pivotal roles in shaping the future of healthcare delivery.",
    
#     "The role of healthcare professionals, including doctors, nurses, and allied health professionals, is crucial in providing patient-centered care. Ongoing medical education and training are essential for staying abreast of advancements in medical science and technology.",
    
#     "Global health challenges, such as pandemics and emerging infectious diseases, highlight the interconnectedness of the world's populations. Collaborative efforts in medical research, international health policy, and public health initiatives are key components in addressing these challenges."
# ]
