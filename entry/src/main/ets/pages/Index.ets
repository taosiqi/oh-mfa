import { generateTotp } from 'totp-generator'

@Entry
@Component
struct Index {
  @State totpKey: string = '5F7XTR3O5ANHF4UI'
  @State genTotpKey: string = ''
  @State second: number = 30
  @State focusableAccount: boolean = false;

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
    Column({ space: 35 }) {
      Text(`倒计时${this.second}s`).fontSize(28)
      Text(this.genTotpKey).fontSize(40)
      TextInput({ text: this.totpKey, placeholder: 'input your word...' }).onChange((value)=>{
        this.totpKey=value
      }).width(300).defaultFocus(false).focusable(this.focusableAccount).onClick(()=>{
        // 默认会聚焦，defaultFocus无效，不知道是不是版本问题
        if(!this.focusableAccount){
          this.focusableAccount = true;
        }
      });
      Button('刷新验证码').onClick(()=>{
        this.genTotpKey=generateTotp(this.totpKey)
      })
      Text('推荐使用《MFA二次验证码》微信小程序版本').fontSize(16)
      Image('https://static-1253419794.cos.ap-nanjing.myqcloud.com/img/code.jpg').width(200).height(200)
    }.justifyContent(FlexAlign.Center).width('100%').height('100%')
  }
}





