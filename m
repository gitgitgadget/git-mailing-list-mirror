Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CBE31F859
	for <e@80x24.org>; Tue,  6 Sep 2016 07:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbcIFHzU (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 03:55:20 -0400
Received: from mail96.atlas.de ([194.156.172.86]:58767 "EHLO mail96.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbcIFHzT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 03:55:19 -0400
X-IPAS-Result: =?us-ascii?q?A2AaBwAlds5X/wXKxApdGgEBAQECAQEBAYMtAQEBAQF1KlK?=
 =?us-ascii?q?DR7ZwJIV4AhyBdhABAgEBAQEBAQGBBYRhAQEBAQIBIxFFBQsCAQgYAgImAgICK?=
 =?us-ascii?q?gYVEAIEDQEFAgEBiD4WsDWMJAEBAQEBAQEBAQEBAQEBAQEBAQEBARcFgQWHIgi?=
 =?us-ascii?q?CToQjAQEyNYI2gloFiC6RJYYhiwOEXoMNJ4VZiQCDTIN6NYRmcIRLgh8BAQE?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW102FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 06 Sep 2016 09:55:12 +0200
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
        id 3sSzR44fBpz2MGjV; Tue,  6 Sep 2016 07:54:15 +0000 (UTC)
Received: from MGW202PAR.atlas.de (unknown [10.206.101.61])
        by SCESRV02.atlas.de (Postfix) with ESMTPS id 3sSzPz44VRz2MGjL
        for <git@vger.kernel.org>; Tue,  6 Sep 2016 07:54:15 +0000 (UTC)
Received: from webmail-seb.atlas.de (HELO MSEXSRV1.atlas.de) ([10.200.102.56])
  by MGW202DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Sep 2016 09:54:15 +0200
Received: from MSEXSRV5.atlas.de ([169.254.3.150]) by MSEXSRV1.atlas.de
 ([10.200.102.56]) with mapi id 14.03.0301.000; Tue, 6 Sep 2016 09:54:15 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <idan@grabcad.com>
CC:     <git@vger.kernel.org>
Subject: Re: Context Menu is missing
Thread-Topic: Context Menu is missing
Thread-Index: AQHSCA4HnFpTwLCarU6/dnl97JlnE6Br7V+AgAABiACAAAF3gIAAA9aAgAAB4QA=
Date:   Tue, 6 Sep 2016 07:54:13 +0000
Message-ID: <89b6f6a2-a793-011b-7351-581be0ee8128@atlas-elektronik.com>
References: <CAFfNYUmMdamkW=Ca-iRDJ35ucr=S8A_qLTmjoD5j1M_ohdCgSg@mail.gmail.com>
 <dd6180a8-8719-e87b-26c1-e73d43167f84@atlas-elektronik.com>
 <CAFfNYUk4QWii7AyG7u2B8G-JGT1Dn0OTopM=FTgaA7DBjYPhfA@mail.gmail.com>
 <939e5f85-341e-cca5-a818-0e8a43f7a88b@atlas-elektronik.com>
 <CAFfNYUmBaydosF8vYwfj1+px3uUfiH4F=jgdCYBdzEw3-5FUGQ@mail.gmail.com>
In-Reply-To: <CAFfNYUmBaydosF8vYwfj1+px3uUfiH4F=jgdCYBdzEw3-5FUGQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <324686FEBECB304C9ADB084F1CCD9FCA@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

KFBsZWFzZSwgcGxlYXNlLCBwbGVhc2UsIHVzZSAicmVwbHkgYWxsIiBpbiB5b3VyIG1haWwgcmVh
ZGVyIGkuZS4gbWFrZSBzdXJlIHlvdSBkb24ndA0KcmVtb3ZlICdnaXRAdmdlci5rZXJuZWwub3Jn
JyBmcm9tIHRoZSAiVG86IiBvciAiQ0M6IiBmaWVsZC4gVGhhbmsgeW91ISkNCg0KQW0gMDYuMDku
MjAxNiB1bSAwOTo0NyBzY2hyaWViIElkYW4gU2hpbW9uaToNCj4gT24gVHVlLCBTZXAgNiwgMjAx
NiBhdCAxMDozMyBBTSwgIDxzdGVmYW4ubmFld2VAYXRsYXMtZWxla3Ryb25pay5jb20+IHdyb3Rl
Og0KPj4gKFBsZWFzZSBkb24ndCB0b3AgcG9zdCBhbmQgZG8gInJlcGx5IGFsbCIpDQo+Pg0KPiBJ
IHRyaWVkIGJ1dCB5b3UgYXJlIHJlY2VpdmluZyBvbmx5IHBsYWluIHRleHQgZW1haWxzLg0KPiBh
bnl3YXkuLi4NCg0KPz8/IEVDQU5OT1RVTkRFUlNUQU5EDQoNClJlYWQgYWJvdXQgdG9wLXBvc3Rp
bmcgaGVyZTogaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvUG9zdGluZ19zdHlsZSNUb3At
cG9zdGluZw0KIA0KPiBJIHJlaW5zdGFsbGVkIHdpbmRvd3Mgb24gbXkgY29tcHV0ZXIgYW5kIHRo
ZW4gaW5zdGFsbGVkIEdpdCB2ZXJzaW9uDQo+IDIuOS4zIGZvciB3aW5kb3dzLg0KPiBBbmQgdGhl
IGNvbnRleHQgbWVudSB3ZXJlIG1pc3NpbmcuDQoNCkluIHRoZSBleHBsb3JlciwgSSBndWVzcyA/
DQoNCj4gSSBhbSB0YWxraW5nIGFib3V0IHRoZSBvbmUgdGhhdCB5b3UgaGFkOg0KPiAtIEdpdCBI
aXN0b3J5DQo+IC0gR2l0IEJyYW5jaA0KPiAgICAtIGJyYW5jaF8xDQo+ICAgIC0gYnJhbmNoXzIN
Cj4gLi4uLg0KDQpHaXQgZm9yIHdpbmRvd3MgKmRvZXNuJ3QqIGluc3RhbGwgdGhhdC4NCg0KPiBH
aXQgR1VJIGFuZCBHaXQgQmFzaCBhcmUgc3RpbGwgdGhlcmUuLi4NCg0KR2l0IGZvciB3aW5kb3dz
ICpkb2VzKiBpbnN0YWxsIHRoYXQuDQoNCk1heWJlIHlvdSBoYWQgVG9ydG9pc2VHaXQgaW5zdGFs
bGVkIGJlZm9yZSAoanVzdCBhIHdpbGQgZ3Vlc3MsIHRob3VnaCkNCg0KU3RlZmFuDQotLSANCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCi9kZXYvcmFuZG9tIHNheXM6IEdhbWJsaW5nOiBUaGUgc3VyZSB3YXkgb2YgZ2V0dGlu
ZyBub3RoaW5nIGZvciBzb21ldGhpbmcuDQpweXRob24gLWMgInByaW50ICc3Mzc0NjU2NjYxNmUy
ZTZlNjE2NTc3NjU0MDYxNzQ2YzYxNzMyZDY1NmM2NTZiNzQ3MjZmNmU2OTZiMmU2MzZmNmQnLmRl
Y29kZSgnaGV4JykiIA0KR1BHIEtleSBmaW5nZXJwcmludCA9IDJERjUgRTAxQiAwOUMzIDc1MDEg
QkNBOSAgOTY2NiA4MjlCIDQ5QzUgOTIyMSAyN0FG
