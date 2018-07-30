Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683651F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeG3R0n (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 13:26:43 -0400
Received: from mail95.atlas.de ([194.156.172.85]:51426 "EHLO mail95.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbeG3R0n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 13:26:43 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2018 13:26:43 EDT
X-IPAS-Result: =?us-ascii?q?A2AUCgDoD19b/wXKxApbHAEBAQQBAQoBAYlWliIIJYM8kim?=
 =?us-ascii?q?BZguEbAIXgx04FAECAQEBAQEBAoEVhTcCAQMjEVUCAQYCGgIUEgICAjAVEAIEA?=
 =?us-ascii?q?QwIAQGDHJFgm0eBLoRehWuBC4dagjSBEicMgl+EQx8PDRcjFYIyglUCh3aEdY0?=
 =?us-ascii?q?lBwKIfYY0iC+FYIxehVmBWIFzcIM6kFKNdSKCJQEB?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW101FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 30 Jul 2018 17:41:25 +0200
Received: from localhost.localdomain (localhost [127.0.0.1])
        by SCESRV02.atlas.de (Postfix) with SMTP id 41fP1f02hSz2yWPG
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 15:41:26 +0000 (UTC)
Received: from MGW202PAR.atlas.de (unknown [10.206.101.61])
        by SCESRV02.atlas.de (Postfix) with ESMTPS id 41fP1d0q0cz2yWPD
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 15:41:25 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW202DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jul 2018 17:41:24 +0200
Received: from MSEXSRV6.atlas.de ([169.254.4.105]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0351.000; Mon, 30 Jul 2018 17:41:24
 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <admin@game-point.net>, <git@vger.kernel.org>
Subject: Re: Strange bug with "git log" - pdftotext?
Thread-Topic: Strange bug with "git log" - pdftotext?
Thread-Index: AQHUKATP6mC5BDXoV0KK2Nju34WHGaSnxe+A
Date:   Mon, 30 Jul 2018 15:41:23 +0000
Message-ID: <7fbab4fc-a0a3-0aca-2974-24ac1ed5197e@atlas-elektronik.com>
References: <5B5F096A.7030404@game-point.net>
In-Reply-To: <5B5F096A.7030404@game-point.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC15B0C71D7E1E4FA50DDE67AF8951B4@atlas-elektronik.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMzAuMDcuMjAxOCB1bSAxNDo0OSBzY2hyaWViIEplcmVteSBNb3J0b246DQo+IEknbSB0cnlp
bmcgdG8gc2VhcmNoIG15IGdpdCBsb2cgaGlzdG9yeSBmb3IgYSBwYXJ0aWN1bGFyIHRlcm0gLSAi
dW5vYnRydXNpdmUiIC0gc28gSSBydW4gdGhpcyBjb21tYW5kOg0KPiANCj4gZ2l0IGxvZyAtUyB1
bm9idHJ1c2l2ZSAtLW9uZWxpbmUNCj4gDQo+IFdoZW4gSSBkbyB0aGlzLCB0aGlzIGlzIGRpc3Bs
YXllZCBhbmQgSSdtIGluIGFuIGludGVyYWN0aXZlIGxlc3MgdGVybWluYWwgb3Igc29tZXRoaW5n
Og0KPiANCj4gcGRmdG90ZXh0IHZlcnNpb24gNC4wMA0KPiBDb3B5cmlnaHQgMTk5Ni0yMDE3IEds
eXBoICYgQ29nLCBMTEMNCj4gVXNhZ2U6IHBkZnRvdGV4dCBbb3B0aW9uc10gPFBERi1maWxlPiBb
PHRleHQtZmlsZT5dDQo+IMKgLWYgPGludD7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiBmaXJz
dCBwYWdlIHRvIGNvbnZlcnQNCj4gwqAtbCA8aW50PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA6
IGxhc3QgcGFnZSB0byBjb252ZXJ0DQo+IMKgLWxheW91dMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDogbWFpbnRhaW4gb3JpZ2luYWwgcGh5c2ljYWwgbGF5b3V0DQo+IMKgLXNpbXBsZcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDogc2ltcGxlIG9uZS1jb2x1bW4gcGFnZSBsYXlvdXQNCj4g
wqAtdGFibGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDogc2ltaWxhciB0byAtbGF5b3V0
LCBidXQgb3B0aW1pemVkIGZvciB0YWJsZXMNCj4gwqAtbGluZXByaW50ZXLCoMKgwqDCoMKgwqDC
oMKgIDogdXNlIHN0cmljdCBmaXhlZC1waXRjaC9oZWlnaHQgbGF5b3V0DQo+IMKgLXJhd8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDoga2VlcCBzdHJpbmdzIGluIGNvbnRlbnQgc3Ry
ZWFtIG9yZGVyDQo+IMKgLWZpeGVkIDxudW1iZXI+wqDCoMKgwqDCoCA6IGFzc3VtZSBmaXhlZC1w
aXRjaCAob3IgdGFidWxhcikgdGV4dA0KPiDCoC1saW5lc3BhY2luZyA8bnVtYmVyPjogZml4ZWQg
bGluZSBzcGFjaW5nIGZvciBMaW5lUHJpbnRlciBtb2RlDQo+IMKgLWNsaXDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgOiBzZXBhcmF0ZSBjbGlwcGVkIHRleHQNCj4gwqAtbm9kaWFnwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiBkaXNjYXJkIGRpYWdvbmFsIHRleHQNCj4gwqAtZW5j
IDxzdHJpbmc+wqDCoMKgwqDCoMKgwqAgOiBvdXRwdXQgdGV4dCBlbmNvZGluZyBuYW1lDQo+IMKg
LWVvbCA8c3RyaW5nPsKgwqDCoMKgwqDCoMKgIDogb3V0cHV0IGVuZC1vZi1saW5lIGNvbnZlbnRp
b24gKHVuaXgsIGRvcywgb3IgbWFjKQ0KPiDCoC1ub3BnYnJrwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDogZG9uJ3QgaW5zZXJ0IHBhZ2UgYnJlYWtzIGJldHdlZW4gcGFnZXMNCj4gwqAtYm9twqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiBpbnNlcnQgYSBVbmljb2RlIEJPTSBhdCB0
aGUgc3RhcnQgb2YgdGhlIHRleHQgZmlsZQ0KPiDCoC1vcHcgPHN0cmluZz7CoMKgwqDCoMKgwqDC
oCA6IG93bmVyIHBhc3N3b3JkIChmb3IgZW5jcnlwdGVkIGZpbGVzKQ0KPiDCoC11cHcgPHN0cmlu
Zz7CoMKgwqDCoMKgwqDCoCA6IHVzZXIgcGFzc3dvcmQgKGZvciBlbmNyeXB0ZWQgZmlsZXMpDQo+
IMKgLXHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiBkb24ndCBwcmludCBh
bnkgbWVzc2FnZXMgb3IgZXJyb3JzDQo+IMKgLWNmZyA8c3RyaW5nPsKgwqDCoMKgwqDCoMKgIDog
Y29uZmlndXJhdGlvbiBmaWxlIHRvIHVzZSBpbiBwbGFjZSBvZiAueHBkZnJjDQo+IMKgLXbCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiBwcmludCBjb3B5cmlnaHQgYW5kIHZl
cnNpb24gaW5mbw0KPiA6DQo+IA0KPiBXaGVuIEkgaGl0IHRoZSBkb3duIGFycm93LCBpdCBzY3Jv
bGxzIGRvd24sIHJlcGVhdGluZyB0aGlzIG91dHB1dCBpbmZpbml0ZWx5IHVudGlsIEkgaGl0ICdx
Jy7CoCBXaGF0IGlzIGdvaW5nIG9uIGhlcmU/Pw0KPiANCg0KV2lsZCBndWVzczogWW91J3JlIHVz
aW5nICJHaXQgZm9yIFdpbmRvd3MiIG9uIGEgdmVyc2lvbiBsZXNzIHRoYW4gIjIuMTguMC53aW5k
b3dzLjEiID8NCg0KVHJ5IHVwZ3JhZGluZyAoYXQgbGVhc3QpIHRvIHRoYXQgdmVyc2lvbi4gSUlS
QyB0aGF0J3Mgb25lIG9mIHRoZSBpc3N1ZXMgaXQgZml4ZXMuDQoNCkhUSA0KU3RlZmFuDQotLSAN
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCi9kZXYvcmFuZG9tIHNheXM6IE5ldmVyIHVuZGVyZXN0aW1hdGUgdGhlIHBvd2Vy
IG9mIGh1bWFuIHN0dXBpZGl0eS4NCnB5dGhvbiAtYyAicHJpbnQgJzczNzQ2NTY2NjE2ZTJlNmU2
MTY1Nzc2NTQwNjE3NDZjNjE3MzJkNjU2YzY1NmI3NDcyNmY2ZTY5NmIyZTYzNmY2ZCcuZGVjb2Rl
KCdoZXgnKSIgDQpHUEcgS2V5IGZpbmdlcnByaW50ID0gMkRGNSBFMDFCIDA5QzMgNzUwMSBCQ0E5
ICA5NjY2IDgyOUIgNDlDNSA5MjIxIDI3QUY=

