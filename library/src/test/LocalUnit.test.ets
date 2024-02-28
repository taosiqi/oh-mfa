import { describe, expect, it } from '@ohos/hypium';
import { generateTotp } from '../main/ets/totp';


export default function localUnitTest() {

  describe('generateTotp', function () {
    it('assertContain', 0, () => {
      const token = generateTotp("JBSWY3DPEHPK3PXP", {
        digits: 8,
        algorithm: "SHA512",
        period: 60,
        timestamp: 1465324707000,
      });
      expect(typeof token).assertEqual('string')
      expect(token.length).assertEqual(8)
    });
  });

}
