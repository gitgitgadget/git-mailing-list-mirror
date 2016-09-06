Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CA1E1F859
	for <e@80x24.org>; Tue,  6 Sep 2016 08:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933093AbcIFIUZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 04:20:25 -0400
Received: from mail96.atlas.de ([194.156.172.86]:33924 "EHLO mail96.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932948AbcIFIUV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 04:20:21 -0400
X-IPAS-Result: =?us-ascii?q?A2BJCADEe85X/wTKxApdGwEBAQMBAQGDLQEBAQEBdSpSg0e?=
 =?us-ascii?q?2cCSFeAIcgXcQAQIBAQEBAQEBgQWEYgEBBCMRVQIBCBgCAiYCAgIqBhUQAgQBD?=
 =?us-ascii?q?AYCAQGIVLAfjCUBAQEBAQUBAQEBAQEBGwWBBYciglaEIwEBGxeCa4JaBYgukSW?=
 =?us-ascii?q?GIYsDhF6DDSeFWYkAg0yDejWCfhuBTXCES4IfAQEB?=
Received: from scesrv01.atlas.de ([10.196.202.4])
  by MGW102FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 06 Sep 2016 10:20:17 +0200
Received: by SCESRV01.atlas.de (Postfix, from userid 600)
        id 3sT0014Q3zz17mP9; Tue,  6 Sep 2016 08:20:17 +0000 (UTC)
Received: from MGW202PAR.atlas.de (unknown [10.206.101.61])
        by SCESRV01.atlas.de (Postfix) with ESMTPS id 3sT00123G4z17mSd
        for <git@vger.kernel.org>; Tue,  6 Sep 2016 08:20:17 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW202DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Sep 2016 10:20:17 +0200
Received: from MSEXSRV5.atlas.de ([169.254.3.150]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0301.000; Tue, 6 Sep 2016 10:20:17 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <idan@grabcad.com>, <git@vger.kernel.org>
Subject: Re: Context Menu is missing
Thread-Topic: Context Menu is missing
Thread-Index: AQHSCA4HnFpTwLCarU6/dnl97JlnE6Br7V+AgAABiACAAAF3gIAAA9aAgAAB4QCAAAOhgIAAA6UA
Date:   Tue, 6 Sep 2016 08:20:15 +0000
Message-ID: <50fc49a6-68a2-040b-beb1-feb162c458d2@atlas-elektronik.com>
References: <CAFfNYUmMdamkW=Ca-iRDJ35ucr=S8A_qLTmjoD5j1M_ohdCgSg@mail.gmail.com>
 <dd6180a8-8719-e87b-26c1-e73d43167f84@atlas-elektronik.com>
 <CAFfNYUk4QWii7AyG7u2B8G-JGT1Dn0OTopM=FTgaA7DBjYPhfA@mail.gmail.com>
 <939e5f85-341e-cca5-a818-0e8a43f7a88b@atlas-elektronik.com>
 <CAFfNYUmBaydosF8vYwfj1+px3uUfiH4F=jgdCYBdzEw3-5FUGQ@mail.gmail.com>
 <89b6f6a2-a793-011b-7351-581be0ee8128@atlas-elektronik.com>
 <CAFfNYUkUpaCo8uYv=fofPRyCgg7db4M2fh7BJRc4WCHZdbxvsw@mail.gmail.com>
In-Reply-To: <CAFfNYUkUpaCo8uYv=fofPRyCgg7db4M2fh7BJRc4WCHZdbxvsw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3E57E968EA46D43B1417ACAE18D7E8D@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

KGFuZCBzL2hlIGRpZCBpdCBhZ2Fpbi4uLi5oaXR0aW5nICJyZXBseSBhbGwiIHNlZW1zIHJlYWxs
eSBjb21wbGljYXRlZCkNCg0KQW0gMDYuMDkuMjAxNiB1bSAxMDowNyBzY2hyaWViIElkYW4gU2hp
bW9uaToNCj4gaXQgaXMgcGFydCBvZiBnaXQgY2hlZXRhaCBwbHVnaW4gbm90IHRvcnRvaXNlLg0K
PiBCdXQgaXQgd2FzIHBhcnQgb2YgdGhlIGdpdCBpbnN0YWxsZXIgZm9yIHdpbmRvd3MsIEkgZGlk
IG5vdCBpbnN0YWxsZWQNCj4gYW55dGhpbmcgZWxzZSBiZWZvcmUuDQo+IA0KPiBPbiBUdWUsIFNl
cCA2LCAyMDE2IGF0IDEwOjU0IEFNLCAgPHN0ZWZhbi5uYWV3ZUBhdGxhcy1lbGVrdHJvbmlrLmNv
bT4gd3JvdGU6DQo+PiAoUGxlYXNlLCBwbGVhc2UsIHBsZWFzZSwgdXNlICJyZXBseSBhbGwiIGlu
IHlvdXIgbWFpbCByZWFkZXIgaS5lLiBtYWtlIHN1cmUgeW91IGRvbid0DQo+PiByZW1vdmUgJ2dp
dEB2Z2VyLmtlcm5lbC5vcmcnIGZyb20gdGhlICJUbzoiIG9yICJDQzoiIGZpZWxkLiBUaGFuayB5
b3UhKQ0KPj4NCj4+IEFtIDA2LjA5LjIwMTYgdW0gMDk6NDcgc2NocmllYiBJZGFuIFNoaW1vbmk6
DQo+Pj4gT24gVHVlLCBTZXAgNiwgMjAxNiBhdCAxMDozMyBBTSwgIDxzdGVmYW4ubmFld2VAYXRs
YXMtZWxla3Ryb25pay5jb20+IHdyb3RlOg0KPj4+PiAoUGxlYXNlIGRvbid0IHRvcCBwb3N0IGFu
ZCBkbyAicmVwbHkgYWxsIikNCj4+Pj4NCj4+PiBJIHRyaWVkIGJ1dCB5b3UgYXJlIHJlY2Vpdmlu
ZyBvbmx5IHBsYWluIHRleHQgZW1haWxzLg0KPj4+IGFueXdheS4uLg0KPj4NCj4+ID8/PyBFQ0FO
Tk9UVU5ERVJTVEFORA0KPj4NCj4+IFJlYWQgYWJvdXQgdG9wLXBvc3RpbmcgaGVyZTogaHR0cHM6
Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvUG9zdGluZ19zdHlsZSNUb3AtcG9zdGluZw0KPj4NCj4+
PiBJIHJlaW5zdGFsbGVkIHdpbmRvd3Mgb24gbXkgY29tcHV0ZXIgYW5kIHRoZW4gaW5zdGFsbGVk
IEdpdCB2ZXJzaW9uDQo+Pj4gMi45LjMgZm9yIHdpbmRvd3MuDQo+Pj4gQW5kIHRoZSBjb250ZXh0
IG1lbnUgd2VyZSBtaXNzaW5nLg0KPj4NCj4+IEluIHRoZSBleHBsb3JlciwgSSBndWVzcyA/DQo+
Pg0KPj4+IEkgYW0gdGFsa2luZyBhYm91dCB0aGUgb25lIHRoYXQgeW91IGhhZDoNCj4+PiAtIEdp
dCBIaXN0b3J5DQo+Pj4gLSBHaXQgQnJhbmNoDQo+Pj4gICAgLSBicmFuY2hfMQ0KPj4+ICAgIC0g
YnJhbmNoXzINCj4+PiAuLi4uDQo+Pg0KPj4gR2l0IGZvciB3aW5kb3dzICpkb2Vzbid0KiBpbnN0
YWxsIHRoYXQuDQo+Pg0KPj4+IEdpdCBHVUkgYW5kIEdpdCBCYXNoIGFyZSBzdGlsbCB0aGVyZS4u
Lg0KPj4NCj4+IEdpdCBmb3Igd2luZG93cyAqZG9lcyogaW5zdGFsbCB0aGF0Lg0KPj4NCj4+IE1h
eWJlIHlvdSBoYWQgVG9ydG9pc2VHaXQgaW5zdGFsbGVkIGJlZm9yZSAoanVzdCBhIHdpbGQgZ3Vl
c3MsIHRob3VnaCkNCj4+DQo+PiBTdGVmYW4NCj4+IC0tDQo+PiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAvZGV2L3Jh
bmRvbSBzYXlzOiBHYW1ibGluZzogVGhlIHN1cmUgd2F5IG9mIGdldHRpbmcgbm90aGluZyBmb3Ig
c29tZXRoaW5nLg0KPj4gcHl0aG9uIC1jICJwcmludCAnNzM3NDY1NjY2MTZlMmU2ZTYxNjU3NzY1
NDA2MTc0NmM2MTczMmQ2NTZjNjU2Yjc0NzI2ZjZlNjk2YjJlNjM2ZjZkJy5kZWNvZGUoJ2hleCcp
Ig0KPj4gR1BHIEtleSBmaW5nZXJwcmludCA9IDJERjUgRTAxQiAwOUMzIDc1MDEgQkNBOSAgOTY2
NiA4MjlCIDQ5QzUgOTIyMSAyN0FGDQo+IA0KPiANCj4gDQoNCg0KLS0gDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQovZGV2
L3JhbmRvbSBzYXlzOiBHaXZlIGluc3RydWN0aW9uIHRvIGEgd2lzZSBtYW4gYW5kIGhlIHdpbGwg
YmUgeWV0IHdpc2VyLg0KcHl0aG9uIC1jICJwcmludCAnNzM3NDY1NjY2MTZlMmU2ZTYxNjU3NzY1
NDA2MTc0NmM2MTczMmQ2NTZjNjU2Yjc0NzI2ZjZlNjk2YjJlNjM2ZjZkJy5kZWNvZGUoJ2hleCcp
IiANCkdQRyBLZXkgZmluZ2VycHJpbnQgPSAyREY1IEUwMUIgMDlDMyA3NTAxIEJDQTkgIDk2NjYg
ODI5QiA0OUM1IDkyMjEgMjdBRg==
