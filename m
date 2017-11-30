Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F21220954
	for <e@80x24.org>; Thu, 30 Nov 2017 08:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbdK3IG5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 03:06:57 -0500
Received: from mail96.atlas.de ([194.156.172.86]:54017 "EHLO mail96.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750769AbdK3IG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 03:06:56 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Nov 2017 03:06:56 EST
X-IPAS-Result: =?us-ascii?q?A2CBAgCPuR9a/wTKxApcGwEBAgMBAQoBAYQjgRWDf5sPmQc?=
 =?us-ascii?q?KI4UYAhqFPhQBAQEBAQEBAQGBE4UgAgEDIxFVAgEIGgImAgICMBUCAQ0CBAEMC?=
 =?us-ascii?q?AEBii6nNYInimcBAQEBAQEEAQEBAQEBARwFgQ+CMoVxgwKFN4J+gmMFij2YFod?=
 =?us-ascii?q?0mSCHTox6gU+HeYE6NoFzb4J5hFR3AQEBigQBAQE?=
Received: from scesrv01.atlas.de ([10.196.202.4])
  by MGW102FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 30 Nov 2017 08:57:08 +0100
Received: from localhost.localdomain (localhost [127.0.0.1])
        by SCESRV01.atlas.de (Postfix) with SMTP id 3ynV9c2xygz8Mq71
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 07:57:08 +0000 (UTC)
Received: from MGW202PAR.atlas.de (unknown [10.206.101.61])
        by SCESRV01.atlas.de (Postfix) with ESMTPS id 3ynV9c2q0jz8Mq73
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 07:57:08 +0000 (UTC)
Received: from msexsrv3.atlas.de ([10.200.102.58])
  by MGW202DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Nov 2017 08:57:08 +0100
Received: from MSEXSRV5.atlas.de ([169.254.3.182]) by MSEXSRV3.atlas.de
 ([10.200.102.58]) with mapi id 14.03.0351.000; Thu, 30 Nov 2017 08:57:07
 +0100
From:   <stefan.naewe@atlas-elektronik.com>
To:     <Johannes.Schindelin@gmx.de>, <git-for-windows@googlegroups.com>,
        <git@vger.kernel.org>, <git-packagers@googlegroups.com>
Subject: Re: [ANNOUNCE] Git for Windows 2.15.1(2), was Re:Git for Windows
 2.15.1
Thread-Topic: [ANNOUNCE] Git for Windows 2.15.1(2), was Re:Git for Windows
 2.15.1
Thread-Index: AQHTaX2R3GHUMDLSuUiyGIEnZVSMyaMsfeGA
Date:   Thu, 30 Nov 2017 07:57:06 +0000
Message-ID: <115728c6-4b49-7f16-695e-8ad34aaa1e2b@atlas-elektronik.com>
References: <20171129135723.11664-1-johannes.schindelin@gmx.de>
 <alpine.DEB.2.21.1.1711300245250.6482@virtualbox>
In-Reply-To: <alpine.DEB.2.21.1.1711300245250.6482@virtualbox>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4CED73D565E2A46BDA84122FFC40C0D@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMzAuMTEuMjAxNyB1bSAwMjo1MCBzY2hyaWViIEpvaGFubmVzIFNjaGluZGVsaW46DQo+IEhp
IGFsbCwNCj4gDQo+IHVuZm9ydHVuYXRlbHksIGEgbGFzdC1taW51dGUgYnVnIHNsaXBwZWQgaW46
IE1TWVMyIHVwZGF0ZWQgdmltIChpbmNsdWRpbmcNCj4gaXRzIGRlZmF1bHRzLnZpbSwgaW4gYSB3
YXkgdGhhdCBpbnRlcmFjdGVkIGJhZGx5IHdpdGggR2l0IGZvciBXaW5kb3dzJw0KPiBjb25maWd1
cmF0aW9uKS4gVGhlIHJlc3VsdCB3YXMgdGhhdCBhbiB1Z2x5IHdhcm5pbmcgaXMgc2hvd24gZXZl
cnkgdGltZSBhDQo+IHVzZXIgb3BlbnMgdmltIA0KDQpCdXQgb25seSBpZiB0aGUgdXNlciBkb2Vz
bid0IGhhdmUgYSB+Ly52aW1yYyBmaWxlIQ0KDQo+ICh3aGljaCBpcyBzdGlsbCB0aGUgZGVmYXVs
dCBlZGl0b3Igb2YgR2l0IGZvciBXaW5kb3dzLCBmb3INCj4gaGlzdG9yaWNhbCByZWFzb25zKS4+
IA0KPiBHaXQgZm9yIFdpbmRvd3MgdjIuMTUuMSgyKSBmaXhlcyBqdXN0IHRoaXMgb25lIGJ1Zywg
YW5kIGNhbiBiZSBkb3dubG9hZGVkDQo+IGhlcmU6DQo+IA0KPiAJaHR0cHM6Ly9naXRodWIuY29t
L2dpdC1mb3Itd2luZG93cy9naXQvcmVsZWFzZXMvdGFnL3YyLjE1LjEud2luZG93cy4yDQo+IA0K
PiBDaWFvLA0KPiBKb2hhbm5lcw0KDQpTdGVmYW4NCi0tIA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KL2Rldi9yYW5kb20g
c2F5czogSWdub3JhbmNlIGNhbiBiZSBjdXJlZC4gU3R1cGlkIGlzIGZvcmV2ZXIuDQpweXRob24g
LWMgInByaW50ICc3Mzc0NjU2NjYxNmUyZTZlNjE2NTc3NjU0MDYxNzQ2YzYxNzMyZDY1NmM2NTZi
NzQ3MjZmNmU2OTZiMmU2MzZmNmQnLmRlY29kZSgnaGV4JykiIA0KR1BHIEtleSBmaW5nZXJwcmlu
dCA9IDJERjUgRTAxQiAwOUMzIDc1MDEgQkNBOSAgOTY2NiA4MjlCIDQ5QzUgOTIyMSAyN0FG

