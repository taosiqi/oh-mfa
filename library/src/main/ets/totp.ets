import { CryptoJS } from '@ohos/crypto-js'

type HashAlgorithm = 'SHA1' | 'SHA224' | 'SHA256' | 'SHA384' | 'SHA512' | 'SHA3';


interface TokenOptions {
  period?: number;
  digits?: number;
  timestamp?: number;
  algorithm?: HashAlgorithm | undefined;
}

/**
 * 生成验证码
 * @param key
 * @param options
 * @returns
 */
export function generateTotp(key: string, options?: TokenOptions): string {
  try {
    let epoch: number, time: string, mac: string, offset: number, otp: string;
    options = options || {};
    options.period = options.period || 30;
    options.digits = options.digits || 6;
    options.timestamp = options.timestamp || Date.now();
    options.algorithm = options.algorithm || "SHA1"

    key = base32hex(key);
    epoch = Math.floor(options.timestamp / 1000.0);
    time = leftPad(dec2hex(Math.floor(epoch / options.period)), 16, "0");

    // 使用CryptoJS计算HMAC，动态选择哈希算法
    const keyHex = CryptoJS.enc.Hex.parse(key);
    const timeHex = CryptoJS.enc.Hex.parse(time);
    mac = hmacDigest(options.algorithm, timeHex, keyHex);

    offset = hex2dec(mac.substring(mac.length - 1));
    otp = ((hex2dec(mac.substring(offset * 2, offset * 2 + 8)) & hex2dec("7fffffff")) + "").substring(0);
    otp = otp.substring(otp.length - options.digits);
    return otp;
  } catch (e) {
    return ''
  }
}

/**
 * 动态选择算法
 * @param algorithm
 * @param message
 * @param key
 * @returns
 */
function hmacDigest(algorithm: HashAlgorithm, message: string, key: string): string {
  let mac
  switch (algorithm) {
    case 'SHA224':
      mac = CryptoJS.HmacSHA224(message, key);
    case 'SHA256':
      mac = CryptoJS.HmacSHA256(message, key);
    case 'SHA384':
      mac = CryptoJS.HmacSHA384(message, key);
    case 'SHA512':
      mac = CryptoJS.HmacSHA512(message, key);
    case 'SHA3':
      mac = CryptoJS.HmacSHA3(message, key);
    case 'SHA1':
    default:
      mac = CryptoJS.HmacSHA1(message, key)
  }
  return mac.toString(CryptoJS.enc.Hex);
}

/**
 * 将十六进制字符串转换为对应的十进制数值
 * @param s
 * @returns
 */
function hex2dec(s: string): number {
  return parseInt(s, 16);
}

/**
 * 将一个十进制数转换为对应的十六进制
 * @param s
 * @returns
 */
function dec2hex(s: number): string {
  return (s < 15.5 ? "0" : "") + Math.round(s).toString(16);
}

/**
 * base32转hex
 * @param base32
 * @returns
 */
function base32hex(base32: string): string {
  const base32chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
  let bits = "";
  let hex = "";
  base32 = base32.replace(/=+$/, "");

  for (let i = 0; i < base32.length; i++) {
    const val = base32chars.indexOf(base32.charAt(i).toUpperCase());
    if (val === -1) throw new Error("Invalid base32 character in key");
    bits += val.toString(2).padStart(5, '0');
  }

  for (let i = 0; i + 8 <= bits.length; i += 8) {
    const chunk = bits.slice(i, i + 8);
    hex += parseInt(chunk, 2).toString(16).padStart(2, '0');
  }

  return hex;
}

/**
 * 左侧填充字符串，确保填充后的字符串长度达到指定的长度
 * @param str
 * @param len
 * @param pad
 * @returns
 */
function leftPad(str: string, len: number, pad: string): string {
  if (len + 1 >= str.length) {
    str = Array(len + 1 - str.length).join(pad) + str;
  }
  return str;
}
