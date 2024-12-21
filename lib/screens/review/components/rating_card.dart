import 'package:flutter/material.dart';

const double defaultPadding = 16.0;
const double defaultBorderRadious = 8.0;
const Color warningColor = Colors.amber;

class RatingCard extends StatelessWidget {
  const RatingCard({
    super.key,
    required this.rating,
    required this.numOfReviews,
    this.numOfFiveStar = 0,
    this.numOfFourStar = 0,
    this.numOfThreeStar = 0,
    this.numOfTwoStar = 0,
    this.numOfOneStar = 0,
  });

  final double rating;
  final int numOfReviews;
  final int numOfFiveStar, numOfFourStar, numOfThreeStar, numOfTwoStar, numOfOneStar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadious)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "${numOfReviews == 0 ? 0 : rating.toStringAsFixed(1)} ",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: "/5",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Text("Based on $numOfReviews Reviews"),
                const SizedBox(height: defaultPadding / 2),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: index < rating ? warningColor : warningColor,
                      size: 30,
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(width: defaultPadding),
          Expanded(
            child: Column(
              children: [
                RateBar(star: 5, value: numOfReviews == 0 ? 0.0 : numOfFiveStar / numOfReviews),
                RateBar(star: 4, value: numOfReviews == 0 ? 0.0 : numOfFourStar / numOfReviews),
                RateBar(star: 3, value: numOfReviews == 0 ? 0.0 : numOfThreeStar / numOfReviews),
                RateBar(star: 2, value: numOfReviews == 0 ? 0.0 : numOfTwoStar / numOfReviews),
                RateBar(star: 1, value: numOfReviews == 0 ? 0.0 : numOfOneStar / numOfReviews),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RateBar extends StatelessWidget {
  const RateBar({
    super.key,
    required this.star,
    required this.value,
  });

  final int star;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: star == 1 ? 0 : defaultPadding / 2),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Row(
              children: [
                const SizedBox(width: 4),
                Text(
                  "$star",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium!.color),
                ),
                Icon(
                  Icons.star,
                  color: warningColor,
                  size: 20,
                ),
              ],
            ),
          ),
          const SizedBox(width: defaultPadding / 2),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(defaultBorderRadious),
              ),
              child: LinearProgressIndicator(
                minHeight: 6,
                color: warningColor,
                backgroundColor: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.05),
                value: value.isNaN ? 0.0 : value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
