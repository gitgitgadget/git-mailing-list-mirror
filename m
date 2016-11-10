Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA752035F
	for <e@80x24.org>; Thu, 10 Nov 2016 08:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753309AbcKJI0k (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 03:26:40 -0500
Received: from mail95.atlas.de ([194.156.172.85]:63285 "EHLO mail95.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbcKJI0j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 03:26:39 -0500
X-Greylist: delayed 760 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Nov 2016 03:26:39 EST
X-IPAS-Result: =?us-ascii?q?A2CICAD1KyRY/wXKxApdHAEBBAEBCgEBgzABAQEBAXcsU4N?=
 =?us-ascii?q?JoH+SR4QYK4V5AhqCRhABAgEBAQEBAQGBCkISAYQNAQEEIxFVAgEIGgImAgICK?=
 =?us-ascii?q?gYVAgENAgQBDAgBAYhmsA2CQItHAQEBAQEFAQEBAQEBARsFgQmHMgiCVYRIF4J?=
 =?us-ascii?q?tgl0FiE+RY4Y4lA6GI4lbg12EBzWGVHIBAQGCHoV2AQEB?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW101FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 10 Nov 2016 09:13:36 +0100
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
        id 3tDwmK0LXCz2yWRb; Thu, 10 Nov 2016 08:12:47 +0000 (UTC)
Received: from MGW202PAR.atlas.de (unknown [10.206.101.61])
        by SCESRV02.atlas.de (Postfix) with ESMTPS id 3tDwlM0hnlz2yWRg
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 08:12:47 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW202DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Nov 2016 09:12:46 +0100
Received: from MSEXSRV5.atlas.de ([169.254.3.205]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0319.002; Thu, 10 Nov 2016 09:12:44
 +0100
From:   <stefan.naewe@atlas-elektronik.com>
To:     <Johannes.Schindelin@gmx.de>, <git-for-windows@googlegroups.com>,
        <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Prerelease: Git for Windows v2.11.0-rc0
Thread-Topic: [ANNOUNCE] Prerelease: Git for Windows v2.11.0-rc0
Thread-Index: AQHSN4kofkkImxqdMUe5tJf9jqV8zqDR1JaA
Date:   Thu, 10 Nov 2016 08:12:44 +0000
Message-ID: <1784ec06-2557-aa99-ead8-b8997b68d8d9@atlas-elektronik.com>
References: <alpine.DEB.2.20.1611051025030.3108@virtualbox>
In-Reply-To: <alpine.DEB.2.20.1611051025030.3108@virtualbox>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <07BC29302B5D8F45A60F96F20D851C2C@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMDUuMTEuMjAxNiB1bSAxMDo1MCBzY2hyaWViIEpvaGFubmVzIFNjaGluZGVsaW46DQo+IERl
YXIgR2l0IHVzZXJzLA0KPiANCj4gSSBmaW5hbGx5IGdvdCBhcm91bmQgdG8gcmViYXNlIHRoZSBX
aW5kb3dzLXNwZWNpZmljIHBhdGNoZXMgKHdoaWNoIHNlZW0gdG8NCj4gbm90IG1ha2UgaXQgdXBz
dHJlYW0gYXMgZmFzdCBhcyB3ZSBnZXQgbmV3IG9uZXMpIG9uIHRvcCBvZiB1cHN0cmVhbSBHaXQN
Cj4gdjIuMTEuMC1yYzAsIGFuZCB0byBidW5kbGUgaW5zdGFsbGVycywgcG9ydGFibGUgR2l0IGFu
ZCBNaW5HaXQgWyoxKl06DQo+IA0KPiBodHRwczovL2dpdGh1Yi5jb20vZ2l0LWZvci13aW5kb3dz
L2dpdC9yZWxlYXNlcy90YWcvdjIuMTEuMC1yYzAud2luZG93cy4xDQo+IA0KPiBJdCB3b3VsZCBi
ZSByZWFsbHkgbmljZSBpZiB0aG9zZSBvZiB5b3Ugd2hvIGhhdmUgYWNjZXNzIHRvIFdpbmRvd3Mg
WyoyKl0NCj4gY291bGQgdHJ5IGl0IG91dCBhbmQgcmVwb3J0IGJ1Z3MgYmVmb3JlIHYyLjExLjAg
ZmluYWwuDQoNCkkgdHJpZWQgdGhhdCB2ZXJzaW9uIG9uIDY0Yml0IFdpbjcuDQpTb21laG93IHRo
ZSBQQVRIIGVudi4gdmFyaWFibGUgZG9lcyBubyBsb25nZXIgZ2V0IHNldCBjb3JyZWN0bHkuDQoN
Ck9uIGdpdC1mb3Itd2luZG93cyAyLjEwLjIgbXkgUEFUSCAoaW5zaWRlIGdpdCBiYXNoKSBjb250
YWlucyB+NzUgRW50cmllcy4NCldpdGggdGhlIGFib3ZlIGluc3RhbGxlciBJIG9ubHkgZ2V0IH4x
NyAhDQooSW5zaWRlIGNtZC5leGUgSSBnZXQgNjEgZW50cmllcy4gSSBzZXQgc29tZSBtb3JlIGVu
dHJpZXMgd2l0aCBieSB+Ly5iYXNocmMpDQoNCkl0IHNlZW1zIHRoYXQgYWxsIGVudHJpZXMgdGhh
dCBjb250YWluIGEgcGF0aCB3aXRoIHdoaXRlc3BhY2UgKGUuZy4gJ2M6XHByb2dyYW0gZmlsZXMg
KHg4NiknICkNCmFyZSBubyBsb25nZXIgdGhlcmUuDQoNCkFueSBpZGVhcyA/DQoNClRoYW5rcywN
CiAgU3RlZmFuDQotLSANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCi9kZXYvcmFuZG9tIHNheXM6IE94eW1vcm9uOiBTdHVj
ayBpbiB0cmFmZmljLg0KcHl0aG9uIC1jICJwcmludCAnNzM3NDY1NjY2MTZlMmU2ZTYxNjU3NzY1
NDA2MTc0NmM2MTczMmQ2NTZjNjU2Yjc0NzI2ZjZlNjk2YjJlNjM2ZjZkJy5kZWNvZGUoJ2hleCcp
IiANCkdQRyBLZXkgZmluZ2VycHJpbnQgPSAyREY1IEUwMUIgMDlDMyA3NTAxIEJDQTkgIDk2NjYg
ODI5QiA0OUM1IDkyMjEgMjdBRg==
