import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:homeflix/Components/ViewComponents/MovieListGen.dart';
import 'package:homeflix/Components/ViewComponents/SecondTitle.dart';
import 'package:homeflix/Data/FetchDatas.dart';

class Series extends StatefulWidget {
	const Series({super.key});

	@override
	State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
	List<Widget> img10 = [];
	List<Widget> img20 = [];
	List<Widget> recentImg20 = [];
	List<Widget> trashImg20 = [];
	int current10 = 0;

	///////////////////////////////////////////////////////////////
	/// Ajoute les images à une liste d'image
	void addImg() {
		for (int x = 0; x < 10; x++) {
			img10.add(TMDBService().createImg(
				TMDBService.the10serieTren[x]['poster_path'],
				TMDBService.the10serieTren[x]['id'].toString(),
				MediaQuery.of(context).size.width
			));
		}
		for (int x = 0; x < 20; x++) {
			img20.add(TMDBService().createImg(
				TMDBService.the20seriePop[x]['poster_path'],
				TMDBService.the20seriePop[x]['id'].toString(),
				150
			));
			
		}
	}

	@override
	Widget build(BuildContext context) {
		addImg();
		return Column(
			children: [
				trendZone(),
				const Gap(35),
				const Secondtitle(title: "Populaires"),
				const Gap(10),
				MovieListGen(
					imgList: img20,
					datas: TMDBService.the20moviePop
				),
				const Gap(35),
				const Secondtitle(title: "Sorties cette année"),
				const Gap(10),
				MovieListGen(
					imgList: recentImg20,
					datas: TMDBService.the20moviePop
				),
				const Gap(10)
			]
		);
	}

	///////////////////////////////////////////////////////////////
	/// zone des films du moment
	Widget trendZone() {
		return SizedBox(
			height: MediaQuery.sizeOf(context).height * 0.72,
			child: Stack(
				children: [
					CarouselSlider(
						items: img10,
						options: CarouselOptions(
							viewportFraction: 1,
							autoPlay: true,
							aspectRatio: 2 / 3,
							onPageChanged: (index, reason) => current10 = index, 
						),
					),
					openOnOf7()
				],
			),
		);
	}

	///////////////////////////////////////////////////////////////
	/// Bouton ouvrant l'un des 7 aléatoires (celui affiché)
	Widget openOnOf7() {
		return Align(
			alignment: Alignment.bottomCenter,
			child: SizedBox(
				width: 250,
				height: 45,
				child: ElevatedButton(
					onPressed: () {
						print(current10);
					},
					style: ElevatedButton.styleFrom(
						backgroundColor: Theme.of(context).colorScheme.tertiary,
						foregroundColor: Theme.of(context).primaryColor,
						shape: RoundedRectangleBorder(
							borderRadius: BorderRadius.circular(10)
						)
					),
					child: Text(
						"En savoir plus",
						style: TextStyle(
							fontSize: 16,
							color: Theme.of(context).scaffoldBackgroundColor,
							fontWeight: FontWeight.w600
						),
					),
				),
			)
		);
	}
}