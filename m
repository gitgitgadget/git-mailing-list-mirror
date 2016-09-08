Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4291F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 10:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966136AbcIHKFu (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 06:05:50 -0400
Received: from mail96.atlas.de ([194.156.172.86]:23990 "EHLO mail96.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966134AbcIHKFs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 06:05:48 -0400
X-IPAS-Result: =?us-ascii?q?A2B/CgCkN9FX/wXKxApdGwEBAQMBAQGDLQEBAQEBdSpStjO?=
 =?us-ascii?q?EEiaFdgIcgXsQAQIBAQEBAQEBgQWEYgEBBCMRVQIBCBoCJgICAioGFQIBDQIEA?=
 =?us-ascii?q?QwIAQGIVLBVjBMBAQEBAQUBAQEBAQEcBYEGhyIIgk6EQBeCa4JaBYgwkS6GIpJ?=
 =?us-ascii?q?5hgKJBYNMg3s1hHNxh1QBAQE?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW102FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 08 Sep 2016 12:05:45 +0200
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
        id 3sVGDn1zwsz2MGjL; Thu,  8 Sep 2016 10:05:14 +0000 (UTC)
Received: from MGW202PAR.atlas.de (unknown [10.206.101.61])
        by SCESRV02.atlas.de (Postfix) with ESMTPS id 3sVGDB472Xz2MGjP
        for <git@vger.kernel.org>; Thu,  8 Sep 2016 10:05:14 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW202DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Sep 2016 12:05:14 +0200
Received: from MSEXSRV5.atlas.de ([169.254.3.150]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0301.000; Thu, 8 Sep 2016 12:05:15 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <johannes.schindelin@gmx.de>, <git-for-windows@googlegroups.com>,
        <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git for Windows 2.10.0
Thread-Topic: [ANNOUNCE] Git for Windows 2.10.0
Thread-Index: AQHSBeWUt3atMPZqgE+ZP927B82KvKBvQ6UA
Date:   Thu, 8 Sep 2016 10:05:15 +0000
Message-ID: <3ed6f32f-6330-3453-1581-3a2d4008bbfa@atlas-elektronik.com>
References: <0MZD0K-1bNOQ13s6O-00Ku7h@mail.gmx.com>
In-Reply-To: <0MZD0K-1bNOQ13s6O-00Ku7h@mail.gmx.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E104955D96B2B4583FD9985B8767B45@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMDMuMDkuMjAxNiB1bSAxNToxNyBzY2hyaWViIEpvaGFubmVzIFNjaGluZGVsaW46DQo+IERl
YXIgR2l0IHVzZXJzLA0KPiANCj4gSXQgaXMgbXkgcGxlYXN1cmUgdG8gYW5ub3VuY2UgdGhhdCBH
aXQgZm9yIFdpbmRvd3MgMi4xMC4wIGlzIGF2YWlsYWJsZS4NCj4gVGhpcyB0aW1lLCBJIGV2ZW4g
YmxvZ2dlZCBhYm91dCBpdCwgcHJpbWFyaWx5IGJlY2F1c2UgSSBhbSBzbyBleGNpdGVkDQo+IGFi
b3V0IHRoZSBzcGVlZCBpbXByb3ZlbWVudHMgb2YgcmViYXNlIC1pOg0KPiANCj4gaHR0cHM6Ly9i
bG9ncy5tc2RuLm1pY3Jvc29mdC5jb20vdmlzdWFsc3R1ZGlvYWxtLzIwMTYvMDkvMDMvd2hhdHMt
bmV3LWluLWdpdC1mb3Itd2luZG93cy0yLTEwLw0KPiANCj4gQXMgYWx3YXlzLCB5b3UgY2FuIGRv
d25sb2FkIGl0IGZyb206IGh0dHBzOi8vZ2l0LWZvci13aW5kb3dzLmdpdGh1Yi5pby8NCj4gDQo+
IENoYW5nZXMgc2luY2UgR2l0IGZvciBXaW5kb3dzIHYyLjkuMygyKSAoQXVndXN0IDI1dGggMjAx
NikNCj4gDQo+IE5ldyBGZWF0dXJlcw0KPiANCj4gICDigKIgQ29tZXMgd2l0aCBHaXQgdjIuMTAu
MC4NCj4gICDigKIgVGhlIGdpdCByZWJhc2UgLWkgY29tbWFuZCB3YXMgbWFkZSBmYXN0ZXIgYnkg
cmVpbXBsZW1lbnRpbmcgbGFyZ2UNCj4gICAgIHBhcnRzIGluIEMuDQoNCkkgZmluYWxseSBoYWQg
dGhlIGNoYW5jZSB0byBkbyBhICJiaWdnZXIiIHJlYmFzZSBhbmQgd2hhdCBzaGFsbCBJIHNheS4u
Lg0KRioqKmssIGhhcyB0aGlzIHRoaW5nIGJlY29tZSBmYXN0LCBvciB3aGF0IQ0KDQpUaGFuayB5
b3Ugc28gbXVjaCBmb3IgZG9pbmcgdGhpcyEhISENCg0KU3RlZmFuDQotLSANCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCi9k
ZXYvcmFuZG9tIHNheXM6IEEgQ2F0J3MgY291cmFnZSBpcyBhcyBzdHJvbmcgYXMgYSBkb2cncyBj
aGFpbg0KcHl0aG9uIC1jICJwcmludCAnNzM3NDY1NjY2MTZlMmU2ZTYxNjU3NzY1NDA2MTc0NmM2
MTczMmQ2NTZjNjU2Yjc0NzI2ZjZlNjk2YjJlNjM2ZjZkJy5kZWNvZGUoJ2hleCcpIiANCkdQRyBL
ZXkgZmluZ2VycHJpbnQgPSAyREY1IEUwMUIgMDlDMyA3NTAxIEJDQTkgIDk2NjYgODI5QiA0OUM1
IDkyMjEgMjdBRg==
