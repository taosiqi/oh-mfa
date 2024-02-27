@Entry
@Component
struct Index {
  @State numList: Array<number> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
  scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column({ space: 15 }) {
        Banner().height(200)
        Text('倒计时 30s')
        ForEach(this.numList, (item) => {
          Text('item-' + item)
            .width('100%')
            .height(120)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .borderRadius(10)
            .backgroundColor(Color.Grey)
        }, item => item)
      }.alignItems(HorizontalAlign.Start)
    }
    .padding({ left: 10, right: 10,bottom:30 })
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Fade)
    .onScroll((xOffset: number, yOffset: number) => {
      console.info(xOffset + ' ' + yOffset)
    })
  }
}


@Component
struct Banner {
  private swiperController: SwiperController = new SwiperController()

  build() {
    Swiper(this.swiperController) {
      ForEach([1, 2, 4], () => {
        Image("https://static-1253419794.cos.ap-nanjing.myqcloud.com/img/1.png")
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Cover)
      })
    }
    .height('100%')
    .width('100%')
    .borderRadius(8)
    .loop(true)
    .autoPlay(true)
  }
}

