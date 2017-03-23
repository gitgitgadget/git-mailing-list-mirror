Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8E0D2095F
	for <e@80x24.org>; Thu, 23 Mar 2017 04:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbdCWESP (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 00:18:15 -0400
Received: from vpn.innerrange.com.au ([203.122.143.146]:56245 "EHLO
        remote.innerrange.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751007AbdCWESO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 00:18:14 -0400
Received: from IR-CENTRAL.corp.innerrange.com ([fe80::216f:2d6c:20cc:241b]) by
 IR-CENTRAL.corp.innerrange.com ([fe80::216f:2d6c:20cc:241b%15]) with mapi;
 Thu, 23 Mar 2017 15:18:06 +1100
From:   Craig McQueen <craig.mcqueen@innerrange.com>
To:     Eric Wong <e@80x24.org>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Thu, 23 Mar 2017 15:18:04 +1100
Subject: RE: git svn and SVN property svn:original-date
Thread-Topic: git svn and SVN property svn:original-date
Thread-Index: AdKjgRO1GoWKZwg1S8KszqJT6ZC+VwACR+/Q
Message-ID: <5500469A22567C4BAF673A6E86AFA3A40295E65B4365@IR-CENTRAL.corp.innerrange.com>
References: <5500469A22567C4BAF673A6E86AFA3A40295E65B42D1@IR-CENTRAL.corp.innerrange.com>
 <20170323025623.GA14619@starla>
In-Reply-To: <20170323025623.GA14619@starla>
Accept-Language: en-US, en-AU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, en-AU
x-tm-as-product-ver: SMEX-11.1.0.1278-8.100.1062-22956.006
x-tm-as-result: No--14.349300-5.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RXJpYyBXb25nIHdyb3RlOg0KPiBDcmFpZyBNY1F1ZWVuIDxjcmFpZy5tY3F1ZWVuQGlubmVycmFu
Z2UuY29tPiB3cm90ZToNCj4gPiBXaGVuIGRvaW5nICJnaXQgc3ZuIGRjb21taXQiLCB0aGUgU1ZO
IHJldmlzaW9uIGp1c3QgaGFzIHRoZSBkYXRlL3RpbWUNCj4gc3RhbXAgb2YgdGhlIHRpbWUgb2Yg
dGhlIGRjb21taXQuDQo+IA0KPiBZZWFoLCB0aGF0J3Mgc29tZXRpbWVzIGFubm95aW5nIHRvIG1l
LCB0b28uDQo+IA0KPiA+IEFwcGFyZW50bHkgU1ZOIHJldmlzaW9ucyBjYW4gaGF2ZSBhbiAic3Zu
Om9yaWdpbmFsLWRhdGUiIHByb3BlcnR5LCB3aGljaA0KPiB3b3VsZCBiZSBnb29kIHRvIHNldCBv
biBkY29tbWl0LCB0byBwcmVzZXJ2ZSB0aGUgdGltZXN0YW1wIGZyb20gdGhlIGdpdA0KPiByZXBv
c2l0b3J5Lg0KPiA+DQo+ID4NCj4gaHR0cHM6Ly9zdWJ2ZXJzaW9uLmFwYWNoZS5vcmcvZG9jcy9h
cGkvMS43L2dyb3VwX19zdm5fX3Byb3BzX19yZXZpc2lvbg0KPiA+IF9fcHJvcHMuaHRtbCNnYThm
MTczNTFkZDA1NjE0OWRhOWNiNDkwZjFkYWY0MDE4DQo+IA0KPiBBbnkgaWRlYSBpZiB3aGljaCB2
ZXJzaW9ucyBvZiBTVk4gaXQncyBzdXBwb3J0ZWQgaW4gYW5kIGhvdyByZWNlbnQgdGhlDQo+IGZl
YXR1cmUgaXM/DQoNCkkgc2VlIGRpc2N1c3Npb24gYWJvdXQgaXQgaW4gMjAwMywgc28gSSBndWVz
cyBpdCdzIGJlZW4gdGhlcmUgcmlnaHQgZnJvbSAxLjAuMC4NCg0KPiBQZXJoYXBzIHdlIGNhbiBl
bmFibGUgaXQgZXZlcnl3aGVyZSwgYW5kIG1heWJlIG9ubHkgb2xkIGNsaWVudHMgd29uJ3QNCj4g
dW5kZXJzdGFuZCBpdCwgYnV0IHdvbid0IGZhaWw7IGFuZCB3ZSBjb3VsZCBzdGFydCB1c2luZyBp
dCBhcyB0aGUgYXV0aG9yIGRhdGUNCj4gd2l0aCAiZ2l0IHN2biBmZXRjaCIuDQoNClVzaW5nIGl0
IGZvciBhdXRob3IgZGF0ZSBzb3VuZHMgc2Vuc2libGUuDQoNCj4gT1RPSCwgdGhhdCB3b3VsZCBi
cmVhayB0aGUgKHBlcmhhcHMgdW5vZmZpY2lhbCkgaW5kZXBlbmRlbnRseS1jcmVhdGVkLWdpdC0N
Cj4gc3ZuLW1pcnJvcnMtc2hvdWxkLWhhdmUtc2FtZS1vaWRzLWJ5LWRlZmF1bHQNCj4gcnVsZSB3
aGVuIHBlb3BsZSBydW4gZGlmZmVyZW50IHZlcnNpb25zIG9mIGdpdCwgc28gbWF5YmUgaXQgY291
bGQgYmUgYW4NCj4gb3B0aW9uLi4uDQoNCkhtbSwgZ29vZCBxdWVzdGlvbi4gTWF5YmUgaXQgc2hv
dWxkIGJlIGFuIG9wdGlvbiwgdGhvdWdoIEkgaG9wZSBpdCB3b3VsZCBiZSBlbmFibGVkIGJ5IGRl
ZmF1bHQgKHNpbmNlIHRoZSBmZWF0dXJlIHdvdWxkIGJlIG1vcmUgbWV0YWRhdGEtcHJlc2Vydmlu
Zywgd2hpY2ggaXMgYSBnb29kIHRoaW5nKSwgd2l0aCBhbiBvcHRpb24gdG8gZGlzYWJsZSBpdCB0
byBhbGxvdyBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSB3aXRoIHBlb3BsZSBydW5uaW5nIGFuIG9s
ZGVyIHZlcnNpb24gb2YgZ2l0LiBUaGF0J3MgbXkgb3BpbmlvbiBhbnl3YXksIGFuZCBJIHJlYWxp
c2UgbXkgb3BpbmlvbiBpcyBub3QgbmVjZXNzYXJpbHkgd2VsbC1pbmZvcm1lZCByZWdhcmRpbmcg
YWxsIGNvbnNpZGVyYXRpb25zLg0KDQpOb3RlLCBJJ20gdW5jbGVhciBhcyB0byB3aGV0aGVyIFN1
YnZlcnNpb24gaXMgd2lsbGluZyB0byBzdG9yZSB0aW1lem9uZSBpbmZvcm1hdGlvbiBpbiBzdm46
b3JpZ2luYWwtZGF0ZS4gQnV0IEkgZ3Vlc3MgaGF2aW5nIGdpdCBhdXRob3IgZGF0ZSBjb3JyZXNw
b25kIHRvIHN2bjpvcmlnaW5hbC1kYXRlIGlzIGFuIGltcHJvdmVtZW50IGZvciBwcmVzZXJ2aW5n
IG1vcmUgbWV0YWRhdGEsIGV2ZW4gaWYgdGhlIHRpbWV6b25lIGlzIGxvc3QgaW4gdGhlIHByb2Nl
c3MuDQoNCi0tIA0KQ3JhaWcgTWNRdWVlbg0KDQo=
