Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A04EE20281
	for <e@80x24.org>; Fri, 15 Sep 2017 21:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbdIOV5C (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 17:57:02 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:39817 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbdIOV4f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 17:56:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 01A20100049;
        Fri, 15 Sep 2017 21:56:34 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V31Bwg74mpPO; Fri, 15 Sep 2017 21:56:33 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id E06628002E;
        Fri, 15 Sep 2017 21:56:33 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Fri, 15 Sep 2017 21:56:33 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Fri, 15 Sep 2017 21:56:33 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <benpeart@microsoft.com>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v6 12/12] fsmonitor: add a performance test
Thread-Topic: [PATCH v6 12/12] fsmonitor: add a performance test
Thread-Index: AQHTLlfegbHf1MPHSUKPUx0zd76/qKK2fgEg
Date:   Fri, 15 Sep 2017 21:56:33 +0000
Message-ID: <24c24fbeef8849f290df518dc2e4f9d7@exmbdft7.ad.twosigma.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-13-benpeart@microsoft.com>
In-Reply-To: <20170915192043.4516-13-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ICsJCSMgQ2hvb3NlIGludGVncmF0aW9u
IHNjcmlwdCBiYXNlZCBvbiBleGlzdGFuY2Ugb2YgV2F0Y2htYW4uDQoNClNwZWxsaW5nOiBleGlz
dGVuY2UNCg0KDQo=
