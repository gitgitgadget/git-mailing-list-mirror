Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A3C20899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdHNRym (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:54:42 -0400
Received: from mx0b-00105401.pphosted.com ([67.231.152.184]:41056 "EHLO
        mx0b-00105401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750753AbdHNRyl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Aug 2017 13:54:41 -0400
Received: from pps.filterd (m0074333.ppops.net [127.0.0.1])
        by m0074333.ppops.net (8.16.0.21/8.16.0.21) with SMTP id v7EHsVcT023481;
        Mon, 14 Aug 2017 13:54:39 -0400
Received: from xnwpv31.utc.com ([167.17.239.11])
        by m0074333.ppops.net with ESMTP id 2cbdvbbhbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2017 13:54:39 -0400
Received: from pps.filterd (xnwpv31.utc.com [127.0.0.1])
        by xnwpv31.utc.com (8.15.0.59/8.15.0.59) with SMTP id v7EHegWO018486;
        Mon, 14 Aug 2017 13:54:38 -0400
Received: from uusmna21.corp.utc.com (uusmna21.corp.utc.com [159.82.227.11])
        by xnwpv31.utc.com with ESMTP id 2cbgfnr5kq-1
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2017 13:54:38 -0400
Received: from UUSALE0D.utcmail.com (UUSALE0D.utcmail.com [10.220.35.23])
        by uusmna21.corp.utc.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v7EHsbSZ021383
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2017 13:54:38 -0400
Received: from UUSALE0M.utcmail.com (10.220.35.32) by UUSALE0D.utcmail.com
 (10.220.35.23) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Mon, 14 Aug
 2017 13:54:36 -0400
Received: from UUSALE0M.utcmail.com ([10.220.35.32]) by UUSALE0M.utcmail.com
 ([10.220.35.32]) with mapi id 15.00.1263.000; Mon, 14 Aug 2017 13:54:36 -0400
From:   "Burkhardt, Glenn B        UTAS" <Glenn.Burkhardt@utas.utc.com>
To:     =?utf-8?B?VXjDrW8gUHJlZ28=?= <uprego@madiva.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [External] Re: gitk -m ?
Thread-Topic: [External] Re: gitk -m ?
Thread-Index: AdMMfuPtWkaB7cx3TfmXS1g/Ao0BcwIXnU4AAAgsbxAAEB5FgAAGH27w
Date:   Mon, 14 Aug 2017 17:54:36 +0000
Message-ID: <6d6b4dedba7147b6bd585956db368c8b@UUSALE0M.utcmail.com>
References: <6ef11677ca184e78a545452ffffe55a1@UUSALE0M.utcmail.com>
 <7F03EAEF-DFDA-4CD0-86A1-A06C775A895B@madiva.com>
 <605cecc7f196495fa3d25113f28915e0@UUSALE0M.utcmail.com>
 <CANidDKbad2rYK0Cm=VejSp0FU7MRvCzo5Sxfzr-XTLYjbtfWtg@mail.gmail.com>
In-Reply-To: <CANidDKbad2rYK0Cm=VejSp0FU7MRvCzo5Sxfzr-XTLYjbtfWtg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-version: 3.5.15.2
x-tituslabs-classificationhash-30: VgNFIFU9Hx+/nZJb9Kg7IjMlMi8h89VCWKDzkBE7Ya2KD7Y6lQ/WIAxaTs8E6hU/BkiIy4U1JUwVOsB72QRUIU/1pLVt2/8wZMGFG7Pmp5tyz3cnbrL/FBF0cMH0Q1YzoysBYF2uH37MP8oTq6MU0qQOWZYDX9pC3Z/EWqh3WE/C6PqQkPc7kGHX7VYRizlB
x-tituslabs-classifications-30: TLPropertyRoot=UTC;TechnicalData=No;
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.220.3.240]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1706020000
 definitions=main-1708140293
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

TmVpdGhlciBvZiB0aG9zZSB0d28gd29yayBmb3IgbWUuICBUaGV5IGRvbid0IGxpbWl0IHRoZSB2
aWV3IHRvIHRoZSBzaW5nbGUgZmlsZSBvZiBpbnRlcmVzdC4gIA0KDQpBbHNvLCBJIHRyaWVkICJh
ZGRpdGlvbmFsIGFyZ3VtZW50cyB0byBnaXQgbG9nIiwgdXNpbmcgIi1tIC0tZm9sbG93Ii4gIEkg
ZmlsbGVkIGluIHRoZSBzaW5nbGUgZmlsZSBvZiBpbnRlcmVzdCBpbiB0aGUgJ0VudGVyIGZpbGVz
JyBzZWN0aW9uLiAgVGhlIGVycm9yIG1lc3NhZ2Ugd2FzOg0KDQoJQ2FuJ3QgcGFyc2UgZ2l0IGxv
ZyBvdXRwdXQ6ICB7Y29tbWl0IDljYzhiZS4uLiBmYWFiOTkuLi4gfQ0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogVXjDrW8gUHJlZ28gW21haWx0bzp1cHJlZ29AbWFkaXZhLmNv
bV0gDQpTZW50OiBNb25kYXksIEF1Z3VzdCAxNCwgMjAxNyAxMjo0Nw0KVG86IEJ1cmtoYXJkdCwg
R2xlbm4gQiBVVEFTDQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtFeHRl
cm5hbF0gUmU6IGdpdGsgLW0gPw0KDQpJIGRvIG5vdCBrbm93IGlmIHlvdSBjYW4gZG8gd2hhdCB5
b3Ugd2FudCwgbW9zdGx5IGlmIHlvdSBjYW4gZG8gd2hhdCB5b3Ugd2FudCBhcyBzaW1wbHkgYXMg
eW91IG1pZ2h0IGJlIHdhbnRpbmcgdGhhdCB5b3Ugd2FudCBpdCwgYnV0IEkgZ3Vlc3MgeW91IGNv
dWxkIHVzZSB0aGlzIGdpdGsgYm9vdCBjb21tYW5kIGFzIGEgX3NpbXBsZV8gd29yayBhcm91bmQg
c29tZWhvdyBhbGlhc2VkIHdpdGhpbiB5b3VyIGNvbW1hbmQgbGluZSBjb25maWd1cmF0aW9uOg0K
DQogICAgJCBnaXRrICgtLWFsbCk/ICQoZ2l0IGxvZyAtbSAtLWZvbGxvdyAtLXByZXR0eT1mb3Jt
YXQ6JWggUEFUSFNQRUMpDQoNCkFsdGVybmF0aXZlbHksIHRoZXJlIGlzIGEgX3ZpZXcgY29uZmln
dXJhdGlvbl8gbWVudSAoX25ldyB2aWV3XywgX2VkaXQgdmlld18pIHdoZXJlIHRoZXJlIGlzIGEg
dGV4dCBib3ggbGFiZWxlZCBfQ29tbWFuZCB0byBnZW5lcmF0ZSBtb3JlIGNvbW1pdHMgdG8gaW5j
bHVkZV8uIElmIHlvdSB0eXBlIGhlcmU6DQoNCiAgICBnaXQgbG9nIC1tIC0tZm9sbG93IC0tcHJl
dHR5PWZvcm1hdDolaCBQQVRIU1BFQw0KDQpJIGRvIG5vdCBrbm93IHdoYXQgd2lsbCBoYXBwZW4g
YW5kIEkgY2FuIG5vdCB0ZXN0IHRoYXQgbm93IChJIGV2ZW50dWFsbHkgd2lsbCksIGJ1dCBjaGFu
Y2VzIGFyZSBpdCBjb3VsZCBkbyB3aGF0IHlvdSB3YW50ZWQuIE1heWJlIHlvdSBjYW4gZXZlbiB1
c2UgY3VzdG9tIGFsaWFzZXMgaW4gdGhlcmUgdGhhdCB0ZXh0IGJveC4NCg0KSSBndWVzcyB5b3Ug
YXJlIHJlY2VpdmluZyBhIG1vcmUgYXV0aG9yaXplZCBhbnN3ZXIgc29vbmlzaCwgaW4gdGhlIG1l
YW53aGlsZSwgaG9wZSB0aGF0IGhlbHBlZC4NCg0KUmVnYXJkcywNCg0KDQpPbiAxNCBBdWcgMjAx
NywgYXQgMTU6MjAsIEJ1cmtoYXJkdCwgR2xlbm4gQiBVVEFTIDxHbGVubi5CdXJraGFyZHRAdXRh
cy51dGMuY29tPiB3cm90ZToNCg0KVGhleSBkb24ndC4gIEluIHBhcnRpY3VsYXIsIGluZm9ybWF0
aW9uIGFib3V0IGNvbW1pdHMgdGhhdCBhcmUgcGFydHMgb2YgbWVyZ2VzIGlzIG1pc3NpbmcuDQoN
CkhlcmUncyBhbiBleGFtcGxlLiAgVGhlcmUgYXJlIG9ubHkgdHdvIGVudHJpZXMgbGlzdGVkIGlu
ICdnaXRrIC0tYWxsJw0KZm9yIGEgcGFydGljdWxhciBmaWxlIChzb3JyeSwgSSdkIHByZWZlciB0
byBpbmNsdWRlIGEgc2NyZWVuIHNobywgYnV0IHRoZSBtYWlsaW5nIGxpc3QgZG9lc24ndCBhbGxv
dyBIVE1MIG1lc3NhZ2VzKS4NCg0KZ2l0ayAtLWFsbCBNQU5JRkVTVC5NRg0KDQpQYXJlbnQ6IGY3
NDYyNjg0YWU3ODcyMGFhYzA1YzkyOTI1NmQ3NzAxMThjZjAxZmEgKGluaXRpYWwgY2xvbmUgZnJv
bSBDbGVhcmNhc2UgaW50ZWczIGJyYW5jaCkNCkJyYW5jaGVzOiBtYXN0ZXIsIHJlbW90ZXMvb3Jp
Z2luL21hc3RlciwgcmVtb3Rlcy9vcmlnaW4vd3csIHd3DQpGb2xsb3dzOg0KUHJlY2VkZXM6DQoN
CiAgIHJlcXVpcmUgamF2YSAxLjgNCg0KQ2hpbGQ6ICAyNDBmMTUxZDYxZmQ0ZmQwNmYzNzdiYzUy
OTcwYjM1NzRlNWY5MDMxIChyZXF1aXJlIGphdmEgMS44KQ0KQnJhbmNoZXM6IG1hc3RlciwgcmVt
b3Rlcy9vcmlnaW4vbWFzdGVyLCByZW1vdGVzL29yaWdpbi93dywgd3cNCkZvbGxvd3M6DQpQcmVj
ZWRlczoNCg0KICAgaW5pdGlhbCBjbG9uZSBmcm9tIENsZWFyY2FzZSBpbnRlZzMgYnJhbmNoDQoN
Cg0KZ2l0IGxvZyB3aXRoICctbScgYW5kICctZm9sbG93JyBzaG93czoNCg0KJCBnaXQgbG9nIC1t
IC0tZm9sbG93IC0tb25lbGluZSBNQU5JRkVTVC5NRg0KOWNjOGJlNCAoZnJvbSAxMjIyZDdjKSBN
ZXJnZSBicmFuY2ggJ21hc3RlcicgaW50byB3dzsgc3RyYXRlZ3kgIm91cnMiDQphNDIzZjJkIChm
cm9tIGY4Njk5NTApIG1lcmdlIGZyb20gd3cgYnJhbmNoOyByZW1vdmUgQnVuZGxlLU5hdGl2ZUNv
ZGUNCjUxZjA2MjggKGZyb20gMmM2NDc4YykgTWVyZ2UgYnJhbmNoICd3dycgb2YgY292ZXJpdHk6
cm1wcyBpbnRvIHd3DQoyNDBmMTUxIHJlcXVpcmUgamF2YSAxLjgNCmY3NDYyNjggaW5pdGlhbCBj
bG9uZSBmcm9tIENsZWFyY2FzZSBpbnRlZzMgYnJhbmNoDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IFV4w61vIFByZWdvIFttYWlsdG86dXByZWdvQG1hZGl2YS5jb21dDQpT
ZW50OiBNb25kYXksIEF1Z3VzdCAxNCwgMjAxNyAwMToxMg0KVG86IEJ1cmtoYXJkdCwgR2xlbm4g
QiBVVEFTDQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogW0V4dGVybmFsXSBSZTog
Z2l0ayAtbSA/DQoNCk5vdCBzdXJlIHdoYXQgeW91IGFyZSB3YW50aW5nIHRvIGFjaGlldmUsIGJ1
dCBwbGVhc2UgbWFrZSBzdXJlIG5laXRoZXIgYGdpdGsgUEFUSFNQRUNgIG5vciBgZ2l0ayAtLWFs
bCBQQVRIU1BFQ2AgYXJlIHByZXNlbnRpbmcgeW91IGVub3VnaCBpbmZvcm1hdGlvbi4NCg0KT24g
MyBBdWcgMjAxNywgYXQgMTk6MzcsIEJ1cmtoYXJkdCwgR2xlbm4gQiBVVEFTIDxHbGVubi5CdXJr
aGFyZHRAdXRhcy51dGMuY29tPiB3cm90ZToNCg0KSSd2ZSBiZWVuIGxvb2tpbmcgaW4gJ2dpdGsn
IGZvciBhbiBvcHRpb24gdGhhdCBkb2VzIHdoYXQgJ2dpdCBsb2cgLW0nDQpkb2VzLiAgRGlkIEkg
bWlzcyBzb21ldGhpbmc/ICBJbiBwYXJ0aWN1bGFyLCBJJ2QgbGlrZSB0byBnZXQgaW5mb3JtYXRp
b24gYWJvdXQgYSBmaWxlIHRoYXQncyBjdXJyZW50bHkgYXZhaWxhYmxlIHdpdGggImdpdCBsb2cg
LW0gLS1hbGwgLS1mb2xsb3ciLCBidXQgcHJlc2VudGVkIGluICdnaXRrJy4gIElmIGl0J3Mgbm90
IHRoZXJlLCBwbGVhc2UgY29uc2lkZXIgdGhpcyBhIGZlYXR1cmUgcmVxdWVzdC4NCg0KVGhhbmtz
Lg0K
