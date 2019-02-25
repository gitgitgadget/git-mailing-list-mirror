Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA0D20248
	for <e@80x24.org>; Mon, 25 Feb 2019 07:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfBYHii (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 02:38:38 -0500
Received: from mail.xcmg-erc.com ([217.7.126.107]:46613 "EHLO
        mail.xcmg-erc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBYHii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 02:38:38 -0500
Received: from SRV-ERC-MAIL01.XCMG-ERC.LOCAL (10.10.4.13) by
 SRV-ERC-MAIL01.XCMG-ERC.LOCAL (10.10.4.13) with Microsoft SMTP Server (TLS)
 id 15.0.1395.4; Mon, 25 Feb 2019 08:38:51 +0100
Received: from SRV-ERC-MAIL01.XCMG-ERC.LOCAL ([10.10.4.13]) by
 SRV-ERC-MAIL01.XCMG-ERC.LOCAL ([10.10.4.13]) with mapi id 15.00.1395.000;
 Mon, 25 Feb 2019 08:38:51 +0100
From:   "Celestino, Federico" <Celestino@xcmg-erc.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: .gitignore alleged bug
Thread-Topic: .gitignore alleged bug
Thread-Index: AdTKxNqE6kyTDHqgQLG6yVJKIKWOAgAQMmmAAHXbvpA=
Date:   Mon, 25 Feb 2019 07:38:50 +0000
Message-ID: <f8697f8e02614842b35931346c2d81e7@SRV-ERC-MAIL01.XCMG-ERC.LOCAL>
References: <b23df617fddf45389406da2360dceb63@SRV-ERC-MAIL01.XCMG-ERC.LOCAL>
 <20190223002339.GA601925@genre.crustytoothpaste.net>
In-Reply-To: <20190223002339.GA601925@genre.crustytoothpaste.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.10.4.150]
x-esetresult: clean, is OK
x-esetid: 37303A2986AD6E6C60756A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhciBNciBDYXJsc29uLA0KDQpZZXMsIHlvdSBhcmUgcmlnaHQuIFRoYW5rcyBmb3IgdGhlIHN1
cHBvcnQuDQoNCkZyZXVuZGxpY2hlIEdyw7zDn2UgLyBLaW5kIHJlZ2FyZHMNCmkuQS4gRmVkZXJp
Y28gQ2VsZXN0aW5vDQpFbnR3aWNrbHVuZ3NpbmdlbmlldXINCg0KDQpGb24gKzQ5IDIxNTEgNzgz
MCAzMjQNCkZheCArNDkgMjE1MSA3ODMwIDQ5OQ0Kd3d3LnhjbWctZXJjLmNvbQ0KQ2VsZXN0aW5v
QHhjbWctZXJjLmNvbQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClhDTUcgRXVyb3Bl
YW4gUmVzZWFyY2ggQ2VudGVyIEdtYkgNCkV1cm9wYXJrIEZpY2h0ZW5oYWluIEI0DQo0NzgwNyBL
cmVmZWxkDQpEZXV0c2NobGFuZA0KQW10c2dlcmljaHQgS3JlZmVsZA0KSGFuZGVsc3JlZ2lzdGVy
IEhSQiAxNDMwMg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERyLi1JbmcuIE9saXZlci1DYXJsb3MgR8O2
aGxlciwgRHIuLUluZy4gSHVpIFN1biANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSANCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBicmlhbiBtLiBjYXJsc29uIFttYWlsdG86
c2FuZGFsc0BjcnVzdHl0b290aHBhc3RlLm5ldF0gDQpTZW50OiAyMyBGZWJydWFyeSAyMDE5IDAx
OjI0DQpUbzogQ2VsZXN0aW5vLCBGZWRlcmljbyA8Q2VsZXN0aW5vQHhjbWctZXJjLmNvbT4NCkNj
OiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogLmdpdGlnbm9yZSBhbGxlZ2VkIGJ1
Zw0KDQpPbiBGcmksIEZlYiAyMiwgMjAxOSBhdCAwMzozOTo1M1BNICswMDAwLCBDZWxlc3Rpbm8s
IEZlZGVyaWNvIHdyb3RlOg0KPiBEZWFyIFN1cHBvcnQgVGVhbSwNCj4gDQo+IEkgYW0gZmFjaW5n
IGEgc2VyaW91cyBpc3N1ZSB3aXRoIC5naXRpZ25vcmUgKHNlZSBhdHRhY2htZW50KS4NCj4gDQo+
IFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGZvbGRlciBjb250ZW50cyBvZiAwNCAtIFNvZnR3YXJl
L1NXIENvZGUvU1RNMzIvTGliL0RyaXZlcnMvQ01TSVMvRGV2aWNlLyBhcmUgaWdub3JlZCBiZWNh
dXNlIG9mIGEgc3VzcGVjdGVkIG1pc2ludGVycHJldGF0aW9uIG9mIC5naXRpZ25vcmUuDQo+IA0K
PiBIZXJlIGFyZSBzb21lIHJlc3VsdHMgdGhhdCB5b3UgY291bGQgZmluZCB1c2VmdWw6DQo+IA0K
PiAkIGdpdCBjbGVhbiAtbmRYDQo+IFdvdWxkIHJlbW92ZSAwNCAtIFNvZnR3YXJlL1NXIENvZGUv
U1RNMzIvTGliL0RyaXZlcnMvQ01TSVMvRGV2aWNlLw0KPiANCj4gJCBnaXQgY2hlY2staWdub3Jl
IC12ICIwNCAtIFNvZnR3YXJlL1NXIENvZGUvU1RNMzIvTGliL0RyaXZlcnMvQ01TSVMvRGV2aWNl
LyINCj4gMDQgLSBTb2Z0d2FyZS9TVyBDb2RlL1NUTTMyL0xpYi9Ecml2ZXJzL0NNU0lTLy5naXRp
Z25vcmU6MjpEZXZpY2UgICAgICAgMDQgLSBTb2Z0d2FyZS9TVyBDb2RlL1NUTTMyL0xpYi9Ecml2
ZXJzL0NNU0lTL0RldmljZS8NCj4gDQo+IFNpbmNlIGluIHRoZSBwYXRoIHRoZXJlIGlzIG5vICd+
JyAodGlsZGUpIGNoYXJhY3RlciwgaXQgc2VlbXMgYSBidWcgdG8gbWUuDQoNCkl0IGxvb2tzIGxp
a2UgeW91IGhhdmUgYSAuZ2l0aWdub3JlIGZpbGUgaW4gdGhlICJDTVNJUyIgZGlyZWN0b3J5IHRo
YXQgY29udGFpbnMgdGhlIHN0cmluZyAiRGV2aWNlIiwgd2hpY2ggaXMgd2h5IHRoaXMgZGlyZWN0
b3J5IGlzIGlnbm9yZWQuIElzIHRoYXQgaW5kZWVkIHRoZSBjYXNlPw0KLS0NCmJyaWFuIG0uIGNh
cmxzb246IEhvdXN0b24sIFRleGFzLCBVUw0KT3BlblBHUDogaHR0cHM6Ly9rZXliYXNlLmlvL2Jr
MjIwNA0K
