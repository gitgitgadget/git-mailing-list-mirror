Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76262C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 01:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhLUBea (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 20:34:30 -0500
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net ([167.99.105.149]:55071
        "HELO zg8tmty3ljk5ljewns4xndka.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S230404AbhLUBe3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Dec 2021 20:34:29 -0500
Received: from mailtech.cn (unknown [10.12.1.20])
        by hzbj-icmmx-2 (Coremail) with SMTP id AQAAfwCnzc0+L8Fh4syzBw--.18717S2;
        Tue, 21 Dec 2021 09:34:54 +0800 (CST)
Received: from pwxu$coremail.cn ( [112.94.4.17] ) by
 ajax-webmail-mailtech_rd (Coremail) ; Tue, 21 Dec 2021 09:34:22 +0800 (CST)
X-Originating-IP: [112.94.4.17]
Date:   Tue, 21 Dec 2021 09:34:22 +0800 (CST)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2021, #04; Wed, 15)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.3 build 20211103(a39c0bb8)
 Copyright (c) 2002-2021 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <xmqq8rwlz3cq.fsf@gitster.g>
References: <xmqq8rwlz3cq.fsf@gitster.g>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1e9d0913.2b.17ddaa010fb.Coremail.pwxu@coremail.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AgIMCgAHaGAeL8FhPAIAAA--.81W
X-CM-SenderInfo: psz03q5fruvzxdlohubq/1tbiAgQCCFGCc59JJwACsf
Authentication-Results: hzbj-icmmx-2; spf=neutral smtp.mail=pwxu@corem
        ail.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAqIHh3L2FtLWVtcHR5ICgyMDIxLTEyLTA3KSAzIGNvbW1pdHMKClRoZSBhbGlhcyBvZiBteSBu
YW1lIHNob3VsZCBiZSAicHd4dSIgYnV0IG5vdCAieHciLgoKPiAgLSBhbTogc3VwcG9ydCAtLWFs
bG93LWVtcHR5IHRvIHJlY29yZCBzcGVjaWZpYyBlbXB0eSBwYXRjaGVzCj4gIC0gYW06IHN1cHBv
cnQgLS1lbXB0eT08b3B0aW9uPiB0byBoYW5kbGUgZW1wdHkgcGF0Y2hlcwo+ICAtIGRvYzogZ2l0
LWZvcm1hdC1wYXRjaDogZGVzY3JpYmUgdGhlIG9wdGlvbiAtLWFsd2F5cwo+IAo+ICAiZ2l0IGFt
IiBsZWFybnMgIi0tZW1wdHk9KGRpZXxkcm9wfGtlZXApIiBvcHRpb24gdG8gdHdlYWsgd2hhdCBp
cwoKVGhpcyBzaG91bGQgYmUgJ2xlYXJucyAiLS1lbXB0eT0oc3RvcHxkcm9wfGtlZXApIicKCj4g
IGRvbmUgdG8gYSBwaWVjZSBvZiBlLW1haWwgd2l0aG91dCBhIHBhdGNoIGluIGl0Lgo+IAo+ICBB
bG1vc3QgdGhlcmUuCj4gIHNvdXJjZTogPHB1bGwuMTA3Ni52MTguZ2l0LjE2Mzg5Mzk5NDYuZ2l0
Z2l0Z2FkZ2V0QGdtYWlsLmNvbT4KCgo=

