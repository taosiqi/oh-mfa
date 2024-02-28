# totp-generator

totp-generator 允许你从一个TOTP密钥生成TOTP令牌

## 如何使用

```javascript
import { generateTotp } from 'totp-generator'

const token = generateTotp("JBSWY3DPEHPK3PXP");
console.log(token); // prints a 6-digit time-based token based on provided key and current time
```

## 默认参数

- SHA1
- 30秒的时代间隔
- 6位数字令牌

## 自定义参数

可以提供一个可选的第二个参数来设置：

```javascript
import { generateTotp } from '@ohos/totp-generator'

const token = generateTotp("JBSWY3DPEHPK3PXP", { digits: 8 });
console.log(token); // prints an 8-digit token

const token = generateTotp("JBSWY3DPEHPK3PXP", { algorithm: "SHA512" });
console.log(token); // prints a token created using a different algorithm

const token = generateTotp("JBSWY3DPEHPK3PXP", { period: 60 });
console.log(token); // prints a token using a 60-second epoch interval

const token = generateTotp("JBSWY3DPEHPK3PXP", { timestamp: 1465324707000 });
console.log(token); // prints a token for given time

const token = generateTotp("JBSWY3DPEHPK3PXP", {
	digits: 8,
	algorithm: "SHA512",
	period: 60,
	timestamp: 1465324707000,
});
console.log(token); // prints a token using all custom settings combined
```

## 我可以用这个库做什么？

- TOTP生成
- 端到端测试（在需要使用两因素认证登录的地方）

## 感谢

- 基于 https://github.com/bellstrand/totp-generator 发展而来