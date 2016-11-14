Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 522242021E
	for <e@80x24.org>; Mon, 14 Nov 2016 08:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753866AbcKNIFk (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 03:05:40 -0500
Received: from mail95.atlas.de ([194.156.172.85]:32991 "EHLO mail95.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753462AbcKNIFj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 03:05:39 -0500
X-IPAS-Result: =?us-ascii?q?A2BYBQAWcClY/wTKxApdGgEBAQECAQEBAQgBAQEBgzEBAQE?=
 =?us-ascii?q?BAXcsVKRHklGEFiqFdQICAhqCOxABAgEBAQEBAQGBCoRiAQEEIxFFEAIBCBgCA?=
 =?us-ascii?q?iYCAgIqBhUCAQ0CBA0BBwEBiGuuZYIpi0MBAQEBAQEBAwEBAQEBAQEBARkFgQm?=
 =?us-ascii?q?HMAiCVYRIFzWCOIJdBYhQjAmFaIY8i3qIIoYliWWDX4QKNYZZcgEBAYc/AQEB?=
Received: from scesrv01.atlas.de ([10.196.202.4])
  by MGW101FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 14 Nov 2016 09:05:19 +0100
Received: by SCESRV01.atlas.de (Postfix, from userid 600)
        id 3tHNNv6frQz17mT2; Mon, 14 Nov 2016 08:04:41 +0000 (UTC)
Received: from MGW201PAR.atlas.de (unknown [10.206.101.60])
        by SCESRV01.atlas.de (Postfix) with ESMTPS id 3tHNN86bhgz17mT0
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 08:04:40 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW201DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Nov 2016 09:04:40 +0100
Received: from MSEXSRV6.atlas.de ([169.254.4.130]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0319.002; Mon, 14 Nov 2016 09:04:40
 +0100
From:   <stefan.naewe@atlas-elektronik.com>
To:     <Johannes.Schindelin@gmx.de>
CC:     <git-for-windows@googlegroups.com>, <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Prerelease: Git for Windows v2.11.0-rc0
Thread-Topic: [ANNOUNCE] Prerelease: Git for Windows v2.11.0-rc0
Thread-Index: AQHSN4kofkkImxqdMUe5tJf9jqV8zqDR1JaAgAIkDQCAABuyAIAEB1OA
Date:   Mon, 14 Nov 2016 08:04:39 +0000
Message-ID: <f1276f7e-defe-0ec5-0703-a724f200b054@atlas-elektronik.com>
References: <alpine.DEB.2.20.1611051025030.3108@virtualbox>
 <1784ec06-2557-aa99-ead8-b8997b68d8d9@atlas-elektronik.com>
 <alpine.DEB.2.20.1611111750580.3746@virtualbox>
 <alpine.DEB.2.20.1611111933001.9967@virtualbox>
In-Reply-To: <alpine.DEB.2.20.1611111933001.9967@virtualbox>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EF41C3921EAC54891B13A457A4A3D3D@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMTEuMTEuMjAxNiB1bSAxOTozMyBzY2hyaWViIEpvaGFubmVzIFNjaGluZGVsaW46DQo+IEhp
IFN0ZWZhbiwNCj4gDQo+IE9uIEZyaSwgMTEgTm92IDIwMTYsIEpvaGFubmVzIFNjaGluZGVsaW4g
d3JvdGU6DQo+IA0KPj4gV2lsbCBrZWVwIHlvdSBwb3N0ZWQsDQo+IA0KPiBJIHB1Ymxpc2hlZCB0
aGUgcHJlcmVsZWFzZToNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9naXQtZm9yLXdpbmRvd3Mv
Z2l0L3JlbGVhc2VzL3RhZy92Mi4xMS4wLXJjMC53aW5kb3dzLjINCg0KVGhhdCB2ZXJzaW9uIGJy
aW5ncyBhbGwgbXkgUEFUSCBlbnRyaWVzIGJhY2shDQoNClRhbmtzIGEgbG90IQ0KDQpTdGVmYW4N
Ci0tIA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KL2Rldi9yYW5kb20gc2F5czogQ2F0aG9saWMgKG4uKSBBIGNhdCB3aXRo
IGEgZHJpbmtpbmcgcHJvYmxlbS4NCnB5dGhvbiAtYyAicHJpbnQgJzczNzQ2NTY2NjE2ZTJlNmU2
MTY1Nzc2NTQwNjE3NDZjNjE3MzJkNjU2YzY1NmI3NDcyNmY2ZTY5NmIyZTYzNmY2ZCcuZGVjb2Rl
KCdoZXgnKSIgDQpHUEcgS2V5IGZpbmdlcnByaW50ID0gMkRGNSBFMDFCIDA5QzMgNzUwMSBCQ0E5
ICA5NjY2IDgyOUIgNDlDNSA5MjIxIDI3QUY=
