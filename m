Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940451FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 22:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756338AbcLAWzL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 17:55:11 -0500
Received: from mx0a-00176a03.pphosted.com ([67.231.149.52]:60280 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753150AbcLAWzL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2016 17:55:11 -0500
X-Greylist: delayed 1130 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Dec 2016 17:55:10 EST
Received: from pps.filterd (m0048274.ppops.net [127.0.0.1])
        by m0048274.ppops.net-00176a03. (8.16.0.17/8.16.0.17) with SMTP id uB1MXFD9030042
        for <git@vger.kernel.org>; Thu, 1 Dec 2016 17:36:19 -0500
From:   "Alfonsogonzalez, Ernesto (GE Digital)" 
        <ernesto.alfonsogonzalez@ge.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: EXT: Re: "Your branch is ahead of 'origin' by X commits"
Thread-Topic: EXT: Re: "Your branch is ahead of 'origin' by X commits"
Thread-Index: AQHSTB7B11MtfUC1okK4vus5mnSkVKDz/siA//99T4A=
Date:   Thu, 1 Dec 2016 22:36:10 +0000
Message-ID: <D465E524.B977%ernesto.alfonsogonzalez@ge.com>
References: <D465DC74.B911%ernesto.alfonsogonzalez@ge.com>
 <20161201222354.yu2q62udi56ygyoz@sigill.intra.peff.net>
In-Reply-To: <20161201222354.yu2q62udi56ygyoz@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [3.159.19.181]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7BBB64BC679514AB7F3D5164B8A3329@mail.ad.ge.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-12-01_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1609300000
 definitions=main-1612010361
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

WWVzLCBpdCBsb29rcyBsaWtlIEkgaGFkIGEgbG9jYWwgYnJhbmNoIOKAnG9yaWdpbuKAnSB3aGlj
aCB3YXMgYmVoaW5kIGJ5IDEwOA0KY29tbWl0cy4gDQoNClNldHRpbmcgdXBzdHJlYW0gdG8gdGhl
IGxvY2FsIGJyYW5jaCBjb3JyZWN0bHkgc3RhdGVzICJ0cmFjayBsb2NhbCBicmFuY2gNCm9yaWdp
buKAnS4NCg0KSXQgd2FzIG15IG1pc3Rha2UsIHRoZXJlIGlzIG5vIGJ1Zy4NCg0KVGhhbmtzLA0K
DQoNCiQgZ2l0IHJldi1wYXJzZSAtLXN5bWJvbGljLWZ1bGwtbmFtZSBvcmlnaW4NCnJlZnMvaGVh
ZHMvb3JpZ2luDQojIG9yaWdpbiBpcyBhIGxvY2FsIGJyYW5jaA0KDQokIGdpdCBzaG93IHJlZnMv
aGVhZHMvb3JpZ2luDQpjb21taXQgYWQ4YzNlZTZjYjc3NDA2MjdlNGVjZGRiNDE4YzgyNmJjODU5
N2QzZCAjIG9sZCBjb21taXQsIDEwOCBjb21taXRzDQpiZWhpbmQgbWFzdGVyDQoNCg0KJCBnaXQg
YnJhbmNoDQouLi4NCiogbWFzdGVyDQouLi4NCiAgb3JpZ2luDQouLi4NCg0KJCBnaXQgc2hvdyBv
cmlnaW4gDQpjb21taXQgYWQ4YzNlZTZjYjc3NDA2MjdlNGVjZGRiNDE4YzgyNmJjODU5N2QzZA0K
TWVyZ2U6IGUxNmJkYTMgNGI3NTY0ZA0KDQokIGdpdCBicmFuY2ggLS1zZXQtdXBzdHJlYW0tdG89
b3JpZ2luL21hc3Rlcg0KQnJhbmNoIG1hc3RlciBzZXQgdXAgdG8gdHJhY2sgcmVtb3RlIGJyYW5j
aCBtYXN0ZXIgZnJvbSBvcmlnaW4NCg0KDQokIGdpdCBicmFuY2ggLS1zZXQtdXBzdHJlYW0tdG89
b3JpZ2luICNjb3JyZWN0bHkgc2F5cyAidHJhY2sgbG9jYWwgYnJhbmNoDQpvcmlnaW4iDQpCcmFu
Y2ggbWFzdGVyIHNldCB1cCB0byB0cmFjayBsb2NhbCBicmFuY2ggb3JpZ2luLg0KDQokIGdpdCBz
dGF0dXMNCk9uIGJyYW5jaCBtYXN0ZXINCllvdXIgYnJhbmNoIGlzIGFoZWFkIG9mICdvcmlnaW4n
IGJ5IDEwOCBjb21taXRzLg0KICAodXNlICJnaXQgcHVzaCIgdG8gcHVibGlzaCB5b3VyIGxvY2Fs
IGNvbW1pdHMpDQpVbnRyYWNrZWQgZmlsZXM6DQogICh1c2UgImdpdCBhZGQgPGZpbGU+Li4uIiB0
byBpbmNsdWRlIGluIHdoYXQgd2lsbCBiZSBjb21taXR0ZWQpDQoNCi4uLg0Kbm90aGluZyBhZGRl
ZCB0byBjb21taXQgYnV0IHVudHJhY2tlZCBmaWxlcyBwcmVzZW50ICh1c2UgImdpdCBhZGQiIHRv
DQp0cmFjaykNCg0KDQokIGdpdCBicmFuY2ggLWQgb3JpZ2luDQpEZWxldGVkIGJyYW5jaCBvcmln
aW4gKHdhcyBhZDhjM2VlKS4NCiQNCg0KJCBnaXQgc3RhdHVzDQpPbiBicmFuY2ggbWFzdGVyDQpZ
b3VyIGJyYW5jaCBpcyBiYXNlZCBvbiAnb3JpZ2luJywgYnV0IHRoZSB1cHN0cmVhbSBpcyBnb25l
Lg0KICAodXNlICJnaXQgYnJhbmNoIC0tdW5zZXQtdXBzdHJlYW0iIHRvIGZpeHVwKQ0KDQoNCg0K
DQpPbiAxMi8xLzE2LCAyOjIzIFBNLCAiSmVmZiBLaW5nIiA8cGVmZkBwZWZmLm5ldD4gd3JvdGU6
DQoNCj5PbiBUaHUsIERlYyAwMSwgMjAxNiBhdCAxMDowMzozM1BNICswMDAwLCBBbGZvbnNvZ29u
emFsZXosIEVybmVzdG8gKEdFDQo+RGlnaXRhbCkgd3JvdGU6DQo+DQo+PiBTbyBJIHVzZWQgYnJh
bmNoIOKAuXNldC11cHN0cmVhbSBhbmQgc2VlIHRoZSBleHBlY3RlZCBiZWhhdmlvci4NCj4+IA0K
Pj4gJCBnaXQgYnJhbmNoIC0tc2V0LXVwc3RyZWFtLXRvPW9yaWdpbi9tYXN0ZXINCj4+IEJyYW5j
aCBtYXN0ZXIgc2V0IHVwIHRvIHRyYWNrIHJlbW90ZSBicmFuY2ggbWFzdGVyIGZyb20gb3JpZ2lu
Lg0KPg0KPkFoLCB0aGF0IG1ha2VzIHNlbnNlLg0KPg0KPj4gScK5bSBzdGlsbCBub3Qgc3VyZSB3
aGF0IGl0IG1lYW5zIGZvciB0aGUgYnJhbmNoIHVwc3RyZWFtIHRvIGJlIMKzb3JpZ2luwrINCj4+
IG9ubHkuDQo+DQo+VGhlIG5hbWUgIm9yaWdpbiIgZ2VuZXJhbGx5IHJlc29sdmVzIHRvIHJlZnMv
cmVtb3Rlcy9vcmlnaW4vSEVBRCwgd2hpY2gNCj5pcyBhIHN5bWJvbGljIHJlZiBwb2ludGluZyB0
byB0aGUgImRlZmF1bHQgYnJhbmNoIiBmb3IgdGhhdCByZW1vdGUuDQo+VGhhdCdzIGdlbmVyYWxs
eSBzZXQgYXQgY2xvbmUgdGltZSBmcm9tIHdoYXQgdGhlIHJlbW90ZSBoYXMgaW4gaXRzIEhFQUQs
DQo+YnV0IHlvdSBjYW4gdXBkYXRlIGl0IHdpdGggImdpdCByZW1vdGUgc2V0LWhlYWQiIGlmIHlv
dSB3YW50IHRvLg0KPg0KPkJ1dCB0aGF0J3MganVzdCBmb3IgcmVzb2x2aW5nIHRoZSBuYW1lOyBJ
J20gbm90IHN1cmUgdGhhdCBpdCB3b3VsZCB3b3JrDQo+dG8gc2V0IGEgYnJhbmNoJ3MgdXBzdHJl
YW0gdG8ganVzdCAib3JpZ2luIi4gIERvIHlvdSBwb3NzaWJseSBoYXZlDQo+YW5vdGhlciByZWYg
bmFtZWQgb3JpZ2luPw0KPg0KPi1QZWZmDQoNCg==
