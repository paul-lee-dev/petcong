import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petcong/models/card_profile_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchedCard extends StatefulWidget {
  final CardProfileModel matchedUser;
  const MatchedCard({Key? key, required this.matchedUser}) : super(key: key);

  @override
  State<MatchedCard> createState() => _MatchedCardState();
}

class _MatchedCardState extends State<MatchedCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print("matchedUser nickname onTap:}");
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  ProfileDetailPage(matchedUser: widget.matchedUser)),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.matchedUser.profileImageUrls![0],
              child: AspectRatio(
                aspectRatio: 1,
                // child: Image.network(widget.matchedUser.profileImageUrls![0],
                //     fit: BoxFit.cover),
                child: CachedNetworkImage(
                    imageUrl: widget.matchedUser.profileImageUrls![0],
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover),
              ),
            ),
            Text(widget.matchedUser.nickname,
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailPage extends StatefulWidget {
  final CardProfileModel matchedUser;

  const ProfileDetailPage({Key? key, required this.matchedUser})
      : super(key: key);

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.matchedUser.nickname),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: widget.matchedUser.profileImageUrls![0],
              child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                      imageUrl: widget.matchedUser.profileImageUrls![0],
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(height: 10),
            Text(widget.matchedUser.description!),
            const SizedBox(height: 10),
            IconButton(
              icon: const Icon(Icons.link),
              onPressed: () async {
                final url = Uri.parse(
                    'http://www.instagram.com/${widget.matchedUser.instagramId}');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch https://instagram.com/${widget.matchedUser.instagramId}}';
                }
              },
            ),
            const SizedBox(height: 10),
            Text('Kakao ID: ${widget.matchedUser.kakaoId}'),
          ],
        ),
      ),
    );
  }
}
