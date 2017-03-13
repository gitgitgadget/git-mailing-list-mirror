Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50C851FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 14:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbdCMOpx (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 10:45:53 -0400
Received: from ext-scottmail.afnoc.af.mil ([131.9.253.48]:55054 "EHLO
        SCOTT-MAIL4.AFNOC.AF.MIL" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1751548AbdCMOps (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Mar 2017 10:45:48 -0400
X-Greylist: delayed 672 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Mar 2017 10:45:48 EDT
Received-SPF: pass (us.af.mil: domain of us.af.mil designates 131.15.70.111 as permitted sender) client-ip=131.15.70.111; envelope-from=roger.collins@us.af.mil; helo=us.af.mil;
Received: from us.af.mil (unknown [131.15.70.111]) by SCOTT-MAIL4.AFNOC.AF.MIL with smtp
        (TLS: TLSv1/SSLv3,256bits,DHE-RSA-AES256-SHA)
         id 1d6a_b95b_9d7ab28c_49b2_4497_af71_29f90aff3720;
        Mon, 13 Mar 2017 14:34:33 +0000
Received: from ([131.15.68.156])
        by 52tdkp-mr-005.us.af.mil with ESMTP with TLS id 9ML2FN1.196573176;
        Mon, 13 Mar 2017 08:34:24 -0600
Received: from 52ZHTX-D04-02B.AREA52.AFNOAPPS.USAF.MIL (131.27.55.17) by
 52TDKP-D02-02A.area52.afnoapps.usaf.mil (131.15.68.156) with Microsoft SMTP
 Server (TLS) id 14.3.319.2; Mon, 13 Mar 2017 08:34:23 -0600
Received: from 52ZHTX-D03-05E.AREA52.AFNOAPPS.USAF.MIL ([169.254.5.15]) by
 52ZHTX-D04-02B.area52.afnoapps.usaf.mil ([169.254.2.36]) with mapi id
 14.03.0319.002; Mon, 13 Mar 2017 10:34:23 -0400
From:   "COLLINS, ROGER W GG-12 USAF NASIC/SCPW" <roger.collins@us.af.mil>
To:     Stefan Beller <sbeller@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git Vendor Support
Thread-Topic: Git Vendor Support
Thread-Index: AdKZuP7shJETug9HRl2RJzx5l85V8AALwoaAAAa4SYA=
Date:   Mon, 13 Mar 2017 14:34:23 +0000
Message-ID: <C81F618483B6A04381181BA5435FB9706CFF7611@52ZHTX-D03-05E.area52.afnoapps.usaf.mil>
References: <C81F618483B6A04381181BA5435FB9706A70191B@52ZHTX-D03-05E.area52.afnoapps.usaf.mil>
 <CAGZ79kY1Z_Bj3AJU3G2A60XULSAKDEkwmC74JxiANTPHXo0Bng@mail.gmail.com>
In-Reply-To: <CAGZ79kY1Z_Bj3AJU3G2A60XULSAKDEkwmC74JxiANTPHXo0Bng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.27.49.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmVwbHkhDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IFN0ZWZhbiBCZWxsZXIgW21haWx0bzpzYmVsbGVyQGdvb2dsZS5jb21dIA0KU2VudDogRnJp
ZGF5LCBNYXJjaCAxMCwgMjAxNyAxMTo0OCBBTQ0KVG86IENPTExJTlMsIFJPR0VSIFcgR0ctMTIg
VVNBRiBOQVNJQy9TQ1BXIDxyb2dlci5jb2xsaW5zQHVzLmFmLm1pbD4NCkNjOiBnaXRAdmdlci5r
ZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogR2l0IFZlbmRvciBTdXBwb3J0DQoNCk9uIEZyaSwgTWFy
IDEwLCAyMDE3IGF0IDg6MTMgQU0sIENPTExJTlMsIFJPR0VSIFcgR0ctMTIgVVNBRiBOQVNJQy9T
Q1BXIDxyb2dlci5jb2xsaW5zQHVzLmFmLm1pbD4gd3JvdGU6DQo+IEFMQ09OLA0KPg0KPiBJcyB0
aGVyZSBpcyBhIHNwZWNpZmljIGdyb3VwIG9yIHZlbmRvciBiYWNraW5nIEdpdD8NCg0KaHR0cHM6
Ly9zZmNvbnNlcnZhbmN5Lm9yZy8gdGFrZXMgY2FyZSBvZiB0aGUgZmluYW5jaWFsIG5lZWRzIG9m
IHRoZSBjb21tdW5pdHkuDQoNCj4gYWN0aXZlIHN1cHBvcnQNCg0KSSBndWVzcyBjb21wYW5pZXMg
dGhhdCBtYWtlIG1vbmV5IHByaW1hcmlseSB2aWEgR2l0IGhvc3RpbmcgKGUuZy4gb25lIG9mIEdp
dGh1YiwgR2l0TGFiLCBBdGxhc3NpYW4sIEJpdGJ1Y2tldCkgKm1heSogYmUgaW50ZXJlc3RlZCBp
biBhY3RpdmUgc3VwcG9ydC4NCg0KVGhhbmtzLA0KU3RlZmFuDQo=
