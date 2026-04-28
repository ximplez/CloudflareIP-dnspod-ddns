module.exports = {
  // DDNSPOD的secretId和secretKey 获取地址: https://console.dnspod.cn/account/token/apikey
  secretId: process.env.DNSPOD_SEC_ID,
  secretKey: process.env.DNSPOD_SEC_KEY,
  // 主域名和需要DDNS的子域名
  Domain: process.env.Domain,
  SubDomain: process.env.SubDomain
};
