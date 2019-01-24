Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5591F453
	for <e@80x24.org>; Thu, 24 Jan 2019 15:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfAXP32 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 10:29:28 -0500
Received: from mx0a-0000bf01.pphosted.com ([67.231.144.145]:33986 "EHLO
        mx0a-0000bf01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727755AbfAXP32 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Jan 2019 10:29:28 -0500
Received: from pps.filterd (m0042240.ppops.net [127.0.0.1])
        by mx0a-0000bf01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OFGkbi002113;
        Thu, 24 Jan 2019 09:29:14 -0600
Received: from np1exhc103.corp.halliburton.com ([134.132.53.12])
        by mx0a-0000bf01.pphosted.com with ESMTP id 2q7ev40j5w-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Jan 2019 09:29:14 -0600
Received: from NP1EXMB203.corp.halliburton.com ([169.254.6.8]) by
 NP1EXHC103.corp.halliburton.com ([10.192.132.207]) with mapi id
 14.03.0415.000; Thu, 24 Jan 2019 09:28:42 -0600
From:   Naum Derzhi <Naum.Derzhi@halliburton.com>
To:     "paul@mad-scientist.net" <paul@mad-scientist.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Removing data from repository
Thread-Topic: [EXTERNAL] Re: Removing data from repository
Thread-Index: AdSz7s7aSPVattG+TsebHRS3nLc11AABTpqwAA252gAADF22wA==
Date:   Thu, 24 Jan 2019 15:28:42 +0000
Message-ID: <7A854577E980BE4FB29FDD041B9B75E701799D1C@NP1EXMB203.corp.halliburton.com>
References: <7A854577E980BE4FB29FDD041B9B75E701798CEE@NP1EXMB203.corp.halliburton.com>
 <9dce6a3d8ff2f10621ea81fbd9ac9964c10aff9c.camel@mad-scientist.net>
In-Reply-To: <9dce6a3d8ff2f10621ea81fbd9ac9964c10aff9c.camel@mad-scientist.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.192.128.17]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901240107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91DQoNCsKgDQrCoA0KTmF1bSBEZXJ6aGkNCkNoaWVmIFNjaWVudGlmaWMgQWR2aXNl
ciwgUGh5c2ljcw0KwqANCjMwMDAgTiBTYW0gSG91c3RvbiBQa3d5IEUsIFRlY2hub2xvZ3kgQ2Vu
dGVyLCBPZmZpY2UgVDEyNDFIDQpIb3VzdG9uLCBUWCA3NzAzMg0KDQpPZmZpY2U6ICsxICgyODEp
IDg3MSAzMjc4DQoNCkZvbGxvdyBIYWxsaWJ1cnRvbjogTGlua2VkSW4gfCBGYWNlYm9vayB8IFR3
aXR0ZXIgfCBZb3VUdWJlIHwgQmxvZw0KDQrCoA0KDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIA0KDQoNCg0KDQpUaGlzIGUtbWFpbCwgaW5jbHVkaW5nIGFueSBhdHRh
Y2hlZCBmaWxlcywgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZCBwcml2aWxlZ2VkIGluZm9y
bWF0aW9uIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudC4gQW55IHJl
dmlldywgdXNlLCBkaXN0cmlidXRpb24sIG9yIGRpc2Nsb3N1cmUgYnkgb3RoZXJzIGlzIHN0cmlj
dGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgKG9y
IGF1dGhvcml6ZWQgdG8gcmVjZWl2ZSBpbmZvcm1hdGlvbiBmb3IgdGhlIGludGVuZGVkIHJlY2lw
aWVudCksIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYnkgcmVwbHkgZS1tYWlsIGFuZCBkZWxl
dGUgYWxsIGNvcGllcyBvZiB0aGlzIG1lc3NhZ2UuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFBhdWwgU21pdGggPHBhdWxAbWFkLXNjaWVudGlzdC5uZXQ+IA0KU2VudDog
VGh1cnNkYXksIEphbnVhcnkgMjQsIDIwMTkgOToyMyBBTQ0KVG86IE5hdW0gRGVyemhpIDxOYXVt
LkRlcnpoaUBoYWxsaWJ1cnRvbi5jb20+OyBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBb
RVhURVJOQUxdIFJlOiBSZW1vdmluZyBkYXRhIGZyb20gcmVwb3NpdG9yeQ0KDQpFeHRlcm5hbCBT
ZW5kZXI6IFVzZSBjYXV0aW9uIHdpdGggbGlua3MvYXR0YWNobWVudHMuDQoNCg0KDQpPbiBUaHUs
IDIwMTktMDEtMjQgYXQgMTQ6NTEgKzAwMDAsIE5hdW0gRGVyemhpIHdyb3RlOg0KPiBHcmVldGlu
Z3MsDQo+DQo+IEkgaGF2ZSB0aGlzIHByb2JsZW06IHllYXJzIGFnbyBvbmUgb2Ygb3VyIGRldmVs
b3BlcnMgY29tbWl0dGVkIGEgbGFyZ2UgDQo+IChHaWdhYnl0ZXMpIHBpZWNlIG9mIGJpbmFyeSBk
YXRhIGludG8gb3VyIHByb2plY3QgcmVwb3NpdG9yeS4NCj4gVGhpcyBzaG91bGQgbm90IGhhdmUg
YmVlbiBkb25lLCBidXQgaXQgaGFwcGVuZWQuIChIb25lc3QsIGl0IHdhcyBub3QgDQo+IG1lKS4g
V2UgbmV2ZXIgbmVlZGVkIHRoaXMgZGF0YSBpbiB0aGUgcmVwb3NpdG9yeS4NCj4NCj4gVXNpbmcg
Z2l0IHJtIHJlbW92ZXMgdGhlc2UgZmlsZXMgZnJvbSB0aGUgd29ya2luZyB0cmVlLCBidXQgdGhl
eSBhcmUgDQo+IHN0aWxsIHNvbWV3aGVyZSBpbiB0aGUgcmVwb3NpdG9yeSwgc28gd2hlbiB3ZSBj
bG9uZSwgd2UgdHJhbnNmZXIgDQo+IGdpZ2FieXRlcyBvZiB1bm5lZWRlZCBkYXRhLg0KPg0KPiBJ
cyBpdCBwb3NzaWJsZSB0byBmaXggdGhpcyBwcm9ibGVtPw0KDQpJdCBpcyBwb3NzaWJsZSwgYnV0
IGl0IGlzbid0IHByZXR0eS4gIEJ5IHdhaXRpbmcgc28gbG9uZyB0byB0cnkgdG8gZml4IGl0IHlv
dSd2ZSBjb21wb3VuZGVkIHRoZSBpbXBhY3RzIGRyYW1hdGljYWxseSB1bmZvcnR1bmF0ZWx5LiAg
QnkgcmVtb3ZpbmcgdGhhdCBmaWxlIHlvdSB3aWxsIGluIGVmZmVjdCBiZSByZXdyaXRpbmcgdGhl
IGhpc3Rvcnkgb2YgeW91ciByZXBvc2l0b3J5IHN0YXJ0aW5nIHdpdGggdGhlIGNvbW1pdCB0aGF0
IGludHJvZHVjZWQgdGhlIHByb2JsZW1hdGljIGZpbGUsIHRoYXQgd2lsbCBiZSByZW1vdmVkLCBh
bGwgdGhlIHdheSBmb3J3YXJkLg0KDQpUaGF0IG1lYW5zIHRoYXQgZXZlcnkgY2xvbmUgb2YgdGhl
IHJlcG9zaXRvcnkgd2lsbCBoYXZlIHRvIGJlLCBhdCB0aGUgdmVyeSBsZWFzdCwgImhhcmQtcmVz
ZXQiIGFuZCBwcmVmZXJhYmx5ICh0byBhdm9pZCBhY2NpZGVudGFsbHkgcmUtIGludHJvZHVjaW5n
IHRoZSBiYWQgZmlsZSkgcmUtY2xvbmVkIGZyb20gc2NyYXRjaC4NCg0KQXMgZm9yIGFjdHVhbGx5
IHJlbW92aW5nIHRoZSBmaWxlLCB5b3UgY2FuIGZpbmQgaW5mb3JtYXRpb24gb24gaG93IHRvIGRv
IHRoaXMgYWxsIG92ZXIgdGhlIEdvb2dsZS4gIEhlcmUncyBzb21lIHJlYXNvbmFibGUgYWR2aWNl
IGZyb20NClN0YWNrT3ZlcmZsb3c6DQoNCg0KaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQu
Y29tL3YyL3VybD91PWh0dHBzLTNBX19zdGFja292ZXJmbG93LmNvbV9xdWVzdGlvbnNfMjEwMDkw
N19ob3ctMkR0by0yRHJlbW92ZS0yRGRlbGV0ZS0yRGEtMkRsYXJnZS0yRGZpbGUtMkRmcm9tLTJE
Y29tbWl0LTJEaGlzdG9yeS0yRGluLTJEZ2l0LTJEcmVwb3NpdG9yeSZkPUR3SUNhUSZjPVBza3Zp
eHRFVURLN3d1V1UtdElnNm9LdUdZQlJick1YazJGWnZGMFVmVG8mcj1vc0RFTmU5azRkRUx5eWg4
Wm1WenlXdlZtekRGQkI5Wl9OSGpZQVhucU1nJm09ZG1VVExFd3lyZG02aFJXT3psVEZxQmFWdjRf
V0pvVVdEZWQ5c0c0dURRMCZzPVFyTkd1dVd1TlpRcWtTa3NSVUs5c2ZjRzVpd1ZaSXhtRTZVWmNu
ZVJ4SGcmZT0NCg0K
