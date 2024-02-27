// import JsSHA from "jssha";
//
// // TypeScript中可能需要定义接口来规范options对象的结构
// interface TokenOptions {
//   period?: number;
//   algorithm?: string;
//   digits?: number;
//   timestamp?: number;
// }
//
// export function getToken(key: string, options?: TokenOptions): string {
//   let epoch: number, time: string, shaObj: JsSHA, hmac: string, offset: number, otp: string;
//   options = options || {};
//   options.period = options.period || 30;
//   options.algorithm = options.algorithm || "SHA-1";
//   options.digits = options.digits || 6;
//   options.timestamp = options.timestamp || Date.now();
//   key = base32hex(key); // 确保这里使用的函数名与你的实现一致
//   epoch = Math.floor(options.timestamp / 1000.0);
//   time = leftPad(dec2hex(Math.floor(epoch / options.period)), 16, "0");
//   shaObj = new JsSHA(options.algorithm, "HEX");
//   shaObj.setHMACKey(key, "HEX");
//   shaObj.update(time);
//   hmac = shaObj.getHMAC("HEX");
//   offset = hex2dec(hmac.substring(hmac.length - 1));
//   otp = ((hex2dec(hmac.substring(offset * 2, offset * 2 + 8)) & hex2dec("7fffffff")) + "").substring(0);
//   otp = otp.substring(otp.length - options.digits); // 使用substring替换substr
//   return otp;
// }
//
//
// function hex2dec(s: string): number {
//   return parseInt(s, 16);
// }
//
// function dec2hex(s: number): string {
//   return (s < 15.5 ? "0" : "") + Math.round(s).toString(16);
// }
//
// function base32hex(base32: string): string {
//   const base32chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
//   let bits = "";
//   let hex = "";
//
//   base32 = base32.replace(/=+$/, "");
//
//   for (let i = 0; i < base32.length; i++) {
//     const val = base32chars.indexOf(base32.charAt(i).toUpperCase());
//     if (val === -1) throw new Error("Invalid base32 character in key");
//     bits += leftPad(val.toString(2), 5, "0");
//   }
//
//   for (let i = 0; i + 8 <= bits.length; i += 8) {
//     const chunk = bits.slice(i, i + 8);
//     hex = hex + leftPad(parseInt(chunk, 2).toString(16), 2, "0");
//   }
//   return hex;
// }
//
// function leftPad(str: string, len: number, pad: string): string {
//   if (len + 1 >= str.length) {
//     str = Array(len + 1 - str.length).join(pad) + str;
//   }
//   return str;
// }
