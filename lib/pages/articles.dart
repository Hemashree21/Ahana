import 'package:flutter/material.dart';
import 'package:ahana/components/basePage.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticlePage extends StatelessWidget {
  final String activeSection;

  const ArticlePage({
    Key? key,
    this.activeSection = 'articles',  // Default to articles
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // "Continue Reading" Section
            const Text(
              "Continue Reading",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 10),
            ArticleCard(
              title: "A Beginner's Guide to Period Products",
              image: 'lib/assets/image1.jpeg',
              author: "Jane Doe",
              content:
              "Period products are essential for menstrual hygiene, and there are various options available to suit different needs and preferences. For beginners, it's important to know that these products are designed to absorb or collect menstrual blood. Here are some common options:\n\n"
                  "- *Pads*: Worn inside underwear, pads are absorbent and available in different sizes for day and night use.\n"
                  "- *Tampons*: Inserted into the vagina, tampons absorb menstrual flow internally and come with applicators or without.\n"
                  "- *Menstrual Cups*: Reusable, bell-shaped cups inserted into the vagina to collect menstrual blood; they are eco-friendly and can be worn for longer periods.\n"
                  "- *Period Underwear*: Specially designed underwear with built-in absorbency, ideal for light flow or as a backup.\n"
                  "- *Organic Products*: Made from natural materials like cotton, organic period products are a great option for those with sensitive skin or who want to avoid chemicals.\n\n"
                  "Each product type offers various levels of absorbency, and it may take some time to find the one that feels most comfortable for you.",
            ),
            const SizedBox(height: 20),

            // "Most Read Articles" Section
            const Text(
              "Most Read Articles",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            HorizontalArticleList(
              showSeeMoreButton: false,
              articles: [
                {
                  "title": "8 Home Remedies for Irregular Periods",
                  "image": "lib/assets/image2.jpeg",
                  "author": "Emma Brown",
                  "content":
                  "Discover natural remedies to address irregular periods, including dietary changes, herbal teas, and lifestyle adjustments. These tips aim to help you achieve a balanced menstrual cycle naturally.\n\n"
                      "1. *Healthy Diet*: Eating a balanced diet with whole grains, fruits, vegetables, and lean proteins is essential for hormone balance.\n"
                      "2. *Herbal Teas*: Herbal teas like ginger, cinnamon, and chamomile can help alleviate menstrual discomfort and regulate periods.\n"
                      "3. *Exercise Regularly*: Regular physical activity can help balance hormone levels and regulate menstrual cycles.\n"
                      "4. *Maintain a Healthy Weight*: Both underweight and overweight conditions can disrupt hormonal balance, leading to irregular periods.\n"
                      "5. *Reduce Stress*: Managing stress through activities like yoga or meditation can help reduce menstrual irregularities.\n"
                      "6. *Adequate Sleep*: Getting enough rest is crucial for hormone regulation and a regular menstrual cycle.\n"
                      "7. *Apple Cider Vinegar*: Some believe apple cider vinegar helps balance hormone levels and regulate periods.\n"
                      "8. *Massage*: A gentle abdominal massage with essential oils can stimulate blood flow and reduce cramps.\n\n"
                      "By incorporating these remedies into your lifestyle, you may notice improvements in the regularity of your periods.",
                },
                {
                  "title": "Top 6 Remedies for Teens",
                  "image": "lib/assets/image3.jpeg",
                  "author": "Dr. Lisa White",
                  "content":
                  "Teens often face unique menstrual challenges, and managing their cycle with the right remedies can help promote better health. Below are the top 6 remedies that are tailored specifically for teenagers to help them cope with menstrual issues:\n\n"
                      "- *Dietary Changes*: Encourage a balanced diet rich in vitamins and minerals, especially iron, magnesium, and vitamin B6, which help reduce cramps and fatigue.\n"
                      "- *Exercise*: Regular physical activity can alleviate period pain by increasing blood flow and reducing stress hormones.\n"
                      "- *Heat Therapy*: Using heating pads or hot water bottles can effectively reduce menstrual cramps and provide soothing relief.\n"
                      "- *Hydration*: Staying hydrated helps prevent bloating and reduces the intensity of headaches that can accompany periods.\n"
                      "- *Herbal Teas*: Drinking calming teas like ginger or chamomile can help reduce menstrual cramps and relax the body.\n"
                      "- *Stress Management*: Practicing relaxation techniques, such as deep breathing or yoga, can help teens manage stress, which can sometimes worsen menstrual symptoms."
                }
                ,
                {
                  "title": "Understanding Hormonal Imbalance",
                  "image": "lib/assets/image4.jpeg",
                  "author": "Sarah Green",
                  "content":
                  "Hormonal imbalance can have a significant impact on both physical and emotional health. It occurs when there is an excess or deficiency of certain hormones, leading to various symptoms and conditions. Understanding hormonal imbalance is essential for effective management. Here are the key points to know:\n\n"
                      "- *Causes of Hormonal Imbalance*: Common causes include stress, poor diet, lack of exercise, medical conditions like polycystic ovary syndrome (PCOS), thyroid disorders, and perimenopause.\n"
                      "- *Symptoms*: Symptoms can vary but may include irregular periods, weight gain, fatigue, mood swings, acne, hair loss, and sleep disturbances.\n"
                      "- *Diagnosis*: Hormonal imbalances can be diagnosed through blood tests that measure hormone levels, along with a thorough medical history and physical examination.\n"
                      "- *Treatment Options*: Treatments may include lifestyle changes, hormone replacement therapy, medications, and natural remedies such as herbal supplements to balance hormone levels.\n"
                      "- *Prevention*: Maintaining a healthy lifestyle through balanced nutrition, regular exercise, and stress management can help prevent or minimize hormonal imbalances."
                },
              ],
            ),
            const SizedBox(height: 20),

            // "Based on what you read" Section
            const Text(
              "Based on what you read",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            HorizontalArticleList(
              showSeeMoreButton: false,
              articles: [
                {
                  "title": "Menstrual Health: A Complete Guide",
                  "image": "lib/assets/image5.jpeg",
                  "author": "Sophia Lee",
                  "content":
                  "Menstrual health is an essential aspect of a woman’s overall well-being, encompassing not only the regularity of menstrual cycles but also the physical and emotional experiences surrounding menstruation. This guide provides valuable insights to understand menstrual health better. Key points to consider include:\n\n"
                      "- *Understanding the Menstrual Cycle*: The average menstrual cycle lasts about 28 days, though it can range from 21 to 35 days. It involves a series of hormonal changes that prepare the body for pregnancy. If pregnancy doesn't occur, the uterus sheds its lining, resulting in menstruation.\n"
                      "- *Common Menstrual Problems*: Some common issues include heavy bleeding (menorrhagia), painful periods (dysmenorrhea), irregular periods, and premenstrual syndrome (PMS). It's important to seek medical advice if these issues affect daily life.\n"
                      "- *Managing Menstrual Discomfort*: Over-the-counter pain relievers, heating pads, and gentle exercise can help alleviate cramps. Staying hydrated and consuming a balanced diet rich in fruits, vegetables, and whole grains also support menstrual health.\n"
                      "- *Tracking Your Cycle*: Tracking your cycle using an app or calendar can help identify patterns and irregularities. This practice is particularly useful for predicting ovulation and understanding fertility.\n"
                      "- *When to See a Doctor*: If you experience severe pain, missed periods, or irregular cycles, it’s crucial to consult with a healthcare provider. Conditions like polycystic ovary syndrome (PCOS) or fibroids may require medical intervention."
                },
                {
                  "title": "Natural Remedies for Menstrual Health",
                  "image": "lib/assets/image6.jpeg",
                  "author": "Anna Taylor",
                  "content":
                  "Maintaining menstrual health through natural remedies can provide relief from common menstrual issues like cramps, irregular cycles, and PMS. These remedies focus on promoting balance in the body using holistic approaches such as dietary changes, herbal treatments, and lifestyle adjustments. Key natural remedies include:\n\n"
                      "- *Herbal Teas*: Drinking herbal teas like ginger, chamomile, and peppermint can help reduce menstrual cramps, alleviate bloating, and ease stress. These herbs have anti-inflammatory and soothing properties that promote relaxation.\n"
                      "- *Dietary Adjustments*: A balanced diet rich in omega-3 fatty acids, magnesium, and antioxidants can support hormone balance and reduce menstrual discomfort. Incorporating foods like flaxseeds, walnuts, leafy greens, and salmon can be beneficial.\n"
                      "- *Exercise and Yoga*: Regular physical activity, including gentle exercises like yoga, can improve blood circulation, reduce cramps, and alleviate stress. Poses such as child’s pose, cat-cow, and forward bends help relieve tension in the lower back and abdomen.\n"
                      "- *Essential Oils*: Aromatherapy using essential oils like lavender and clary sage can help relax the body and reduce pain associated with menstruation. Massaging diluted essential oils into the abdomen may provide relief from cramps.\n"
                      "- *Acupuncture and Acupressure*: These traditional Chinese medicine techniques focus on stimulating specific points on the body to restore balance and alleviate menstrual symptoms like cramps and bloating.\n"
                      "- *Heat Therapy*: Applying heat to the abdomen using a heating pad or warm compress can relax muscles and reduce cramping. It’s one of the most commonly recommended natural remedies for menstrual discomfort."
                },
                {
                  "title": "Debunking Period Myths",
                  "image": "lib/assets/image7.jpeg",
                  "author": "Rachel Adams",
                  "content":
                  "There are numerous myths surrounding menstruation, often leading to misconceptions and unnecessary stigma. It's important to educate ourselves and debunk these myths to promote better understanding and comfort during periods. Here are some common period myths and the truths behind them:\n\n"
                      "- *Myth 1: You can’t get pregnant during your period*: While the chances of getting pregnant during your period are lower, it's still possible, especially if you have a shorter menstrual cycle or irregular periods. Sperm can live in the body for several days, so if you have unprotected sex near the end of your period, pregnancy is still a possibility.\n"
                      "- *Myth 2: Periods are always 28 days long*: Not all menstrual cycles are the same length. While 28 days is considered an average cycle, it’s normal for cycles to range between 21 and 35 days. Variations in cycle length can be influenced by age, stress, and health conditions.\n"
                      "- *Myth 3: You can’t swim while on your period*: This myth often prevents people from participating in swimming or water sports. With the right menstrual products like tampons or menstrual cups, it is safe to swim during your period without leakage.\n"
                      "- *Myth 4: Menstrual blood is dirty*: Menstrual blood is not impure or dirty. It is simply the shedding of the uterine lining, and the body has mechanisms to deal with it. This myth is rooted in social taboos and should be dispelled to reduce stigma.\n"
                      "- *Myth 5: Tampons can get lost inside your body*: Tampons cannot get lost inside the vagina. If a tampon is inserted correctly, it will remain in place until you remove it. It is important to remember to remove tampons within the recommended time frame to avoid health risks.\n"
                      "- *Myth 6: You don’t need to worry about period hygiene*: Maintaining proper menstrual hygiene is essential for preventing infections and irritations. Regularly changing menstrual products and cleaning the genital area with mild soap and water is important for good hygiene.\n"
                      "- *Myth 7: Periods should be pain-free*: While some discomfort is common, excessive pain during periods could indicate underlying health issues such as endometriosis or fibroids. If period pain is severe or interferes with daily life, it's advisable to consult a healthcare provider."
                },
              ],
            ),
          ],
        ),
    );
  }
}

class HorizontalArticleList extends StatelessWidget {
  final bool showSeeMoreButton;
  final List<Map<String, String>> articles;

  const HorizontalArticleList({
    Key? key,
    required this.showSeeMoreButton,
    required this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Padding(
            padding: EdgeInsets.only(right: index == articles.length - 1 ? 0 : 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BasePage(
                        activeSection: 'articles',
                        body: ArticleDetailPage(
                          title: article["title"]!,
                          image: article["image"]!,
                          author: article["author"]!,
                          content: article["content"]!,
                        ),
                    )
                  ),
                );
              },
              child: SmallArticleCard(
                title: article["title"]!,
                image: article["image"]!,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String author;
  final String content;

  const ArticleDetailPage({
    Key? key,
    required this.title,
    required this.image,
    required this.author,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Article Title
            Text(
              title,
              style: GoogleFonts.lora(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 8),

            // Author Name
            Text(
              "By $author",
              style: GoogleFonts.roboto(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Article Content
            Text(
              content,
              style: GoogleFonts.roboto(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
    );
  }
}

class SmallArticleCard extends StatelessWidget {
  final String title;
  final String image;

  const SmallArticleCard({Key? key, required this.title, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String title;
  final String image;
  final String author;
  final String content;

  const ArticleCard({
    Key? key,
    required this.title,
    required this.image,
    required this.author,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BasePage(
              activeSection: 'articles',  // Keep articles selected
              body: ArticleDetailPage(
                title: title,
                image: image,
                author: author,
                content: content,
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.7), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}