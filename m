From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: revert top most commit
Date: Thu, 28 Aug 2014 20:27:06 +0000
Message-ID: <1409257626.25998.7.camel@jekeller-desk1.amr.corp.intel.com>
References: <1409174048.2715.12.camel@jekeller-desk1.amr.corp.intel.com>
	 <1409177738.15185.5.camel@leckie>
	 <1409179401.2715.17.camel@jekeller-desk1.amr.corp.intel.com>
	 <20140828002243.GA20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "dturner@twopensource.com" <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "jrnieder@gmail.com" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:27:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN6Hr-0000f7-EJ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 22:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbaH1U1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 16:27:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:23553 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbaH1U1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 16:27:11 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 28 Aug 2014 13:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,420,1406617200"; 
   d="scan'208";a="583081382"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2014 13:27:09 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Thu, 28 Aug 2014 13:27:07 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.34]) with mapi id 14.03.0195.001;
 Thu, 28 Aug 2014 13:27:06 -0700
Thread-Topic: revert top most commit
Thread-Index: AQHPwjvXn7vjc5sAL0S8XcDibdoVSZvleb0AgAAHvoCAABvEgIABUIAA
In-Reply-To: <20140828002243.GA20185@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <5A88B33525DDB349A8D948EEE6226E92@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256121>

T24gV2VkLCAyMDE0LTA4LTI3IGF0IDE3OjIyIC0wNzAwLCBKb25hdGhhbiBOaWVkZXIgd3JvdGU6
DQo+IEtlbGxlciwgSmFjb2IgRSB3cm90ZToNCj4gPj4gT24gV2VkLCAyMDE0LTA4LTI3IGF0IDIx
OjE0ICswMDAwLCBLZWxsZXIsIEphY29iIEUgd3JvdGU6DQo+IA0KPiA+Pj4gSSBhbSBoYXZpbmcg
dHJvdWJsZSB1c2luZyByZXZlcnQuIElmIEkgYXR0ZW1wdCB0bw0KPiA+Pj4NCj4gPj4+ICQgZ2l0
IHJldmVydCA8c2hhMWlkPg0KPiA+Pj4NCj4gPj4+IHdoZXJlIHNoYTFpZCBpcyB0aGUgc2FtZSBh
cyB0aGUgSEVBRCBjb21taXQsIEkgaW5zdGVhZCBnZXQgdGhlIG91dHB1dCBvZg0KPiA+Pj4gd2hh
dCBsb29rcyBsaWtlIGdpdCBzdGF0dXMuDQo+IFsuLi5dDQo+ID4gSXQncyBhY3R1YWxseSBub3Qg
bXkgcmVwb3NpdG9yeSwgSSB3YXMgaGVscGluZyBhIGNvLXdvcmtlciwgYW5kIHRob3VnaHQNCj4g
PiBJJ2QgYXNrIGlmIGFueW9uZSBoZXJlIGtuZXcgaWYgaXQgd2FzIGV4cGVjdGVkIGJlaGF2aW9y
IG9yIG5vdC4NCj4gDQo+IE1vcmUgZGV0YWlscyBhYm91dCB0aGUgb3V0cHV0IHdvdWxkIGhlbHAg
LS0tIG90aGVyd2lzZSBwZW9wbGUgaGF2ZSB0bw0KPiBndWVzc1sqXS4gIEknbSBndWVzc2luZyB5
b3VyIGNvLXdvcmtlcidzIHdvcmtpbmcgdHJlZSBpcyBub3QgY2xlYW4uDQo+IENvbW1pdGluZyBv
ciBzdGFzaGluZyB0aGVpciBjaGFuZ2VzIGZpcnN0IG1pZ2h0IGdldCB0aGluZ3Mgd29ya2luZy4N
Cj4gDQo+IEhvcGUgdGhhdCBoZWxwcywNCj4gSm9uYXRoYW4NCj4gDQo+IFsqXSBBbm90aGVyIG5p
Y2UgdGhpbmcgYWJvdXQgcXVvdGluZyBvdXRwdXQgaXMgdGhhdCBpdCBiZWNvbWVzIG1vcmUNCj4g
b2J2aW91cyB3aGF0IGFib3V0IGl0IHdhc24ndCBoZWxwZnVsLCB3aGljaCBzb21ldGltZXMgbGVh
ZHMgdG8gcGF0Y2hlcw0KPiBmcm9tIGtpbmQgcGVvcGxlIG9uIHRoZSBsaXN0IHRvIGZpeCBpdC4N
Cj4gLS0NCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVu
c3Vic2NyaWJlIGdpdCIgaW4NCj4gdGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1ham9yZG9tb0B2
Z2VyLmtlcm5lbC5vcmcNCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3ZnZXIua2Vy
bmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sDQoNCiMgQ29tbWFuZCwgd2hlcmUgIA0KJGdpdCBy
ZXZlcnQgYjcxOGM0ZDUwODIwNGI3ZjQ2YjE0N2M3YzQ3YzUxZmU3YTJjN2UzMU9uDQoNCiMgT3V0
cHV0DQpicmFuY2ggbWFzdGVyDQpZb3VyIGJyYW5jaCBpcyB1cC10by1kYXRlIHdpdGggJ29yaWdp
bi9tYXN0ZXInLg0Kbm90aGluZyB0byBjb21taXQsIHdvcmtpbmcgZGlyZWN0b3J5IGNsZWFuDQoN
CkkgYWxzbyBqdXN0IGdvdCBvbmUga2V5IHBpZWNlIG9mIGluZm9ybWF0aW9uIHJlZ2FyZGluZyB0
aGlzLCB0aGUgcGF0Y2gNCml0c2VsZiB3YXMgYmxhbmshDQoNCkZvciBiYWNrc3RvcnksIHRoZSBp
c3N1ZSBpcyB0aGF0IGhlIHB1c2hlZCB0byBhIHRyZWUgd2hpY2ggZG9lcyBub3QNCmFsbG93IG5v
bi1mYXN0Zm9yd2FyZCB1cGRhdGVzIChzbyBoZSBjYW4ndCByZXdpbmQpLiBIZSB3YXMgdXNpbmcg
c3RhY2tlZA0KZ2l0LCBhbmQgYWNjaWRlbnRhbGx5IHB1c2hlZCBhbiBlbXB0eSBwYXRjaCwgYW5k
IHdhbnRlZCB0byByZXZlcnQgaXQgc28NCnRoYXQgYXQgbGVhc3QgdGhlIGxvZyBzaG93ZWQgdGhh
dCB3ZSBoYWQgcmVtb3ZlZCBpdCAoZXZlbiB0aG91Z2ggdGhlDQpwYXRjaCBpdHNlbGYgd2FzIGVt
cHR5KS4NCg0KQXQgbWluaW11bSwgdGhpcyBvdXRwdXQgZnJvbSBnaXQgcmV2ZXJ0IGNvdWxkIGJl
IG1hZGUgbW9yZSBjbGVhciBhYm91dA0Kd2h5IGl0J3MgZmFpbGluZyBvbiBhbiBlbXB0eSBwYXRj
aC4NCg0KUmVnYXJkcywNCkpha2UNCg==
