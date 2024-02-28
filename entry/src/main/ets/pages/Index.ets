import { generateTotp } from 'totp-generator'

@Entry
@Component
struct Index {
  @State totpKey: string = '5F7XTR3O5ANHF4UI'
  @State genTotpKey: string = ''
  @State second: number = 30
  intervalID: number

  countdown() {
    this.intervalID = setInterval(() => {
      this.second= 30 - (new Date().getSeconds() % 30)
      if(this.second===30){
        this.genTotpKey=generateTotp(this.totpKey)
      }
    }, 1000);
  };


  async onPageShow(){
    this.genTotpKey=generateTotp(this.totpKey)
    this.countdown()
  }

  build() {
    Column({ space: 15 }) {
      Text(`倒计时${this.second}s`).fontSize(28)
      Text(this.genTotpKey).fontSize(40)
      TextInput({ text: this.totpKey, placeholder: 'input your word...' }).onChange((value)=>{
        this.totpKey=value
      }).width(300).defaultFocus(true)
      Button('刷新验证码').onClick(()=>{
        this.genTotpKey=generateTotp(this.totpKey)
      })
    }.justifyContent(FlexAlign.Center).width('100%').height('100%')
  }
}





