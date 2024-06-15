import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/constants/icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component/product_detail_controller.dart';

class ProductDetailPage extends GetWidget<ProductDetailController> {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            title: const Text(
              "Detail Product",
              style: TextStyle(
                fontSize: 16,
                color: gray900,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 360,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage("https://picsum.photos/250?image=9"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Triple Set Concentrate WX Bpom for Dark Spots",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Rp334.000",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ic_star,
                            height: 16,
                            width: 16,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "4.8",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "(248 Reviews)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Description",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Mohon untuk bisa melakukan video unboxing (pembukaan paket), foto penerimaan produk, foto resi dan label pembeli saat paket sudah berhasil diterima sehingga jika ada kerusakan, kekurangan produk/hadiah, atau ketidaksesuaian produk yang diterima bisa dilakukan validasi melalui kelengkapan tersebut\nJika tidak ada atau hanya memiliki salah satu dari kelengkapan yang disebutkan, maka segala bentuk komplain yang masuk tidak bisa ditindaklanjuti atau dianggap tidak sah, kecuali memang ada kesalahan dari sisi penjual\nKerusakan packaging hanya pada bagian luar (bagian dalam utuh, produk tidak ada kerusakan/kekurangan, dll) disebabkan penanganan paket dari pihak jasa ekspedisi yang kurang baik, diharapkan agar pembeli bisa melakukan komplain langsung ke pihak jasa ekspedisi",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Terms & Conditions of Return / Refund",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Mohon untuk bisa melakukan video unboxing (pembukaan paket), foto penerimaan produk, foto resi dan label pembeli saat paket sudah berhasil diterima sehingga jika ada kerusakan, kekurangan produk/hadiah, atau ketidaksesuaian produk yang diterima bisa dilakukan validasi melalui kelengkapan tersebut\nJika tidak ada atau hanya memiliki salah satu dari kelengkapan yang disebutkan, maka segala bentuk komplain yang masuk tidak bisa ditindaklanjuti atau dianggap tidak sah, kecuali memang ada kesalahan dari sisi penjual\nKerusakan packaging hanya pada bagian luar (bagian dalam utuh, produk tidak ada kerusakan/kekurangan, dll) disebabkan penanganan paket dari pihak jasa ekspedisi yang kurang baik, diharapkan agar pembeli bisa melakukan komplain langsung ke pihak jasa ekspedisi",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Product Review",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "See More",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ic_star,
                            height: 16,
                            width: 16,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "4.8",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "from 302 rating",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                            width: 5,
                            height: 5,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "248 reviews",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                width: 48,
                                height: 48,
                                "assets/images/default_profile_image.png",
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Amanda Zahra",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        ic_star,
                                        height: 16,
                                        width: 16,
                                      ),
                                      Image.asset(
                                        ic_star,
                                        height: 16,
                                        width: 16,
                                      ),
                                      Image.asset(
                                        ic_star,
                                        height: 16,
                                        width: 16,
                                      ),
                                      Image.asset(
                                        ic_star,
                                        height: 16,
                                        width: 16,
                                      ),
                                      Image.asset(
                                        ic_star,
                                        height: 16,
                                        width: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "1 days ago",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Saya suka konsistensi dari produk skincare ini. Tidak terlalu berat atau lengket, dan cepat meresap ke dalam kulit.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
