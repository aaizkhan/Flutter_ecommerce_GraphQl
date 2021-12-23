import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

const itemsGraphQl = """
query product{
 products(first: 100, channel: "default-channel") {
    edges {
      node {
        id
        name
        description
        thumbnail{
          url
        }
        productType{
          name
        }
         pricing{
          onSale
          priceRange{
            start{
              currency
              net {
                currency
                amount
              }
              
            }
          }
        }
         
      }
    }
  }
}
""";

class _HomeState extends State<Home> {
  List categoryList = [
    'Clothing',
    'Cushion',
    'Juice',
    'Paint',
    'Audiobook',
    'Wine',
    'Beer',
    'Shoe',
  ];

  String? productType = 'Top (clothing)';
  var queryKey = Key('Top (clothing)');
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color:
                            index == selected ? Colors.blueGrey : Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 2.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(6)),
                    width: 100,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (index == 0) {
                            productType = 'Top (clothing)';
                          } else {
                            productType = categoryList[index];
                          }
                          selected = index;
                          queryKey = Key(categoryList[index]);
                        });
                      },
                      child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            '${categoryList[index]}',
                            style: TextStyle(
                                color: index == selected
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: Query(
                  key: queryKey,
                  options: QueryOptions(document: gql(itemsGraphQl)),
                  builder: (QueryResult queryResult, {fetchMore, refetch}) {
                    List itemsList0 = queryResult.data?['products']['edges'];
                    List itemsList = [];
                    for (int a = 0; a < itemsList0.length; a++) {
                      if (itemsList0[a]['node']['productType']['name'] ==
                          productType) {
                        itemsList.add(itemsList0[a]);
                      }
                    }
                    if (queryResult.hasException) {
                      return Center(
                        child: Text('${queryResult.exception.toString()}'),
                      );
                    }
                    if (queryResult.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (itemsList.length < 1) {
                      return Container();
                    }

                    return Container(
                      margin: EdgeInsets.all(14),
                      child: StaggeredGridView.countBuilder(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          itemCount: itemsList.length,
                          itemBuilder: (context, index) {
                            var items = itemsList[index]['node'];
                            var itemPrice = items['pricing']['priceRange']
                                ['start']['net']['amount'];
                            return Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: Image.network(
                                          items['thumbnail']['url'],
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '${items['name']}',
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '\$$itemPrice',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (index) {
                            return new StaggeredTile.count(
                                1, index.isEven ? 1.38 : 1.7);
                          }),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
