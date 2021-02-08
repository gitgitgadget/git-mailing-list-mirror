Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9ADC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 13:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A206164E7B
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 13:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhBHNtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 08:49:45 -0500
Received: from smtp24.hk.chengmail.me ([113.10.190.40]:54927 "EHLO
        smtp24.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBHNte (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 08:49:34 -0500
X-CHENGMAILHOST: 113.10.190.40
X-CHENGMAIL-INSTANCEID: 1ef4.6021413a.63c7b.0
Date:   Mon, 8 Feb 2021 21:48:42 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Derrick Stolee" <stolee@gmail.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        dscho <johannes.schindelin@gmx.de>
Subject: Re: Re: [PATCH v2 0/2] builtin/clone.c: add --no-shallow option
References: <pull.865.git.1612409491842.gitgitgadget@gmail.com>, 
        <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>, 
        <32bb0d006a1211ebb94254a05087d89a835@gmail.com>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <202102082148345658714@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <5e201c406a1411ebad520024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzLCBoYXZlIGRvbmUuIEFuZCBJIGFtIHdhaXRpbmcgZm9yIGFsbCBDSSBvbiBHaXRodWIg
dG8gdHVybiBncmVlbi4KLS0tLS0tLS0tLS0tLS0KbGlsaW5jaGFvQG9zY2hpbmEuY24KPk9uIDIv
OC8yMDIxIDM6MzEgQU0sIExpIExpbmNoYW8gdmlhIEdpdEdpdEdhZGdldCB3cm90ZToKPj4gUmFu
Z2UtZGlmZiB2cyB2MToKPj4KPj7CoCAxOsKgIDU5NDMyMzY4NGFmMCA9IDE6wqAgMmY5NjAyNDk1
ZWI1IGJ1aWx0aW4vY2xvbmUuYzogYWRkIC0tbm8tc2hhbGxvdyBvcHRpb24KPj7CoCAtOsKgIC0t
LS0tLS0tLS0tLSA+IDI6wqAgY2ZjZmMzZWM2YjM3IGJ1aWx0aW4vY2xvbmUuYzogYWRkIC0tcmVq
ZWN0LXNoYWxsb3cgb3B0aW9uCj4KPllvdSBzaG91bGQgcmV3cml0ZSB5b3VyIGhpc3RvcnkgdG8g
bWFrZSB0aGlzIG9uZSBjb21taXQgYWdhaW4uIFlvdSBjYW4KPmRvIHRoaXMgYnkgcnVubmluZyAn
Z2l0IHJlYmFzZSAtaSBIRUFEfjInIHRoZW4gZWRpdGluZyB0aGUgdG9kbyBmaWxlCj50byAnc3F1
YXNoJyB0aGUgc2Vjb25kIGNvbW1pdCBpbiB0byB0aGUgZmlyc3QuIFlvdSB3aWxsIGJlIHByb21w
dGVkIHRvCj5lZGl0IHRoZSBjb21iaW5lZCBjb21taXQgbWVzc2FnZSwgYW5kIHlvdSBzaG91bGQg
cHJlc2VydmUgb25seSB0aGUgbWVzc2FnZQo+ZnJvbSB0aGUgc2Vjb25kIGNvbW1pdC4KPgo+VGhh
bmtzLAo+LVN0b2xlZQo+

