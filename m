From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: revert top most commit
Date: Wed, 27 Aug 2014 22:43:21 +0000
Message-ID: <1409179401.2715.17.camel@jekeller-desk1.amr.corp.intel.com>
References: <1409174048.2715.12.camel@jekeller-desk1.amr.corp.intel.com>
	 <1409177738.15185.5.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "dturner@twopensource.com" <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:43:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMlwY-0004WY-UJ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 00:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936042AbaH0Wnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 18:43:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:22532 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932305AbaH0Wnu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 18:43:50 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 27 Aug 2014 15:43:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,414,1406617200"; 
   d="scan'208";a="564425681"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2014 15:43:22 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX102.amr.corp.intel.com ([169.254.1.108]) with mapi id 14.03.0195.001;
 Wed, 27 Aug 2014 15:43:22 -0700
Thread-Topic: revert top most commit
Thread-Index: AQHPwjvXn7vjc5sAL0S8XcDibdoVSZvleb0AgAAHvoA=
In-Reply-To: <1409177738.15185.5.camel@leckie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <79588F6DBA538F458CC4681A3150FF7B@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256057>

T24gV2VkLCAyMDE0LTA4LTI3IGF0IDE4OjE1IC0wNDAwLCBEYXZpZCBUdXJuZXIgd3JvdGU6DQo+
IE9uIFdlZCwgMjAxNC0wOC0yNyBhdCAyMToxNCArMDAwMCwgS2VsbGVyLCBKYWNvYiBFIHdyb3Rl
Og0KPiA+IEhpLA0KPiA+IA0KPiA+IEkgYW0gaGF2aW5nIHRyb3VibGUgdXNpbmcgcmV2ZXJ0LiBJ
ZiBJIGF0dGVtcHQgdG8NCj4gPiANCj4gPiAkIGdpdCByZXZlcnQgPHNoYTFpZD4NCj4gPiANCj4g
PiB3aGVyZSBzaGExaWQgaXMgdGhlIHNhbWUgYXMgdGhlIEhFQUQgY29tbWl0LCBJIGluc3RlYWQg
Z2V0IHRoZSBvdXRwdXQgb2YNCj4gPiB3aGF0IGxvb2tzIGxpa2UgZ2l0IHN0YXR1cy4NCj4gPiAN
Cj4gPiBJcyB0aGVyZSBhbnl0aGluZyBzcGVjaWZpYyBhYm91dCBnaXQgcmV2ZXJ0IHRoYXQgcHJl
dmVudHMgaXQgZnJvbQ0KPiA+IHJldmVydGluZyB0aGUgbW9zdCByZWNlbnQgY29tbWl0Pw0KPiAN
Cj4gV29ya3MgZm9yIG1lLiAgV2hhdCB2ZXJzaW9uIG9mIGdpdD8gIElzIHRoZXJlIGEgcHVibGlj
IHJlcG8gdGhhdCBzb21lb25lDQo+IGNvdWxkIHRlc3QgdGhpcyBvdXQgb24/DQo+IA0KDQpJdCB3
YXMgdmVyc2lvbiAxLjkuMyBhbmQgaXQncyBub3QgYSBwdWJsaWMgcmVwby4NCg0KSXQncyBhY3R1
YWxseSBub3QgbXkgcmVwb3NpdG9yeSwgSSB3YXMgaGVscGluZyBhIGNvLXdvcmtlciwgYW5kIHRo
b3VnaHQNCkknZCBhc2sgaWYgYW55b25lIGhlcmUga25ldyBpZiBpdCB3YXMgZXhwZWN0ZWQgYmVo
YXZpb3Igb3Igbm90Lg0KDQpUaGFua3MsDQpKYWtlDQo=
