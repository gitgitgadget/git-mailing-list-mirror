From: XinLingchao <douglarek@outlook.com>
Subject: RE: About *git clone --depth=n* puzzle
Date: Wed, 14 Aug 2013 17:19:36 +0800
Message-ID: <BAY169-W647D5A2BFDC793ADFA5078B4450@phx.gbl>
References: <BAY169-W472B90AB796C71E8D0D038B4450@phx.gbl>,<520B4529.9080304@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"junchunx.guan@gmail.com" <junchunx.guan@gmail.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 11:19:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9XF4-0006du-7A
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 11:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286Ab3HNJTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 05:19:38 -0400
Received: from bay0-omc2-s25.bay0.hotmail.com ([65.54.190.100]:15930 "EHLO
	bay0-omc2-s25.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932279Ab3HNJTg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Aug 2013 05:19:36 -0400
Received: from BAY169-W64 ([65.54.190.123]) by bay0-omc2-s25.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 14 Aug 2013 02:19:36 -0700
X-TMN: [HD4KU823Q2mHy1j4cAkXntqOu8Z/hCFJ]
X-Originating-Email: [douglarek@outlook.com]
Importance: Normal
In-Reply-To: <520B4529.9080304@googlemail.com>
X-OriginalArrivalTime: 14 Aug 2013 09:19:36.0902 (UTC) FILETIME=[65826660:01CE98CF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232276>

LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gRGF0ZTogV2VkLCAxNCBB
dWcgMjAxMyAxMDo1MTo1MyArMDIwMAo+IEZyb206IHN0ZWZhbmJlbGxlckBnb29nbGVtYWlsLmNv
bQo+IFRvOiBkb3VnbGFyZWtAb3V0bG9vay5jb20KPiBDQzogZ2l0QHZnZXIua2VybmVsLm9yZzsg
anVuY2h1bnguZ3VhbkBnbWFpbC5jb20KPiBTdWJqZWN0OiBSZTogQWJvdXQgKmdpdCBjbG9uZSAt
LWRlcHRoPW4qIHB1enpsZQo+Cj4gT24gMDgvMTQvMjAxMyAxMDoyMCBBTSwgWGluTGluZ2NoYW8g
d3JvdGU6Cj4+IEhpIEd1eXMsCj4+Cj4+IEkgdGhpbmsgSSBoYXZlIGdvdCBzb21lIHRyb3VibGUg
d2hlbiBJIHVzZSBgZ2l0IGNsb25lIC0tZGVwdGg9bmAgY29tbWFuZC4gVGFrZSBhIHJlYWwgcmVw
byBmb3IgZXhhbXBsZToKPj4KPj4KPj4gYGdpdCBjbG9uZSBodHRwczovL2dpdGh1Yi5jb20vZG91
Z2xhcmVrL3ZpbXJjLmdpdCAtLWRlcHRoPTFgCj4+Cj4+Cj4+IHRoZW4gSSB1c2UgYGdpdCBsb2dg
Ogo+Pgo+PiBgYGAKPj4gY29tbWl0IGQwNGNhMDllY2M3MjM3MzkxMjNmYWUxMWFkNTY3ODRlYjBj
OWIzNmEKPj4gQXV0aG9yOiBMaW5nY2hhbyBYaW4gPGRvdWdsYXJla0BvdXRsb29rLmNvbT4KPj4g
RGF0ZTogRnJpIEp1biA3IDA5OjM5OjIyIDIwMTMgKzA4MDAKPj4KPj4gVXBkYXRlIHZudWRsZSB0
byBtYXN0ZXIgYnJhbmNoLCBhZGQgd20gc2hvcnRjdXQsIHB5bGludCBvcHRpbWl6YXRpb24KPj4K
Pj4gY29tbWl0IGM2NmQ4MjdkYzIxMmY2YWU4YWFiNmI1YzQ0NjMxNTY0YmNiZTJhY2QKPj4gQXV0
aG9yOiBpY29jb2EgPGxpbmdjaGF4QG91dGxvb2suY29tPgo+PiBEYXRlOiBUdWUgTWFyIDEyIDAx
OjM2OjM0IDIwMTMgLTA3MDAKPj4KPj4gTWVyZ2UgcHVsbCByZXF1ZXN0ICMxIGZyb20gZG91Z2xh
cmVrL21hc3Rlcgo+Pgo+PiBBZGQgbWFya2Rvd24sIGZsYWtlOCwgcHlsaW50IHBsdWdpbgo+Pgo+
PiBgYGAKPj4gYnV0IHdoZW4gSSBjbG9uZSBpdCB3aXRoIGBmaWxlOi8vYDoKPj4KPj4gZ2l0IGNs
b25lIGh0dHBzOi8vZ2l0aHViLmNvbS9kb3VnbGFyZWsvdmltcmMuZ2l0Cj4+IGdpdCBjbG9uZSBm
aWxlOi8vdmltcmMuZ2l0IC0tZGVwdGg9MSB2aW1yYzEKPj4KPj4gSSBnb3QgdGhpcyBsb2c6Cj4+
IGBgYAo+PiBjb21taXQgZDA0Y2EwOWVjYzcyMzczOTEyM2ZhZTExYWQ1Njc4NGViMGM5YjM2YQo+
PiBBdXRob3I6IExpbmdjaGFvIFhpbiA8ZG91Z2xhcmVrQG91dGxvb2suY29tPgo+PiBEYXRlOiBG
cmkgSnVuIDcgMDk6Mzk6MjIgMjAxMyArMDgwMAo+Pgo+PiBVcGRhdGUgdm51ZGxlIHRvIG1hc3Rl
ciBicmFuY2gsIGFkZCB3bSBzaG9ydGN1dCwgcHlsaW50IG9wdGltaXphdGlvbgo+PiBgYGAKPj4K
Pj4gc28gdGhlIHR3byByZXN1bHRzIGFyZSBub3Qgc2FtZSwgaXMgaXQgYSBidWc/IG9yIGl0IHNo
b3VsZCBiZSBzbz8KPj4KPj4gTXkgb3MgaXMgb3BlblNVU0UgMTIuMyBhbmQgZ2l0IHZlcnNpb24g
MS44LjMuNDsgYW5kIG15YWJlIGl0IG9jY3VyZWQgaW4gZ2l0IDEuOC4xLjQgKy4KPj4KPj4KPj4g
VGhhbmtzIGFuZCBCZXN0IHJlZ2FyZHMKPj4KPj4gTGluZ2NoYW8gWGluIC0tCj4KPiBUaGVyZSB3
YXMgYSBzaW1pbGFyIGRpc2N1c3Npb24gZ29pbmcgb24gaW4gSnVseSB0aGlzIHllYXIsCj4gbWF5
YmUgdGhpcyBpcyBhbiBpbnRlcmVzdGluZyByZWFkIHdpdGggcmVzcGVjdCB0byB0aGlzIHRvcGlj
Cj4gaHR0cDovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9naXQvbXNnMTk2MTM4Lmh0bWwKPgo+IFN0
ZWZhbgo+Cj4KClN0ZWZhbiwgSSBkbyBOT1QgdGhpbmsgc28sIHRoZSBrZXkgcG9pbnQgaXMgbm90
IGFib3V0IHRoZSBkZXB0aCBsaW1pdCwgaXQgaXMgYWJvdXQgd2hldGhlciByZW1vdGUgY2xvbmUg
ZGVwdGggZXF1YWxzIGxvY2FsIGNsb25lIGRlcHRoLgoKY2hlZXJzCgpMaW5nY2hhbyBYaW4gCQkg
CSAgIAkJICA=
