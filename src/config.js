module.exports = {
  // DDNSPOD的secretId和secretKey 获取地址: https://console.dnspod.cn/account/token/apikey
  secretId: env.DNSPOD_SEC_ID,
  secretKey: env.DNSPOD_SEC_KEY,
  // 主域名和需要DDNS的子域名
  Domain: env.Domain,
  SubDomain: env.SubDomain
};
