Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81490C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 06:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiGKGRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 02:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKGRs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 02:17:48 -0400
Received: from out29-73.mail.aliyun.com (out29-73.mail.aliyun.com [115.124.29.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D7117E12
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 23:17:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1513439|-1;BR=01201311R101S56rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0123545-0.000846534-0.986799;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OPVGY4t_1657520234;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.OPVGY4t_1657520234)
          by smtp.aliyun-inc.com;
          Mon, 11 Jul 2022 14:17:15 +0800
Date:   Mon, 11 Jul 2022 14:17:15 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Re: What's cooking in git.git (Jul 2022, #02; Fri, 8)
References: <xmqq4jzquiok.fsf@gitster.g>, 
        <202207102031058469922@oschina.cn>, 
        <xmqq7d4lrkyb.fsf@gitster.g>, 
        <202207110151444952947@oschina.cn>, 
        <xmqqfsj8pjcd.fsf@gitster.g>
X-Priority: 3
X-GUID: 7F752F77-81DF-45A4-94BD-1776C999CF8A
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <2022071114122360705813@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiJsaWxpbmNoYW9Ab3NjaGluYS5jbiIgPGxpbGluY2hhb0Bvc2NoaW5hLmNuPiB3cml0ZXM6Cj4K
Pj4gVGhlIG5ldyBpbnB1dCBhZnRlciB5b3UgZml4ZWQgInJwY19zdGF0ZeKAnWluaXRpYWxpemF0
aW9uIGlzc3VlIGlzCj4+IGp1c3QgZGlzY3Vzc2luZyB0aGUgZnV0dXJlIHdvcmsgSSBndWVzcz8K
Pgo+SXNuJ3QgdGhlIHNlcmllcyBicm9rZW4gd2l0aG91dCB0aGUgc3VnZ2VzdGVkIGZpeC11cCBJ
IHF1ZXVlZCBvbgo+dG9wP8KgIElmIHNvLCBhbiB1cGRhdGVkIHBhdGNoIHRoYXQgZG9lcyBub3Qg
bmVlZCBzdWNoIGEgZml4IG9uIHRvcAo+aXMgd2hhdCB0aGUgc2VyaWVzIG5lZWRzIHRvIGNvbWUg
b3V0IG9mIHRoZSBzdGFsbGVkIHN0YXRlLCBJIHRoaW5rLgpBcHBsaWVkIHlvdXIgc3VnZ2VzdGVk
IGZpeC11cCBpbnRvIHBhdGNoLCBhbmQgdXBkYXRlZC4gCkFsbCBwaXBlbGluZXMgaW7CoEdpdEdp
dEdhZGdldC9naXQgdHVybmVkIGdyZWVuLCB3aGljaCB3YXNuJ3QgYmVmb3JlLgoKVGhhbmtz

