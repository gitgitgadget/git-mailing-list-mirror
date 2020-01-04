Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC72C00523
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 01:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4005217F4
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 01:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgADBTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 20:19:11 -0500
Received: from smtp37.cstnet.cn ([159.226.251.37]:51212 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbgADBTL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 20:19:11 -0500
Received: by ajax-webmail-APP-12 (Coremail) ; Sat, 4 Jan 2020 09:18:58 +0800
 (GMT+08:00)
X-Originating-IP: [106.120.127.15]
Date:   Sat, 4 Jan 2020 09:18:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
To:     git@vger.kernel.org
Subject: What the meaning of two commit ID in a merge commit's log
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.9a build 20190604(696d1518)
 Copyright (c) 2002-2020 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <56365810.1196c.16f6e224802.Coremail.wuzhouhui14@mails.ucas.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: tgCowABHfJsC6A9emRMHAA--.7580W
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiBAMFAV02S2QAdw
        ACsy
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksCgpXaGVuIEkgdXNlICJnaXQgbG9nIiB0byBkaXNwbGF5IGNvbW1pdCBsb2csIEkgc2VlIHRo
ZXJlIGFyZQp0d28gY29tbWl0IElEcyBpbiBhIG1lcmdlIGNvbW1pdCwgZS5nLgoKICAgIGNvbW1p
dCAyMTg3ZjIxNWViYWFjNzNkZGJkODE0Njk2ZDdjN2ZhMzRmMGMzZGUwCiAgICBNZXJnZTogMmQz
MTQ1ZjhkMjgwIGZiZDU0Mjk3MWFhMQogICAgQXV0aG9yOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFs
ZHNAbGludXgtZm91bmRhdGlvbi5vcmc+CiAgICBEYXRlOiAgIFR1ZSBEZWMgMTcgMTM6Mjc6MDIg
MjAxOSAtMDgwMAoKICAgICAgICBNZXJnZSB0YWcgJ2Zvci01LjUtcmMyLXRhZycgb2YgZ2l0Oi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2tkYXZlL2xpbnV4CgpJbiB0
aGUgcHJldmlvdXMgZXhhbXBsZSwgd2UgY2FuIHNlZSB0d28gY29tbWl0IElEczogMmQzMTQ1Zjhk
MjgwIGFuZApmYmQ1NDI5NzFhYTEuIFNvLCB3aGF0J3MgdGhlIG1lYW5pbmcgb2YgdGhlbSwgcHJl
Y2lzZWx5LgoKVGhhbmtz
