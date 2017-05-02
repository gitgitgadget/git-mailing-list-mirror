Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11ACF1F790
	for <e@80x24.org>; Tue,  2 May 2017 13:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750892AbdEBNeC (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 09:34:02 -0400
Received: from mail.gea.fr ([89.225.222.218]:55736 "EHLO mail.gea.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbdEBNeB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 09:34:01 -0400
Received: from SVGEA-EMAIL.gea.fr ([2002:8526:28::8526:28]) by
 SVGEA-EMAIL.gea.fr ([2002:8526:28::8526:28]) with mapi id 14.01.0438.000;
 Tue, 2 May 2017 15:33:59 +0200
From:   Delanoe Eric <e.delanoe@gea.fr>
To:     Christian Couder <christian.couder@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Could GIT manage revision headers embedded in code ?
Thread-Topic: Could GIT manage revision headers embedded in code ?
Thread-Index: AdLDNoNKrV9VmwHgQBaB7bZ4RuR4nP//69cA///H+OA=
Date:   Tue, 2 May 2017 13:33:58 +0000
Message-ID: <135C7A92C7D64E488B830ADC2970C70132AE7442@SVGEA-EMAIL.gea.fr>
References: <135C7A92C7D64E488B830ADC2970C70132AE6407@SVGEA-EMAIL.gea.fr>
 <CAP8UFD0NrTyGYgHeEOWpUH5v0ejKvcKu+Mzd8_scYbvzL4b4zg@mail.gmail.com>
In-Reply-To: <CAP8UFD0NrTyGYgHeEOWpUH5v0ejKvcKu+Mzd8_scYbvzL4b4zg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [133.38.10.48]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIHF1aWNrIGFuc3dlci4NCkFuZCBncmVhdCBhbnN3ZXIgISBJJ20g
bG9va2luZyBmb3J3YXJkIHRvIHRyeSB0aGlzLg0KDQpUaGFua3MgYWdhaW4gYW5kIGJlc3QgcmVn
YXJkcywNCkUuRGVsYW5vw6sNCg0KDQotLS0tLU1lc3NhZ2UgZCdvcmlnaW5lLS0tLS0NCkRlwqA6
IENocmlzdGlhbiBDb3VkZXIgW21haWx0bzpjaHJpc3RpYW4uY291ZGVyQGdtYWlsLmNvbV0gDQpF
bnZvecOpwqA6IG1hcmRpIDIgbWFpIDIwMTcgMTQ6MTENCsOAwqA6IERlbGFub2UgRXJpYw0KQ2PC
oDogZ2l0QHZnZXIua2VybmVsLm9yZw0KT2JqZXTCoDogUmU6IENvdWxkIEdJVCBtYW5hZ2UgcmV2
aXNpb24gaGVhZGVycyBlbWJlZGRlZCBpbiBjb2RlID8NCg0KSGksDQoNCk9uIFR1ZSwgTWF5IDIs
IDIwMTcgYXQgMTo0OCBQTSwgRGVsYW5vZSBFcmljIDxlLmRlbGFub2VAZ2VhLmZyPiB3cm90ZToN
Cj4gSGVsbG8sDQo+DQo+IFdlIG5lZWQgYSBncmVhdCBkZWFsIG9mIHRyYWNlYWJpbGl0eSBmb3Ig
b3VyIHNvdXJjZSwgbWFkZSBvZiBtYW55IHNjcmlwdHMgaW4gaW50ZXJwcmV0ZWQgbGFuZ3VhZ2Vz
LCBzcHJlYWQgaW4gbWFueSAiaW5kZXBlbmRlbnQiIG1vZHVsZXMsIGFzIGZhciBhcyBjYW4gYmUg
Oy0pLg0KPiBJbiBwYXJ0aWN1bGFyLCBzb21lYm9keSB0cm91Ymxlc2hvb3RpbmcgYSBzY3JpcHQg
aW4gcHJvZHVjdGlvbiBzaG91bGQgYmUgYWJsZSB0byBrbm93IGV4YWN0bHkgdGhlIHJldmlzaW9u
IG9yIGNvbW1pdCBJRCAob3IgdGFnIGxhYmVsKSBvZiBhIGdpdmVuIGZpbGUsIGFuZCBpdHMgbG9j
YXRpb24gaW4gdGhlIEdJVCBzb3VyY2UgZGlyZWN0b3J5IHRyZWUuDQo+DQo+IE91ciBvbGQgQ1ZT
Li4uIGxldCdzIHNheSBpdCB3YXMgaXRzIG9ubHkgYWR2YW50YWdlLi4uIHdhcyBkb2luZyB0aGlz
IHdpdGgga2V5d29yZHMgZW1iZWRkZWQgaW4gY29kZSBjb21tZW50czogJEhlYWRlciQsICRJZCQs
ICRSZXYkLCAkRmlsZSQgZXRjLi4uIFdoZW4gYSBmaWxlIHdhcyBjb21taXR0ZWQsIGl0cyAkSGVh
ZGVyJCBrZXl3b3JkIHdhcyBleHBhbmRlZCBpbnRvIGEgcmljaCBwaWVjZSBvZiAidmVyc2lvbiIg
aW5mb3JtYXRpb24gbGlrZSAnJyAkSGVhZGVyOiAvY3Zzc3RvcmUvU291cmNlc09yYWNsZS9JbnN0
YWxsL0NPTU1VTi9DU1Quc3FsLHYgMS42OS4yLjEwIDIwMTcvMDQvMTQgMDk6Mzg6NDggZWRlbGFu
b2UgJCIuDQo+DQo+IENvdWxkIHRoaXMga2luZCBvZiAia2V5d29yZCBleHBhbnNpb24iIGZlYXR1
cmUgYmUgYWRkZWQgaW50byBHSVQgPw0KDQpZb3UgY2FuIGFscmVhZHkgZG8gaXQgd2l0aCAic211
ZGdlIiBhbmQgImNsZWFuIiBmaWx0ZXJzLiBMb29rIGZvciAiS2V5d29yZCBFeHBhbnNpb24iIGlu
Og0KDQpodHRwczovL2dpdC1zY20uY29tL2Jvb2svZW4vdjIvQ3VzdG9taXppbmctR2l0LUdpdC1B
dHRyaWJ1dGVzDQo=
