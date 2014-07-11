From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 18:11:08 +0000
Message-ID: <1405102267.22963.35.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
	 <1405099447-27555-3-git-send-email-jacob.e.keller@intel.com>
	 <20140711174628.GC7856@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "peff@peff.net" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:11:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5fHx-0000zf-V4
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 20:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbaGKSLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 14:11:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:33023 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754927AbaGKSLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 14:11:09 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 11 Jul 2014 11:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,644,1400050800"; 
   d="scan'208";a="560618743"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2014 11:11:08 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Fri, 11 Jul 2014 11:11:08 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.86]) with mapi id 14.03.0123.003;
 Fri, 11 Jul 2014 11:11:08 -0700
Thread-Topic: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Thread-Index: AQHPnSzwtKQEouEPQUqhaN0T4H7NY5ubmxQAgAAG44A=
In-Reply-To: <20140711174628.GC7856@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <29967747F2EDA2489D730928657B6186@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253307>

T24gRnJpLCAyMDE0LTA3LTExIGF0IDEzOjQ2IC0wNDAwLCBKZWZmIEtpbmcgd3JvdGU6DQo+IE9u
IEZyaSwgSnVsIDExLCAyMDE0IGF0IDEwOjI0OjA3QU0gLTA3MDAsIEphY29iIEtlbGxlciB3cm90
ZToNCj4gDQo+ID4gVXBkYXRlZCB0byBpbmNsdWRlIGNoYW5nZXMgZHVlIHRvIEp1bmlvJ3MgZmVl
ZGJhY2suIFRoaXMgaGFzIG5vdCByZXNvbHZlZA0KPiA+IHdoZXRoZXIgd2Ugc2hvdWxkIGZhaWwg
b24gYSBjb25maWd1cmF0aW9uIGVycm9yIG9yIHNpbXBseSB3YXJuLiBJdCBhcHBlYXJzIHRoYXQN
Cj4gPiB3ZSBhY3R1YWxseSBzZWVtIHRvIGVycm9yIG91dCBtb3JlIHRoYW4gd2Fybiwgc28gSSBh
bSB1bnN1cmUgd2hhdCB0aGUgY29ycmVjdA0KPiA+IGFjdGlvbiBpcyBoZXJlLg0KPiANCj4gWWVh
aCwgd2UncmUgcXVpdGUgaW5jb25zaXN0ZW50IHRoZXJlLiBJbiBzb21lIGNhc2VzIHdlIHNpbGVu
dGx5IGlnbm9yZQ0KPiBzb21ldGhpbmcgdW5rbm93biAoZS5nLiwgYSBjb2xvci5kaWZmLiogc2xv
dCB0aGF0IHdlIGRvIG5vdCB1bmRlcnN0YW5kKSwNCj4gYnV0IGluIG1vc3QgY2FzZXMgaWYgaXQg
aXMgYSBjb25maWcga2V5IHdlIHVuZGVyc3RhbmQgYnV0IGEgdmFsdWUgd2UgZG8NCj4gbm90LCB3
ZSBjb21wbGFpbiBhbmQgZGllLg0KPiANCj4gSXQncyBwcm9iYWJseSB1c2VyLXVuZnJpZW5kbHkg
dG8gYmUgc2lsZW50IGZvciB0aG9zZSBjYXNlcywgdGhvdWdoLiBUaGUNCj4gdXNlciBnZXRzIG5v
IGZlZWRiYWNrIG9uIHdoeSB0aGVpciBjb25maWcgdmFsdWUgaXMgZG9pbmcgbm90aGluZy4NCj4g
DQo+IEkgdGVuZCB0byB0aGluayB0aGF0IHdhcm5pbmcgaXMgbm90IG11Y2ggYmV0dGVyIHRoYW4g
ZXJyb3Jpbmcgb3V0LiBJdCBpcw0KPiBoZWxwZnVsIGlmIHlvdSBhcmUgcnVubmluZyBhIHNpbmds
ZS1zaG90IG9mIGFuIG9sZCB2ZXJzaW9uICh3aGljaCBpcw0KPiBzb21ldGhpbmcgdGhhdCBJIGRv
IGEgbG90IHdoZW4gdGVzdGluZyBvbGQgdmVyc2lvbnMpLCBidXQgd291bGQgcXVpY2tseQ0KPiBi
ZWNvbWUgaXJyaXRhdGluZyBpZiB5b3Ugd2VyZSBhY3R1YWxseSB1c2luZyBhbiBvbGQgdmVyc2lv
biBvZiBnaXQNCj4gZGF5LXRvLWRheS4NCj4gDQo+IEkgZHVubm8uIE1heWJlIGl0IGlzIHdvcnRo
IG1ha2luZyBsaWZlIGVhc2llciBmb3IgcGVvcGxlIGluIHRoZSBmb3JtZXINCj4gY2F0ZWdvcnku
DQo+IA0KPiA+ICtzdGF0aWMgaW50IHBhcnNlX3NvcnRfc3RyaW5nKGNvbnN0IGNoYXIgKmFyZywg
aW50ICpzb3J0KQ0KPiA+ICt7DQo+ID4gKwlpbnQgdHlwZSA9IDAsIGZsYWdzID0gMDsNCj4gPiAr
DQo+ID4gKwlpZiAoc2tpcF9wcmVmaXgoYXJnLCAiLSIsICZhcmcpKQ0KPiA+ICsJCWZsYWdzIHw9
IFJFVkVSU0VfU09SVDsNCj4gPiArDQo+ID4gKwlpZiAoc2tpcF9wcmVmaXgoYXJnLCAidmVyc2lv
bjoiLCAmYXJnKSB8fCBza2lwX3ByZWZpeChhcmcsICJ2OiIsICZhcmcpKQ0KPiA+ICsJCXR5cGUg
PSBWRVJDTVBfU09SVDsNCj4gPiArCWVsc2UNCj4gPiArCQl0eXBlID0gU1RSQ01QX1NPUlQ7DQo+
ID4gKw0KPiA+ICsJaWYgKHN0cmNtcChhcmcsICJyZWZuYW1lIikpDQo+ID4gKwkJcmV0dXJuIGVy
cm9yKF8oInVuc3VwcG9ydGVkIHNvcnQgc3BlY2lmaWNhdGlvbiAlcyIpLCBhcmcpOw0KPiA+ICsN
Cj4gPiArCSpzb3J0ID0gKHR5cGUgfCBmbGFncyk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+
ID4gK30NCj4gDQo+IFJlZ2FyZGxlc3Mgb2YgaG93IHdlIGhhbmRsZSB0aGUgZXJyb3IsIEkgdGhp
bmsgdGhpcyB2ZXJzaW9uIHRoYXQNCj4gYXNzZW1ibGVzIHRoZSBmaW5hbCBiaXRmaWVsZCBhdCB0
aGUgZW5kIGlzIGVhc2llciB0byByZWFkIHRoYW4gdGhlDQo+IG9yaWdpbmFsLg0KPiANCg0KWWVz
LCBJIGZpZ3VyZWQgc2V0dGluZyBpdCB1cCBhbGwgYXQgdGhlIGVuZCBtYWtlcyBtb3JlIHNlbnNl
LCBhbmQgaXMNCmxlc3MgcHJvbmUgdG8gc3VidGxlIGJ1Z3MsIHNpbmNlIHdlIGRvbid0IGRpcmVj
dGx5IG1vZGlmeSBzb3J0IHVzaW5nIHw9DQpvciByZWx5aW5nIG9uIHBhcnRpY3VsYXIgdmFsdWVz
IG9mIHNvcnQgaW5pdGlhbGx5Lg0KDQpJIHBlcnNvbmFsbHkgcHJlZmVyIGVycm9yIG91dCBvbiBv
cHRpb25zLCBldmVuIHRob3VnaCBpdCBjYW4gbWFrZSBpdCBhDQpiaXQgbW9yZSBkaWZmaWN1bHQs
IHRob3VnaCBhcyBmYXIgYXMgSSBrbm93IHVua25vd24gZmllbGRzIHNpbXBseSB3YXJuDQpvciBh
cmUgaWdub3JlZC4gKGllOiBvbGQgdmVyc2lvbnMgb2YgZ2l0IGp1c3QgaWdub3JlIHVua25vd24g
ZmllbGRzIGluDQpjb25maWd1cmF0aW9uKS4NCg0KSXQncyBwb3NzaWJsZSB3ZSBzaG91bGQgd2Fy
biBpbnN0ZWFkIHRob3VnaCwgc28gdGhhdCBvbGRlciBnaXRzIHdvcmsNCndpdGggbmV3IHNvcnRz
IHRoYXQgdGhleSBkb24ndCB1bmRlcnN0YW5kLg0KDQpJIGFtIG9rIHdpdGggd2FybmluZyBidXQg
SSBkb24ndCBrbm93IHRoZSBiZXN0IHByYWN0aWNlIGZvciBob3cgdG8gd2Fybg0KaGVyZSBpbnN0
ZWFkIG9mIGZhaWxpbmcuIFJldHVybmluZyBlcnJvciBjYXVzZXMgYSBmYXRhbCAiYmFkIGNvbmZp
ZyINCm1lc3NhZ2UuIEFueSB0aG91Z2h0cz8NCg0KVGhhbmtzLA0KSmFrZQ0KDQo+IC1QZWZmDQo+
IC0tDQo+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5lICJ1bnN1
YnNjcmliZSBnaXQiIGluDQo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdl
ci5rZXJuZWwub3JnDQo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2VyLmtlcm5l
bC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0KDQoNCg==
