Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358D01F453
	for <e@80x24.org>; Wed, 13 Feb 2019 09:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391230AbfBMJOI (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 04:14:08 -0500
Received: from smtp67.cstnet.cn ([159.226.251.67]:50607 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728468AbfBMJOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 04:14:08 -0500
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2019 04:14:08 EST
Received: by ajax-webmail-APP-21 (Coremail) ; Wed, 13 Feb 2019 17:08:21
 +0800 (GMT+08:00)
X-Originating-IP: [114.255.44.140]
Date:   Wed, 13 Feb 2019 17:08:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
To:     git@vger.kernel.org
Cc:     wuzhouhui14 <wuzhouhui14@mails.ucas.ac.cn>
Subject: How to get next commit that just after a specified commit
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.5 build 20161025(89512.9021)
 Copyright (c) 2002-2019 www.mailtech.cn cstnet
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <383c14cc.9289.168e61d39e8.Coremail.wuzhouhui14@mails.ucas.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 2wCowABHp8SF3mNcujQVAA--.33879W
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiAgQAAVJhbKLkFw
        ABsI
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksCgpJIGhhdmUgc2VhcmNoZWQgSW50ZXJuZXQgZm9yIHdoaWxlIGJ1dCBjb3VsZG4ndCBmaW5k
IHRoZSBhbnN3ZXIuCgpTdXBwb3NlIEkgaGF2ZSBjb21taXQKICAyMTIxNDZmMDgwMGUKdGhlbiBj
b21taXQKICA3M2E0YzUyMTg0MTQKYW5kIGZpbmFsbHkgY29tbWl0CiAgYWFkYWE4MDYxMTg5CgpT
byBJIGdldCBmb2xsb3dpbmcgYWZ0ZXIgJ2dpdCBsb2cnOgogIGFhZGFhODA2MTE4OQogIDczYTRj
NTIxODQxNAogIDIxMjE0NmYwODAwZQoKQW5kIG5vdywgbXkgcXVlc3Rpb24gaXMgaG93IHRvIHJl
dHJpZXZlIHRoZSBuZXh0IGNvbW1pdCAoaS5lLiA3M2E0YzUyMTg0MTQpCnRoYXQganVzdCBhZnRl
ciAyMTIxNDZmMDgwMGU/CgpQbGVhc2UgQ0MgbWUuCgpUaGFua3Mu
