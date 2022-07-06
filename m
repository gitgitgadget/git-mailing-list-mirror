Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F0FC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 07:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiGFHVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiGFHVK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 03:21:10 -0400
Received: from out29-1.mail.aliyun.com (out29-1.mail.aliyun.com [115.124.29.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76701EC50
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 00:21:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1016298|-1;BR=01201311R551S21rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.12062-0.00850698-0.870873;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.OLJ0L9c_1657092063;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.OLJ0L9c_1657092063)
          by smtp.aliyun-inc.com;
          Wed, 06 Jul 2022 15:21:05 +0800
Date:   Wed, 6 Jul 2022 15:21:06 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>, git <git@vger.kernel.org>
Cc:     =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?utf-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>
Subject: Re: RE: [External Mail]Re: Git fork process infinitely and never stop
References: <9d3b79239a314f72a099040a26ef9ad8@xiaomi.com>, 
        <8e1d019e-6456-ed05-7d3e-a0c4beeb35fa@gmail.com>, 
        <8ccd27ef3a344596b6237e98e1a5f204@xiaomi.com>
X-Priority: 3
X-GUID: F22297EB-DBF8-4862-8D88-6D9B3F273548
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <202207061520052718298@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pi0gZ2l0IHZlcnNpb246Cj4yLjM2LjEKPi0gc3RlcHMgdG8gcmVwcm9kdWNlIHRoZSBidWcKPjog
V2UgaGF2ZSBubyBpZGVhIGFjdHVhbGx5LiBXZSdyZSBtYWludGFpbmVyIG9mIG91ciBpbnRlcm5h
bCBnaXQvZ2Vycml0LiBXZSBmb3VuZCBzb21ldGltZXMgc29tZSB1c2VyIHdpbGwgaW52b2tlIDEw
MCsgdGhyZWFkcyB0byBjbG9uZSB0aGUgc2FtZSByZXBvc2l0b3J5LiBBbmQgd2hlbiB3ZSBhc2sg
dGhvc2UgZ3V5LCB0aGV5IHNheSB0aGV5IG9ubHkgZXhlY3V0ZWQgdGhlICJnaXQgZmV0Y2giIG9u
Y2UuIEFuZCBqdXN0IGxpa2UgdGhlIHlvdXR1YmUgdmlkZWlvLCB5b3Ugd2lsbCBmaW5kIGdpdCBm
b3JrIGEgY2hpbGQgZ2l0LCBhbmQgdGhlbiBncmFuZHNvbiBjaGlsZCBnaXQsIGFuZCBsb29wIGxp
a2UgdGhpcyBmb3JldmVyIHVudGlsIHRoZSBzZXJ2ZXIgZG93bi4KPklmIHdlIGNvcHkgdGhlaXIg
bG9jYWwgcmVwb3NpdG9yeSB0byBvdXIgb3duIFBDLCBhbmQgdGhlbiBleGVjdXRlIGBnaXQgZmV0
Y2hgLCB3ZSBjYW4gYWxzbyByZXByb2R1Y2UgaXQuIEl0IHNlZW1zIHRoYXQgc29tZSBicm9rZW4g
bG9jYWwgZ2l0IGZpbGVzIGNhdXNlIHRoaXMgYnVnIApTbyB0aGUgcmVwbyAiZ2l0L2dlcnJpdCIg
aXMgaG9zdGVkIGluIHlvdXIgbG9jYWw/IGFuZCBob3cgeW91ICJjb3B5IiBpdCB0byB5b3VyIG93
biBQQz/CoAo=

