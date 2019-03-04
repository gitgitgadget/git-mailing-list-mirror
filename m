Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7157E20248
	for <e@80x24.org>; Mon,  4 Mar 2019 07:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfCDH2b (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 02:28:31 -0500
Received: from smtp63.cstnet.cn ([159.226.251.63]:44125 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725550AbfCDH2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 02:28:31 -0500
Received: by ajax-webmail-APP-17 (Coremail) ; Mon, 4 Mar 2019 15:28:13 +0800
 (GMT+08:00)
X-Originating-IP: [114.255.44.140]
Date:   Mon, 4 Mar 2019 15:28:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
To:     git@vger.kernel.org
Subject: Git log print commits between a revision range (inclusive)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.5 build 20161025(89512.9021)
 Copyright (c) 2002-2019 www.mailtech.cn cstnet
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <62307e7b.399f4.169479a611e.Coremail.wuzhouhui14@mails.ucas.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 1wCowAD3xSCO03xcs7IYAA--.58142W
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiCAwTAVlo-Kk3+A
        ACs-
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksCgpJIHdhbnQgdG8ga25vdyBob3cgdG8gZGlzcGxheSBsb2dzIGJldHdlZW4gYSByZXZpc2lv
biByYW5nZSAoYm90aApzdGFydCBhbmQgZW5kIGFyZSBpbmNsdXNpdmUpLiBJIHNlYXJjaGVkIGl0
IGFuZCBvbmx5IGZvdW5kWzFdLAp3aGljaCBkb2Vzbid0IHJlc29sdmUgbXkgcHJvYmxlbSBjb21w
bGV0ZWx5LCBiZWNhdXNlCgogIGdpdCBsb2cgPG9sZGVyIGhhc2g+Li48bmV3ZXIgaGFzaD4KCmRv
ZXNuJ3QgY29udGFpbnMgdGhlIGxvZyBvZiA8b2xkZXIgaGFzaD4uIFNvLCBob3cgdG8gZGlzcGxh
eQpsb2dzIGJldHdlZW4gYSByZXZpc2lvbiByYW5nZSB0aGF0IGJvdGggc3RhcnQgYW5kIGVuZCBh
cmUKaW5jbHVzaXZlPwoKUGxlYXNlIENDIG1lLCB0aGFua3Mu
