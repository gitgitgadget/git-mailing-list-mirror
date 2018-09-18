Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB4E1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 23:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbeISFEc (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 01:04:32 -0400
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:52352
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbeISFEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 01:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm+7+TKUEy9NCG29kGnE5XDouWxEC13JOI5W6U3Tfpg=;
 b=A6OQ+4B1FGHca3wV7vb3tCzkBhpuVKKJsiRINAgsmkpX9hOEy1v+nlE0JFfgsG5QtqD+causAgZO6StBLeQV4Yl5wfZ65u8X3WxBbYJsFoPMaQyErCWLrndr2rdDIcnai1LOXhRr6X+8ZTYqRW1NUeY6KqTnJjfySFVRAkKqz3M=
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.6; Tue, 18 Sep 2018 23:29:34 +0000
Received: from BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be]) by BL0PR2101MB0962.namprd21.prod.outlook.com
 ([fe80::f0b9:d24f:2522:d7be%2]) with mapi id 15.20.1185.006; Tue, 18 Sep 2018
 23:29:34 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v3 1/5] t/README: correct spelling of "uncommon"
Thread-Topic: [PATCH v3 1/5] t/README: correct spelling of "uncommon"
Thread-Index: AQHUT6d1MI5aRbUG3E+ITS7oh8pGrg==
Date:   Tue, 18 Sep 2018 23:29:34 +0000
Message-ID: <20180918232916.57736-2-benpeart@microsoft.com>
References: <20180914143708.63024-1-benpeart@microsoft.com>
 <20180918232916.57736-1-benpeart@microsoft.com>
In-Reply-To: <20180918232916.57736-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: BN6PR19CA0107.namprd19.prod.outlook.com
 (2603:10b6:404:a0::21) To BL0PR2101MB0962.namprd21.prod.outlook.com
 (2603:10b6:207:30::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0994;6:hWcweXQx4hp03nfugywROZ673dZI8MQ7PSRjhEJuzrwHhng5UOM6qMF8KEiyHHCWrdrZEQbxSVfcjomA1k/8QdE52MtClLmjVZnfxSxXkKeloTa6V01SRJBKpmYEfIxJ50Iz/ipcsdyJYrPgKjTfQVRLGJEumb4wqlz1fCQeuceUNiiJ0cBd61OV7RBfRhME6aR81i8lotbbAqFAIlj64M50q4QozxbqJ7R+zHUupTFeKQTqikvAVJ7orVnVX+miGGb0pALTzDl5iYdDIHLdIeCWlRrMJU8+m3M2Wc/fI0iR+9HjYSr/nhdlCTahLmBg+ICnpBXqsJJ7J2w0Q2wpl0UNYtLC9TZ26C9eBCaLZhRR5pvhdkC3TBu8E1CsWsFt1MbNWy4tgl0e+h5vb4X32bmG3kIKzD1XjcrYSLqtudYBGjkeOlxbHbv3VwxSLuXubYDdu0ZJbiMpTBo93TKy/g==;5:Y1J+SedYr7CxdHsknNztlnLNzKG6014TX7MgLKYVJREPkVpvJMAyvLZDWh7V8orQK1OMKzmdLMkIczayc//Evtf9YsHHIe190oEDy+f4K+fcy/Y4LqZoAga9lvooMMqqqEaY6gZZG3Wo9LMlc/UM4rsCSnZcF9EdKGDzpMfpics=;7:tIsurVrvX0S3UgH4S9q5wLcil4C9jDJoxxnrnxgEwv9dc5LvfHpFwP5YpzkcGIP/pmf6l7KvZQt3C/BhXME8SMqbsImMu/U/C3qnravCNbN0rDvv420YGppG1MyY+MmRhLyE0a5XZazvGlSWRydIzyaMK2y2w9StFmzsD7dW5u2HZxQtO+ONh43mkFvNahTYaq8fWEr/0Qrg3E4xDUC8c0mzk6kQvfPnkipBA4VGQ0pV9mVzJ0QlxAfHd7zwwIbE
x-ms-office365-filtering-correlation-id: 5c3e8876-7444-43a5-c578-08d61dbe9751
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
x-microsoft-antispam-prvs: <BL0PR2101MB0994E656A6AB1EF29D487293F41D0@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:BL0PR2101MB0994;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0994;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(136003)(39860400002)(199004)(189003)(54906003)(14444005)(68736007)(2616005)(2906002)(86612001)(5640700003)(476003)(11346002)(256004)(6506007)(386003)(102836004)(8676002)(3846002)(6512007)(50226002)(36756003)(6116002)(446003)(316002)(486006)(6916009)(1076002)(2900100001)(8936002)(66066001)(10290500003)(5660300001)(81156014)(478600001)(1730700003)(72206003)(186003)(14454004)(99286004)(26005)(105586002)(52116002)(53936002)(2351001)(4326008)(81166006)(6486002)(2501003)(97736004)(107886003)(22452003)(76176011)(106356001)(5250100002)(6346003)(39060400002)(10090500001)(6436002)(305945005)(25786009)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB0962.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: JZFghTqciR5Y20yyGCXeNN10w8m0gR7OspbBEcSywTAsAZAaJgmoRfvgU42sQck4xf6krDvUUQX8UFXIJm+2+fBkYPv1/quvLKVpuTBQhwmPJLkDN43F9mGpDg/aM/ZMoAG2bB70KWzsolpgCMZTUTFVhYe5OW/b8Tv+qRAtt3kNUJkw2SXKfFMfF5r49zVsfc48lVAnpyA+gPMaFYa+rJ48xvjbgMmDUeySUOLhD+awp5fP7THZjkMnczfGpyuN+UK3bw3L8FODOC2Si2S88dmZrOkaaB+6fXLy1WDvB+bcfQRd+6Za6xon+xjWBY8caP7sFNc5pfQyq75ES0rYGScdSmA4yrP0dCYvgRfb/gg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3e8876-7444-43a5-c578-08d61dbe9751
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 23:29:34.3901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a spelling error in the documentation for GIT_TEST_OE_DELTA_SIZE.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 t/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 9028b47d92..56a417439c 100644
--- a/t/README
+++ b/t/README
@@ -315,7 +315,7 @@ packs on demand. This normally only happens when the ob=
ject size is
 over 2GB. This variable forces the code path on any object larger than
 <n> bytes.
=20
-GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncomon pack-objects code
+GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncommon pack-objects code
 path where deltas larger than this limit require extra memory
 allocation for bookkeeping.
=20
--=20
2.18.0.windows.1

