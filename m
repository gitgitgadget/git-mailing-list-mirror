Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9DA1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 14:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758920AbcLAONm (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 09:13:42 -0500
Received: from mail95.atlas.de ([194.156.172.85]:8521 "EHLO mail95.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756063AbcLAONl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 09:13:41 -0500
X-IPAS-Result: =?us-ascii?q?A2ALDwC4L0BY/wXKxApdHAEBBAEBCgEBgzgBAQEBAXcupSi?=
 =?us-ascii?q?SaoQTJYV9AhqCMQ8BAgEBAQEBAQGBCoRpAQEEIxFVAgEIGgImAgICKgYVAgENA?=
 =?us-ascii?q?gQBDAgBAYh3qzKCKYtRAQEBAQEBBAEBAQEBAQEbBYELhzCCXoRggm2CXQWIXpI?=
 =?us-ascii?q?AhkuUTIYvihiDYoQMNocNijUBAQE?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW101FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 01 Dec 2016 15:13:21 +0100
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
        id 3tTzlj27jPz2yWVL; Thu,  1 Dec 2016 14:12:33 +0000 (UTC)
Received: from MGW201PAR.atlas.de (unknown [10.206.101.60])
        by SCESRV02.atlas.de (Postfix) with ESMTPS id 3tTzkl390Fz2yWVH
        for <git@vger.kernel.org>; Thu,  1 Dec 2016 14:12:31 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW201DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Dec 2016 15:12:31 +0100
Received: from MSEXSRV6.atlas.de ([169.254.4.130]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0319.002; Thu, 1 Dec 2016 15:12:29 +0100
From:   <stefan.naewe@atlas-elektronik.com>
To:     <johannes.schindelin@gmx.de>, <git-for-windows@googlegroups.com>,
        <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git for Windows 2.11.0
Thread-Topic: [ANNOUNCE] Git for Windows 2.11.0
Thread-Index: AQHSS89Nw2Zgq20690OOgV5+2IPoLaDzEYOA
Date:   Thu, 1 Dec 2016 14:12:36 +0000
Message-ID: <77d1fa5d-869c-546e-357b-cd1e6ffee48d@atlas-elektronik.com>
References: <20161201123130.7608-1-johannes.schindelin@gmx.de>
In-Reply-To: <20161201123130.7608-1-johannes.schindelin@gmx.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B6B5A9BA0292349AA4759476DE258EF@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMDEuMTIuMjAxNiB1bSAxMzozMSBzY2hyaWViIEpvaGFubmVzIFNjaGluZGVsaW46DQo+IE1J
TUUtVmVyc2lvbjogMS4wDQo+IA0KPiBGY2M6IFNlbnQNCj4gDQo+IERlYXIgR2l0IHVzZXJzLA0K
PiANCj4gSXQgaXMgbXkgcGxlYXN1cmUgdG8gYW5ub3VuY2UgdGhhdCBHaXQgZm9yIFdpbmRvd3Mg
Mi4xMS4wIGlzIGF2YWlsYWJsZSBmcm9tOg0KPiANCj4gCWh0dHBzOi8vZ2l0LWZvci13aW5kb3dz
LmdpdGh1Yi5pby8NCj4gDQo+IENoYW5nZXMgc2luY2UgR2l0IGZvciBXaW5kb3dzIHYyLjEwLjIg
KE5vdmVtYmVyIDJuZCAyMDE2KQ0KPiANCj4gTmV3IEZlYXR1cmVzDQo+IA0KPiAgICogQ29tZXMg
d2l0aCBHaXQgdjIuMTEuMC4NCj4gICAqIFBlcmZvcm1hbmNlIG9mIGdpdCBhZGQgaW4gbGFyZ2Ug
d29ya3RyZWVzIHdhcyBpbXByb3ZlZC4NCj4gICAqIEEgbmV3LCBleHBlcmltZW50YWwsIGJ1aWx0
aW4gdmVyc2lvbiBvZiB0aGUgZGlmZnRvb2wgaXMgYXZhaWxhYmxlDQo+ICAgICBhcyBhbiBvcHQt
aW4gZmVhdHVyZS4NCj4gICAqIFN1cHBvcnQgaGFzIGJlZW4gYWRkZWQgdG8gZ2VuZXJhdGUgcHJv
amVjdCBmaWxlcyBmb3IgVmlzdWFsIFN0dWRpbw0KPiAgICAgMjAxMCBhbmQgbGF0ZXIuDQoNClRo
YXQncyBub3QgcmVhbGx5IGEgbmV3IGZlYXR1cmUgb2YgR2l0LWZvci1XaW5kb3dzLCBpcyBpdCA/
DQoNCkp1c3Qgd29uZGVyaW5nLi4uDQoNClN0ZWZhbg0KLS0gDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQovZGV2L3JhbmRv
bSBzYXlzOiBNb25leSBpcyB0aGUgcm9vdCBvZiBhbGwgZXZpbDsgZXZlcnlvbmUgbmVlZHMgcm9v
dHMhDQpweXRob24gLWMgInByaW50ICc3Mzc0NjU2NjYxNmUyZTZlNjE2NTc3NjU0MDYxNzQ2YzYx
NzMyZDY1NmM2NTZiNzQ3MjZmNmU2OTZiMmU2MzZmNmQnLmRlY29kZSgnaGV4JykiIA0KR1BHIEtl
eSBmaW5nZXJwcmludCA9IDJERjUgRTAxQiAwOUMzIDc1MDEgQkNBOSAgOTY2NiA4MjlCIDQ5QzUg
OTIyMSAyN0FG
