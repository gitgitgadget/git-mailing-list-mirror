From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Wed, 3 Sep 2014 19:30:19 +0000
Message-ID: <1409772619.28694.0.camel@jekeller-desk1.amr.corp.intel.com>
References: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com>
	 <5406B4EF.3050301@kdbg.org> <xmqqoauwy0lz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "j6t@kdbg.org" <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sortie@maxsi.org" <sortie@maxsi.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:30:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPGGX-0001jh-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 21:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbaICTap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 15:30:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:15925 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbaICTap (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 15:30:45 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 03 Sep 2014 12:22:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="381004857"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2014 12:25:41 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Wed, 3 Sep 2014 12:30:19 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.134]) with mapi id 14.03.0195.001;
 Wed, 3 Sep 2014 12:30:19 -0700
Thread-Topic: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Thread-Index: AQHPx6vGORjwMWaStEWPG63YsbufpZvwQP+A
In-Reply-To: <xmqqoauwy0lz.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <C65211420721194A8DC08841611DD337@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256406>

T24gV2VkLCAyMDE0LTA5LTAzIGF0IDEyOjE4IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSm9oYW5uZXMgU2l4dCA8ajZ0QGtkYmcub3JnPiB3cml0ZXM6DQo+IA0KPiA+IEJ1dCBJTUhP
LCB0aGlzIHRvcGljIGdvZXMgaW4gYSB3cm9uZyBkaXJlY3Rpb24uICJBdm9pZCBkZXByZWNhdGVk
DQo+ID4gaW50ZXJmYWNlcyIgaXMgd2F5IG92ZXJyYXRlZC4gSXQgd291bGQgYmUgcHJlZmVyYWJs
ZSAoSU1ITykgdG8gaW1wbGVtZW50DQo+ID4gc2V0aXRpbWVyKCkgaW4gY29tcGF0LyBmb3Igc3lz
dGVtcyB0aGF0IGRvbid0IGhhdmUgaXQuDQo+IA0KPiBJIHRoaW5rIEkgYWdyZWUuDQo+IA0KPiBB
ZGRpbmcgY29tcGF0L3NldGl0aW1lci5jIHRoYXQgaW1wbGVtZW50cyBnaXRfc2V0aXRpbWVyKCkg
aW4gdGVybXMNCj4gb2Ygd2hhdGV2ZXIgaXMgYXZhaWxhYmxlIG9uIHRoZSBwbGF0Zm9ybSBhbmQg
I2RlZmluZSBjYWxscyB0bw0KPiBzZXRpdGltZXIoKSBhd2F5IHRvIGdpdF9zZXRpdGltZXIoKSB3
b3VsZCBiZSBhIGxvdCBsZXNzIGludHJ1c2l2ZQ0KPiBjaGFuZ2UgdGhhbiB0aGUgc2VyaWVzIHBv
c3RlZC4NCj4gDQo+IFRoYW5rcy4NCj4gLS0NCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxp
c3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJlIGdpdCIgaW4NCj4gdGhlIGJvZHkgb2YgYSBt
ZXNzYWdlIHRvIG1ham9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcNCj4gTW9yZSBtYWpvcmRvbW8gaW5m
byBhdCAgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1sDQoNCkkgc3Vw
cG9zZSBvdmVyYWxsIHRoaXMgbWFrZXMgbW9yZSBzZW5zZSA6KSBUaGF0IHNob3VsZG4ndCBiZSBk
aWZmaWN1bHQNCnRvIGRvLg0KDQpSZWdhcmRzLA0KSmFrZQ0K
