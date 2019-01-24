Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08EF71F453
	for <e@80x24.org>; Thu, 24 Jan 2019 15:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfAXP2P (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 10:28:15 -0500
Received: from mx0b-0000bf01.pphosted.com ([67.231.152.145]:53708 "EHLO
        mx0a-0000bf01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727755AbfAXP2P (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Jan 2019 10:28:15 -0500
Received: from pps.filterd (m0042341.ppops.net [127.0.0.1])
        by mx0b-0000bf01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0OFO8dt032285;
        Thu, 24 Jan 2019 09:28:13 -0600
Received: from np1exhc103.corp.halliburton.com ([134.132.53.12])
        by mx0b-0000bf01.pphosted.com with ESMTP id 2q7frn05hh-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Jan 2019 09:28:12 -0600
Received: from NP1EXHC106.corp.halliburton.com (10.192.132.210) by
 NP1EXHC103.corp.halliburton.com (10.192.132.207) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 09:27:49 -0600
Received: from NP1EXMB203.corp.halliburton.com ([169.254.6.8]) by
 NP1EXHC106.corp.halliburton.com ([10.192.132.210]) with mapi id
 14.03.0415.000; Thu, 24 Jan 2019 09:27:49 -0600
From:   Naum Derzhi <Naum.Derzhi@halliburton.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Removing data from repository
Thread-Topic: [EXTERNAL] Re: Removing data from repository
Thread-Index: AdSz7s7aSPVattG+TsebHRS3nLc11AABTpqwAA2Ms4AADDpwMA==
Date:   Thu, 24 Jan 2019 15:27:48 +0000
Message-ID: <7A854577E980BE4FB29FDD041B9B75E701799D06@NP1EXMB203.corp.halliburton.com>
References: <7A854577E980BE4FB29FDD041B9B75E701798CEE@NP1EXMB203.corp.halliburton.com>
 <20190124151739.GA26616@sigill.intra.peff.net>
In-Reply-To: <20190124151739.GA26616@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.192.128.17]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901240108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmsgeW91IHZlcnkgbXVjaC4gV2UnbGwgdHJ5DQoNCsKgDQrCoA0KTmF1bSBEZXJ6aGkNCkNo
aWVmIFNjaWVudGlmaWMgQWR2aXNlciwgUGh5c2ljcw0KwqANCjMwMDAgTiBTYW0gSG91c3RvbiBQ
a3d5IEUsIFRlY2hub2xvZ3kgQ2VudGVyLCBPZmZpY2UgVDEyNDFIDQpIb3VzdG9uLCBUWCA3NzAz
Mg0KDQpPZmZpY2U6ICsxICgyODEpIDg3MSAzMjc4DQoNCkZvbGxvdyBIYWxsaWJ1cnRvbjogTGlu
a2VkSW4gfCBGYWNlYm9vayB8IFR3aXR0ZXIgfCBZb3VUdWJlIHwgQmxvZw0KDQrCoA0KDQrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIA0KDQoNCg0KDQpUaGlzIGUtbWFp
bCwgaW5jbHVkaW5nIGFueSBhdHRhY2hlZCBmaWxlcywgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFs
IGFuZCBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVu
ZGVkIHJlY2lwaWVudC4gQW55IHJldmlldywgdXNlLCBkaXN0cmlidXRpb24sIG9yIGRpc2Nsb3N1
cmUgYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBp
bnRlbmRlZCByZWNpcGllbnQgKG9yIGF1dGhvcml6ZWQgdG8gcmVjZWl2ZSBpbmZvcm1hdGlvbiBm
b3IgdGhlIGludGVuZGVkIHJlY2lwaWVudCksIHBsZWFzZSBjb250YWN0IHRoZSBzZW5kZXIgYnkg
cmVwbHkgZS1tYWlsIGFuZCBkZWxldGUgYWxsIGNvcGllcyBvZiB0aGlzIG1lc3NhZ2UuDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+
IA0KU2VudDogVGh1cnNkYXksIEphbnVhcnkgMjQsIDIwMTkgOToxOCBBTQ0KVG86IE5hdW0gRGVy
emhpIDxOYXVtLkRlcnpoaUBoYWxsaWJ1cnRvbi5jb20+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9y
Zw0KU3ViamVjdDogW0VYVEVSTkFMXSBSZTogUmVtb3ZpbmcgZGF0YSBmcm9tIHJlcG9zaXRvcnkN
Cg0KRXh0ZXJuYWwgU2VuZGVyOiBVc2UgY2F1dGlvbiB3aXRoIGxpbmtzL2F0dGFjaG1lbnRzLg0K
DQoNCg0KT24gVGh1LCBKYW4gMjQsIDIwMTkgYXQgMDI6NTE6NTBQTSArMDAwMCwgTmF1bSBEZXJ6
aGkgd3JvdGU6DQoNCj4gSSBoYXZlIHRoaXMgcHJvYmxlbTogeWVhcnMgYWdvIG9uZSBvZiBvdXIg
ZGV2ZWxvcGVycyBjb21taXR0ZWQgYSBsYXJnZQ0KPiAoR2lnYWJ5dGVzKSBwaWVjZSBvZiBiaW5h
cnkgZGF0YSBpbnRvIG91ciBwcm9qZWN0IHJlcG9zaXRvcnkuIFRoaXMgDQo+IHNob3VsZCBub3Qg
aGF2ZSBiZWVuIGRvbmUsIGJ1dCBpdCBoYXBwZW5lZC4gKEhvbmVzdCwgaXQgd2FzIG5vdCBtZSku
DQo+IFdlIG5ldmVyIG5lZWRlZCB0aGlzIGRhdGEgaW4gdGhlIHJlcG9zaXRvcnkuDQo+DQo+IFVz
aW5nIGdpdCBybSByZW1vdmVzIHRoZXNlIGZpbGVzIGZyb20gdGhlIHdvcmtpbmcgdHJlZSwgYnV0
IHRoZXkgYXJlIA0KPiBzdGlsbCBzb21ld2hlcmUgaW4gdGhlIHJlcG9zaXRvcnksIHNvIHdoZW4g
d2UgY2xvbmUsIHdlIHRyYW5zZmVyIA0KPiBnaWdhYnl0ZXMgb2YgdW5uZWVkZWQgZGF0YS4NCj4N
Cj4gSXMgaXQgcG9zc2libGUgdG8gZml4IHRoaXMgcHJvYmxlbT8NCg0KWW91J2xsIGhhdmUgdG8g
cmV3cml0ZSB0aGUgb2ZmZW5kaW5nIGhpc3RvcnkuIFlvdSBjYW4gdXNlIGdpdC1maWx0ZXItYnJh
bmNoLiBTZWUgZXNwZWNpYWxseSB0aGVzZSBzZWN0aW9ucyBvZiB0aGUgbWFucGFnZToNCg0KICBo
dHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2dpdC0y
RHNjbS5jb21fZG9jc19naXQtMkRmaWx0ZXItMkRicmFuY2gtMjMtNUZleGFtcGxlcyZkPUR3SUJh
USZjPVBza3ZpeHRFVURLN3d1V1UtdElnNm9LdUdZQlJick1YazJGWnZGMFVmVG8mcj1vc0RFTmU5
azRkRUx5eWg4Wm1WenlXdlZtekRGQkI5Wl9OSGpZQVhucU1nJm09MDkwYVVTcVRxOWJoZXdNMmgx
MmFFeHlWOXZEUlc2MHd3VGNjekl1dTdUZyZzPV9jZGttX0U5ZG1NN3l1TngwXzVmcFFLclY5d3Ru
RzRMUHI4dW9vaVYzY0kmZT0NCg0KICBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20v
djIvdXJsP3U9aHR0cHMtM0FfX2dpdC0yRHNjbS5jb21fZG9jc19naXQtMkRmaWx0ZXItMkRicmFu
Y2gtMjMtNUZjaGVja2xpc3QtNUZmb3ItNUZzaHJpbmtpbmctNUZhLTVGcmVwb3NpdG9yeSZkPUR3
SUJhUSZjPVBza3ZpeHRFVURLN3d1V1UtdElnNm9LdUdZQlJick1YazJGWnZGMFVmVG8mcj1vc0RF
TmU5azRkRUx5eWg4Wm1WenlXdlZtekRGQkI5Wl9OSGpZQVhucU1nJm09MDkwYVVTcVRxOWJoZXdN
MmgxMmFFeHlWOXZEUlc2MHd3VGNjekl1dTdUZyZzPWlCZXVMa05OWmJMcWNBbUtOdzZKSTdUblN0
NktET2JJRGFCYUVnUUZjRFEmZT0NCg0KYXMgd2VsbCBhcyB0aGUgd2FybmluZyBpbiB0aGUgREVT
Q1JJUFRJT04gc2VjdGlvbjoNCg0KICBXQVJOSU5HISBUaGUgcmV3cml0dGVuIGhpc3Rvcnkgd2ls
bCBoYXZlIGRpZmZlcmVudCBvYmplY3QgbmFtZXMgZm9yDQogIGFsbCB0aGUgb2JqZWN0cyBhbmQg
d2lsbCBub3QgY29udmVyZ2Ugd2l0aCB0aGUgb3JpZ2luYWwgYnJhbmNoLiBZb3UNCiAgd2lsbCBu
b3QgYmUgYWJsZSB0byBlYXNpbHkgcHVzaCBhbmQgZGlzdHJpYnV0ZSB0aGUgcmV3cml0dGVuIGJy
YW5jaCBvbg0KICB0b3Agb2YgdGhlIG9yaWdpbmFsIGJyYW5jaC4gUGxlYXNlIGRvIG5vdCB1c2Ug
dGhpcyBjb21tYW5kIGlmIHlvdSBkbw0KICBub3Qga25vdyB0aGUgZnVsbCBpbXBsaWNhdGlvbnMs
IGFuZCBhdm9pZCB1c2luZyBpdCBhbnl3YXksIGlmIGEgc2ltcGxlDQogIHNpbmdsZSBjb21taXQg
d291bGQgc3VmZmljZSB0byBmaXggeW91ciBwcm9ibGVtLiAoU2VlIHRoZSAiUkVDT1ZFUklORw0K
ICBGUk9NIFVQU1RSRUFNIFJFQkFTRSIgc2VjdGlvbiBpbiBnaXQtcmViYXNlKDEpIGZvciBmdXJ0
aGVyIGluZm9ybWF0aW9uDQogIGFib3V0IHJld3JpdGluZyBwdWJsaXNoZWQgaGlzdG9yeS4pDQoN
CllvdSBtYXkgYWxzbyB3YW50IHRvIGNoZWNrIG91dCB0aGUgQkZHIHJlcG8gY2xlYW5lclsxXSwg
YXMgc2VwYXJhdGUgcHJvamVjdCB0aGF0IGhhbmRsZXMgdGhpcyBjYXNlIGEgbGl0dGxlIG1vcmUg
c2ltcGx5IChpdCBkb2Vzbid0IHNhdmUgeW91IGZyb20gZGVhbGluZyB3aXRoIHJld3JpdHRlbiBo
aXN0b3J5LCBidXQgaXQgZG9lcyBhdm9pZCBoYXZpbmcgdG8gbGVhcm4gZmlsdGVyLWJyYW5jaCdz
IGZsZXhpYmxlIGJ1dCBjb25mdXNpbmcgc3ludGF4KS4NCg0KLVBlZmYNCg0KWzFdIGh0dHBzOi8v
dXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fcnR5bGV5LmdpdGh1
Yi5pb19iZmctMkRyZXBvLTJEY2xlYW5lcl8mZD1Ed0lCYVEmYz1Qc2t2aXh0RVVESzd3dVdVLXRJ
ZzZvS3VHWUJSYnJNWGsyRlp2RjBVZlRvJnI9b3NERU5lOWs0ZEVMeXloOFptVnp5V3ZWbXpERkJC
OVpfTkhqWUFYbnFNZyZtPTA5MGFVU3FUcTliaGV3TTJoMTJhRXh5Vjl2RFJXNjB3d1RjY3pJdXU3
VGcmcz1BRElRWHRRckhVdjN4WHVkZkNOOTRlTDAweDB3MHZyOHVLMkZRTXBBMmRJJmU9DQo=
