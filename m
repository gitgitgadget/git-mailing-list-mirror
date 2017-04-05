Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6476F1FAFB
	for <e@80x24.org>; Wed,  5 Apr 2017 09:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbdDEJRM (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 05:17:12 -0400
Received: from sirac.alma.fr ([164.177.24.217]:38954 "EHLO sirac.alma.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932671AbdDEJRK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 05:17:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by localhost.alma.fr (Postfix) with ESMTP id A3D90130005;
        Wed,  5 Apr 2017 11:14:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at alma.fr
Received: from sirac.alma.fr ([127.0.0.1])
        by localhost (sirac.alma.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bQbeBWCI2EWn; Wed,  5 Apr 2017 11:14:43 +0200 (CEST)
Received: from mail.alma.fr (srv-mail.alma.fr [172.30.1.23])
        by sirac.alma.fr (Postfix) with ESMTP id DFB4E130003;
        Wed,  5 Apr 2017 11:14:43 +0200 (CEST)
Received: from SRV-MAIL.alma.fr (172.30.1.23) by SRV-MAIL.alma.fr
 (172.30.1.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.544.27; Wed, 5 Apr
 2017 11:17:06 +0200
Received: from SRV-MAIL.alma.fr ([fe80::c172:69ed:574b:5afd]) by
 SRV-MAIL.alma.fr ([fe80::c172:69ed:574b:5afd%12]) with mapi id
 15.01.0544.027; Wed, 5 Apr 2017 11:17:05 +0200
From:   =?utf-8?B?UsOpbWkgR2FsYW4gQWxmb25zbw==?= 
        <remi.galanalfonso@almacam.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: RE: Segfault on git for Windows
Thread-Topic: Segfault on git for Windows
Thread-Index: AdKt2g2s+n9h7ytfTvKk1LS/47qVbQAAAS2AAATPnpA=
Date:   Wed, 5 Apr 2017 09:17:05 +0000
Message-ID: <d7257257ee1047b4aefdede494df70b0@almacam.com>
References: <ca311f4c1abc4460b6bc2d444916b6bf@almacam.com>
 <alpine.DEB.2.20.1704051057150.4268@virtualbox>
In-Reply-To: <alpine.DEB.2.20.1704051057150.4268@virtualbox>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.9.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBIaSBSw6ltaSwNCj4gDQo+IE9uIFdlZCwgNSBBcHIgMjAxNywgUsOpbWkgR2FsYW4gQWxmb25z
byB3cm90ZToNCj4gDQo+ID4gQXQgJERBWVdPUkssIHRoZSBjb2RlIGlzIHZlcnNpb25uZWQgdW5k
ZXIgU1ZOLiBTaW5jZSBJIGhhdmVuJ3QgdXNlZCBTVk4NCj4gPiBiZWZvcmUgYW5kIHRyeSB0byBo
YXZlIGEgY2xlYW4gYW5kIGJpc2VjdGFibGUgaGlzdG9yeSwgSSBpbnN0YWxsZWQgZ2l0DQo+ID4g
d2l0aCB0aGUgaW50ZW50IHRvIG1hbmFnZSBteSBjb2RlIGxvY2FsbHkgYmVmb3JlIHB1c2hpbmcg
dG8gU1ZOIHdoZW4gSSdtDQo+ID4gc2F0aXNmaWVkIChJIGhhdmVuJ3QgdHJpZXMgZ2l0LXN2biBi
ZWNhdXNlIEkgaGF2ZSBuZXZlciB1c2VkIGl0IGFuZA0KPiA+IHdvdWxkIGxpa2UgdG8gYXZvaWQg
c2NyZXdpbmcgdXAgdGhlIFNWTiByZXBvIGJ5IHNvbWUgbWlzdGFrZSkuDQo+ID4gDQo+ID4gU28g
Zmlyc3QgdG8gc2V0dXAgdGhlIGxvY2FsIHJlcG8sIEkgd2FudGVkIHRvIGFkZCBhbGwgb2YgdGhl
IGNvZGUgZmlsZXMuDQo+ID4gU28gSSBmaXJzdCByYW4gYXQgdGhlIHJvb3Qgb2YgdGhlIHJlcG86
DQo+ID4gICAkIGdpdCBhZGQgLi8qKi5jcHANCj4gPiBXaGljaCBpcyBxdWl0ZSBhIGJpZyBhbW91
bnQgb2YgZmlsZXMgKHBhcnRseSBiZWNhdXNlIG9mIGV4dGVybmFsDQo+ID4gZGVwZW5kZW5jaWVz
IHdoaWNoIHdvdWxkIGhhdmUgYmVlbiBzbWFydCB0byBleGNsdWRlLCBidXQgaXQncyBkb25lKS4N
Cj4gPiAgICQgZmluZCAtdHlwZSBmIC1uYW1lICIqKi5jcHAiIHwgd2MgLWwNCj4gPiAgIDg2NzYN
Cj4gPiBUaGlzIGNvbW1hbmQgd29ya2VkIChyZXR1cm4gc3RhdHVzIGlzIDAgYW5kIG5vIGVycm9y
IG1lc3NhZ2UpLg0KPiA+IA0KPiA+IEhvd2V2ZXIgZm9sbG93aW5nIGBnaXQgYWRkICoqLmhwcGAg
YW5kIGBnaXQgc3RhdHVzYCBzZWdmYXVsdCB3aXRoIG5vDQo+ID4gYWRkaXRpb25hbCBtZXNzYWdl
Og0KPiA+ICAgJCBnaXQgc3RhdHVzDQo+ID4gICBTZWdtZW50YXRpb24gZmF1bHQNCj4gDQo+IEkg
dGhpbmsgdGhpcyBpcyB0aGUgcHJvYmxlbSBpZGVudGlmaWVkIGluDQo+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9naXQtZm9yLXdpbmRvd3MvZ2l0L2lzc3Vlcy8xMTExLg0KPiANCj4gVG8gdmVyaWZ5LCB5
b3UgY291bGQgdHJ5IHRoZSBzbmFwc2hvdCAod2l0aCB0aGUgcHJvcG9zZWQgZml4KSBob3N0ZWQg
aGVyZToNCj4gaHR0cDovL3dpbmdpdC5ibG9iLmNvcmUud2luZG93cy5uZXQvZmlsZXMvaW5kZXgu
aHRtbA0KDQpUaGFua3MsIGl0IGZpeGVkIGl0LiBTb3JyeSBmb3IgdGhlIG5vaXNlLg0KUsOpbWkN
Cg==
