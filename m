Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32571F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 09:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfJUJaq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 21 Oct 2019 05:30:46 -0400
Received: from mail-eopbgr1380071.outbound.protection.outlook.com ([40.107.138.71]:61824
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbfJUJaq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 05:30:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/ttMt/jspC6aFZaSxjvlRgozDLQyMjqNn38991vmWknBih65yA7fSNFG+59770oT/ahSlFbrUSb1+tH1OMWhGLdBBCQVVGM99npot8ca1C0qPBcskVc7SZ9DWg4gCEViMc9Q0BxK9wtq1MaANJJsqiRiQ3yU+sBh4b9afhhLHGXqoki/HF4otojW19p43qpUT79LjLjjyY6N0E9fK9YlDbv6l8g1f/Ne51s4W3BAuI/5nZ02W5j1AwAJ3ee5VZRAtm9Psix0/D7kjTjMGxWilE8fVGpIUoUJ486SH+mCvgvUCKECnGowHMya9IC5XTdIS+Dodypjfu2LwK8QLC8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRSNLn3t19aytlwav9Wei8SfLsgY7cIT/wkH8DEh0I8=;
 b=e/4yLZqA3Qi9PHwPVdkCakORORRPR9Q1nftqY0YR/KfuF1ojX/tTChnaWuYaP/DAQswVYmjStM1E9aeSJo5KUC0lKZrl5hlrGX0/j1vpd9NAOA3muwE3f+c6kDQsZ7Uoqq687sX1Eh8Nxr81UF+3Lp3fKqWgFw1a4866B28gcfZdrES8J5pUpt2FutVQR3DaBOxxHNMIo9q7405JG8GcOTpAOcB1n2dE2p12g0TmnxO0PE2R8qS3y+5c2VM4HLScCWAOfodbaCZDrtrhJAleX0CFrhbLqhbT4tzdSEvT029jggJVcMu+oljO6JuqYSVYuABHDnYqTNVEwwJL/GBgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=worlddigitallinks.com; dmarc=pass action=none
 header.from=worlddigitallinks.com; dkim=pass header.d=worlddigitallinks.com;
 arc=none
Received: from MAXPR01MB2557.INDPRD01.PROD.OUTLOOK.COM (52.134.155.78) by
 MAXPR01MB3453.INDPRD01.PROD.OUTLOOK.COM (52.134.156.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Mon, 21 Oct 2019 09:30:41 +0000
Received: from MAXPR01MB2557.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::ec90:e9f:d0fc:4374]) by MAXPR01MB2557.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::ec90:e9f:d0fc:4374%7]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 09:30:41 +0000
From:   Alicia Alvarado <alicia.alvarado@worlddigitallinks.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: FMB 2019
Thread-Topic: FMB 2019
Thread-Index: AdWH8fl8jaNSCfu/TsG9P9+zRRC7WA==
Date:   Mon, 21 Oct 2019 09:30:40 +0000
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAALggoawTybVGmg+cyhiMji7CgAAAEAAAADblyA9Vb7FNpU7YX5H/JbYBAAAAAA==@worlddigitallinks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To MAXPR01MB2557.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:59::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alicia.alvarado@worlddigitallinks.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Microsoft Outlook 15.0
x-originating-ip: [49.207.49.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d907447-0e26-4f8e-e81d-08d7560956d6
x-ms-traffictypediagnostic: MAXPR01MB3453:
x-microsoft-antispam-prvs: <MAXPR01MB34530FC33977E7940AD018ACFD690@MAXPR01MB3453.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39840400004)(396003)(346002)(376002)(34096005)(189003)(199004)(7116003)(86362001)(5640700003)(99286004)(61296003)(7736002)(305945005)(2351001)(486006)(626008)(25786009)(44832011)(256004)(14444005)(6512007)(2616005)(52116002)(316002)(476003)(71190400001)(5660300002)(508600001)(102836004)(71200400001)(55236004)(36756003)(66946007)(66476007)(66556008)(64756008)(66446008)(2501003)(50226002)(9476002)(26005)(8676002)(1730700003)(186003)(14454004)(8936002)(81156014)(81166006)(6486002)(3846002)(6116002)(66066001)(88246002)(6436002)(6916009)(2906002)(6506007)(386003)(130950200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MAXPR01MB3453;H:MAXPR01MB2557.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: worlddigitallinks.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ag+THujJ8ae0N+DyB5ny+A9iroz/XZ+BjcVaYwOVz6U9J1321e+7/qg88k+UmNw/WmKr2uyIj+J11HU/xzA47pSWRsHrMayYCCpt7BVJgOW/SxCaaiPkwY0znxa7vg+F3zp0a3biCM+99X9Hj4saxXQBB+kHcTJ/gKejhmbsl9fhn/gVUdvprB0mTOhrjgIw+WJsSMk67eZbO4sBE6aRHuwznOHpPKKfAFbN9nowiOvx2jH1Vk8ZDCIJ2MndLAbl7q9tAM17a8HfQqHlmt4V6KO9s29PVFESb+Xkf927G+S3cQ3rkmZ+KX/1fZwLbZugoh050thrUVATMokZuwbcq1SSekc9Ui4VqYU4XSCryRSUSi0FbH5ba8/6OM2P1GW12Ts1sQmdBGb7RTkvPDHyxg6gZ/s6einB3rntp8Lp/Rms4/2G890Nu4jHMI8jtqA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EB5C78FFBCA6B488BD991F25DE014F1@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: worlddigitallinks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d907447-0e26-4f8e-e81d-08d7560956d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 09:30:40.9032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78d36868-8221-4fc9-829c-9529bac331e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Rd1Xc0eMlyrY+lLAJlXlLEsJx23OhpG+sCVf0aEyO45DjZxMC5z4/RsWP9bQv6G+Ufqk1MDznnxKGC/zFN7K8PktYauW2nrQT2Bu+ZBjNzClcOwp00t0rjG1Nut6+he
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB3453
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
 
We wanted to check if you would be interested in acquiring the Attendees
list of FMB 2019 (International Trade Show for Mechanical Engineering,
Automotive, Lightweight Engineering, Aerospace, Logistics and IT Services
2019) to increase more prospect flow to your booth in the Show.

Venue:  Messe Ostwestfalen GmbH, Bad Salzuflen, Germany

Expected Visitors: 5000 

Information Provided: - Company name, URL, Contact name, Job title, Phone
number, fax number, physical address, Company size, Email address etc.

Our list is the best source for awareness and can be used for Booth Invites
- Marketing initiatives - Product launch - Brand awareness - increase in
revenue etc.

Please let me know if you are interested. So, that I can provide you with
the number of Counts and the cost.

Kind Regards,
Alicia Alvarado
B2B Marketing & Tradeshow Specialist

Note: We can run an E-mail Campaign on your behalf which will be at no cost
if you buy B2B Data or Attendees list.

If you do not wish to receive the attendees list, please reply as 'Opt-out'

