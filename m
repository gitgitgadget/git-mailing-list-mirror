Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC42C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 04:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiFJEXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 00:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiFJEXC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 00:23:02 -0400
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0878C2EE10C
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 21:22:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1794199|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0308393-0.00200454-0.967156;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.O1QVsRI_1654834967;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.O1QVsRI_1654834967)
          by smtp.aliyun-inc.com;
          Fri, 10 Jun 2022 12:22:49 +0800
Date:   Fri, 10 Jun 2022 12:22:48 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Re: [PATCH v2] remote-curl: send Accept-Language header to server
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>, 
        <pull.1251.v2.git.1654756523475.gitgitgadget@gmail.com>, 
        <xmqqilp9gznd.fsf@gitster.g>, 
        <2022061011484327929877@oschina.cn>
X-Priority: 3
X-GUID: 03F27ACA-6E0D-4ED8-B73D-D40337B793AE
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <2022061012214725558779@oschina.cn>
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cj4+QXMgSSBhbHJlYWR5IHNhaWQsIEkgZG8gbm90IHRoaW5rIGNoYW5nZXMgdG8gdGhlIGZvbGxv
d2luZyB0d28gdGVzdHMKPj5hcmUgd2FycmFudGVkLgo+Pgo+Pj4gZGlmZiAtLWdpdCBhL3QvdDU1
NTAtaHR0cC1mZXRjaC1kdW1iLnNoIGIvdC90NTU1MC1odHRwLWZldGNoLWR1bWIuc2gKPj4+IGRp
ZmYgLS1naXQgYS90L3Q1NTUxLWh0dHAtZmV0Y2gtc21hcnQuc2ggYi90L3Q1NTUxLWh0dHAtZmV0
Y2gtc21hcnQuc2gKPldlbGwsIGFmdGVyIEkgbWFkZSBzb21lIHRlc3RzLCB0aGUgcmVhc29uIHQ1
NTUxIGZhaWwgdG8gdGVzdCB3aGF0IHdlIHdhbnQgaXMKPiJpZiB0ZXN0ICIkR0lUX1RFU1RfUFJP
VE9DT0xfVkVSU0lPTiIgPSAyIiB0aGlzIHN0YXRlbWVudCBibG9jayB0aGUgcmVhbAo+dGVzdC4g
CkZpeDogJyIkR0lUX1RFU1RfUFJPVE9DT0xfVkVSU0lPTiIgPSAwJwo+Pgo+Pgo+PlRoYW5rcy4=

