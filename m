Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76908C43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 17:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiGJRyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 13:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJRyV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 13:54:21 -0400
Received: from out29-145.mail.aliyun.com (out29-145.mail.aliyun.com [115.124.29.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B4A11837
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 10:54:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2888728|-1;BR=01201311R181S99rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0142504-0.00391198-0.981838;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OP1o-6Y_1657475649;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.OP1o-6Y_1657475649)
          by smtp.aliyun-inc.com;
          Mon, 11 Jul 2022 01:54:10 +0800
Date:   Mon, 11 Jul 2022 01:54:10 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Re: What's cooking in git.git (Jul 2022, #02; Fri, 8)
References: <xmqq4jzquiok.fsf@gitster.g>, 
        <202207102031058469922@oschina.cn>, 
        <xmqq7d4lrkyb.fsf@gitster.g>
X-Priority: 3
X-GUID: ED8D33FD-9CA1-4A17-8F1C-BF7654627636
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <202207110151444952947@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiJsaWxpbmNoYW9Ab3NjaGluYS5jbiIgPGxpbGluY2hhb0Bvc2NoaW5hLmNuPiB3cml0ZXM6Cj4K
Pj4+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+
W1N0YWxsZWRdCj4+Pgo+Pj4qIGxsL2N1cmwtYWNjZXB0LWxhbmd1YWdlICgyMDIyLTA2LTEzKSAy
IGNvbW1pdHMKPj4+IC0gUFJFUD8/PyBnaXZlIGluaXRpYWxpemVyIHRvIHJwY19zdGF0ZQo+Pj4g
LSByZW1vdGUtY3VybDogc2VuZCBBY2NlcHQtTGFuZ3VhZ2UgaGVhZGVyIHRvIHNlcnZlcgo+Pj4K
Pj4+IHNvdXJjZTogPHB1bGwuMTI1MS52My5naXQuMTY1NTA1NDQyMTY5Ny5naXRnaXRnYWRnZXRA
Z21haWwuY29tPgo+PiB3aGF0IHNob3VsZCBJIGRvIGlmIHRoZSBzdGF0ZSBpcyBzdGFsbGVkPwo+
Cj5TZW5kIGEgcmVzcG9uc2UgdG8gdGhlIGRpc2N1c3Npb24gdGhyZWFkIGFuZC9vciBwb3NzaWJs
eSBhbiB1cGRhdGVkCj5hbmQgY29ycmVjdGVkIHBhdGNoIHRvIGZpeCBjb21waWxhdGlvbiBpc3N1
ZXMsIHBlcmhhcHM/Ck9oLCBJIHRob3VnaHQgaXQgd2FzIGRvbmUuIEN1cnJlbnRseSBhcyBJIGNh
biBzZWUsIHRoaXMgcGF0Y2ggaXMgYSBjb21wbGV0ZSBhbmQKbWluaW1hbCBpbXBsZW1lbnRhdGlv
biwgYXQgbGVhc3QgaXQgZml4ZXMgdGhlIGNvbnNpc3RlbmN5IG9mIHRoZSBIVFRQIHByb3RvY29s
LgpUaGUgbmV3IGlucHV0IGFmdGVyIHlvdSBmaXhlZCAicnBjX3N0YXRl4oCdaW5pdGlhbGl6YXRp
b24gaXNzdWUgaXMganVzdMKgZGlzY3Vzc2luZwp0aGUgZnV0dXJlIHdvcmsgSSBndWVzcz8KCg==

