From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 2/2 v4] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 17:20:18 +0000
Message-ID: <1405099217.22963.11.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405036334-8093-1-git-send-email-jacob.e.keller@intel.com>
	 <1405036334-8093-2-git-send-email-jacob.e.keller@intel.com>
	 <xmqqion4543l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 19:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5eUj-0007Lm-Pv
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 19:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbaGKRUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 13:20:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:18100 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbaGKRUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 13:20:21 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 11 Jul 2014 10:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,644,1400050800"; 
   d="scan'208";a="542124311"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga001.jf.intel.com with ESMTP; 11 Jul 2014 10:20:18 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX110.amr.corp.intel.com ([169.254.3.171]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 10:20:17 -0700
Thread-Topic: [PATCH 2/2 v4] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPnRlqSWWDJi5WWEKYCjRA7Q2n5Zubk+qA
In-Reply-To: <xmqqion4543l.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <A532D31D1A793D438E61F9403623E703@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253295>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDA4OjA0IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQoN
Cj4gPiArDQo+ID4gKwlpZiAoc3RyY21wKGFyZywgInJlZm5hbWUiKSkNCj4gPiArCQlkaWUoXygi
dW5zdXBwb3J0ZWQgc29ydCBzcGVjaWZpY2F0aW9uICVzIiksIGFyZyk7DQo+IA0KPiBIbW0uICBJ
IF90aG91Z2h0XyB3ZSB0cnkgdG8gY2F0Y2ggdW5zdXBwb3J0ZWQgb3B0aW9uIHZhbHVlIGNvbWlu
Zw0KPiBmcm9tIHRoZSBjb21tYW5kIGxpbmUgYW5kIGRpZSBidXQgYXQgdGhlIHNhbWUgdGltZSB3
ZSB0cnkgKm5vdCogdG8NCj4gZGllIGJ1dCB3YXJuIGFuZCB3aGF0ZXZlciBpcyBzZW5zaWJsZSB3
aGVuIHRoZSB2YWx1ZSBjb21lcyBmcm9tIHRoZQ0KPiBjb25maWd1cmF0aW9uLCBzbyB0aGF0IC5n
aXQvY29uZmlnIG9yICRIT01FLy5naXRjb25maWcgY2FuIGJlIHNoYXJlZA0KPiBieSB0aG9zZSB3
aG8gdXNlIGRpZmZlcmVudCB2ZXJzaW9ucyBvZiBHaXQuDQo+IA0KPiBEbyB3ZSBhbHJlYWR5IGhh
dmUgbWFueSBwcmVjZWRlbmNlcyB3aGVyZSB3ZSBzZWUgY29uZmlndXJhdGlvbiB2YWx1ZQ0KPiB0
aGF0IG91ciB2ZXJzaW9uIG9mIEdpdCBkbyBub3QgeWV0IHVuZGVyc3RhbmQ/DQo+IA0KPiBOb3Qg
YSB2ZXJ5IHN0cm9uZyBvYmplY3Rpb247IGp1c3Qgc29tZXRoaW5nIHRoYXQgd29ycmllcyBtZS4N
Cg0KQmFzZWQgb24gYSBjdXJzb3J5IGdsYW5jZSBhdCBob3cgdGhlIGNvbmZpZyBpcyBwYXJzZWQs
IHdlIGFjdHVhbGx5DQpkaWVfb25fZXJyb3IgZm9yIG1vc3Qgb3B0aW9ucy4gRG9lcyBpdCBtYWtl
cyBzZW5zZSB0byB3YXJuIG9yIG5vdD8gSSBhbQ0Kbm90IHJlYWxseSBzdXJlIGhlcmUuLiBBdCBh
bnkgcmF0ZSBJIHVwZGF0ZWQgdGhpcyB0byBiZSBhIGJpdCBjbGVhbmVyDQphbmQgdXNlIGVycm9y
KCBpbnN0ZWFkIG9mIGRpZSwgc28gdGhhdCBpdCB3aWxsIHdvcmsgd2l0aGluIGhvdyBjb25maWcg
aXMNCnN1cHBvc2VkIHRvLi4gUGx1cywgdGhpcyBhbHNvIG1ha2VzIGl0IHNvIHRoYXQgLS1zb3J0
IHNob3dzIHRoZSB1c2FnZSBpZg0KaXQncyBpbnZhbGlkLg0KDQpQbGVhc2UgY29tbWVudCBtb3Jl
IG9uIHRoZSBuZXcgc2V0IEkgYW0gc2VuZGluZyBzbyB3ZSBjYW4gcmVhbGx5DQpkZXRlcm1pbmUg
d2hhdCB0aGUgY29ycmVjdCBjb3Vyc2Ugb2YgYWN0aW9uIGlzIGhlcmUuDQoNClJlZ2FyZHMsDQpK
YWtlDQo=
