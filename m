From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH 1/9] git-compat-util.h: Add missing semicolon after
 struct itimerval
Date: Wed, 3 Sep 2014 00:17:03 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5857255DDC@ORSMSX115.amr.corp.intel.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
	<1409330916.18778.17.camel@jekeller-desk1.amr.corp.intel.com>
	<5400CC7C.4010706@Maxsi.org> <xmqqlhq75d2y.fsf@gitster.dls.corp.google.com>
 <5400D7E5.8090606@Maxsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonas 'Sortie' Termansen <Sortie@Maxsi.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 02:17:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOyGT-00070Q-WD
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 02:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbaICAR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 20:17:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:38726 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754408AbaICAR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 20:17:27 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 02 Sep 2014 17:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,453,1406617200"; 
   d="scan'208";a="585372303"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2014 17:17:25 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Tue, 2 Sep 2014 17:17:04 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX111.amr.corp.intel.com ([169.254.11.75]) with mapi id 14.03.0195.001;
 Tue, 2 Sep 2014 17:17:03 -0700
Thread-Topic: [PATCH 1/9] git-compat-util.h: Add missing semicolon after
 struct itimerval
Thread-Index: AQHPw7yGriieMpZGL065ZKapuehL6ZvocOeAgAYgKMA=
In-Reply-To: <5400D7E5.8090606@Maxsi.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256374>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBnaXQtb3duZXJAdmdlci5rZXJu
ZWwub3JnIFttYWlsdG86Z2l0LW93bmVyQHZnZXIua2VybmVsLm9yZ10gT24NCj4gQmVoYWxmIE9m
IEpvbmFzICdTb3J0aWUnIFRlcm1hbnNlbg0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAyOSwgMjAx
NCAxMjo0NCBQTQ0KPiBUbzogSnVuaW8gQyBIYW1hbm8NCj4gQ2M6IGdpdEB2Z2VyLmtlcm5lbC5v
cmc7IEtlbGxlciwgSmFjb2IgRTsgSm9oYW5uZXMgU2l4dA0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvOV0gZ2l0LWNvbXBhdC11dGlsLmg6IEFkZCBtaXNzaW5nIHNlbWljb2xvbiBhZnRlcg0KPiBz
dHJ1Y3QgaXRpbWVydmFsDQo+IA0KPiBPbiAwOC8yOS8yMDE0IDA5OjA3IFBNLCBKdW5pbyBDIEhh
bWFubyB3cm90ZToNCj4gPiBKb25hcyAnU29ydGllJyBUZXJtYW5zZW4gPFNvcnRpZUBNYXhzaS5v
cmc+IHdyaXRlczoNCj4gPiBUaGF0IGlzIGVhc3kgdG8gZml4LCBpc24ndCBpdD8NCj4gPg0KPiA+
IFdoZXJlIHlvdSBzYWlkICJJZiB5b3UgaGF2ZSB0aW1lcl9zZXR0aW1lcigpLCBzZXQgdGhpcyBt
YWtlZmlsZQ0KPiA+IHZhcmlhYmxlIiwgeW91IHN0YXJ0IHRoZSBzZW50ZW5jZSB3aXRoICJJZiB5
b3UgaGF2ZSBhIHdvcmtpbmcNCj4gPiB0aW1lcl9zZXR0aW1lcigpIiBpbnN0ZWFkLg0KPiANCj4g
VGhhdCdzIG1vc3RseSByaWdodC4gSSBjYXJlIGFib3V0IGNyb3NzLWNvbXBpbGF0aW9uLCBzbyB0
aGF0IGlzIGFsc28NCj4gc29tZXRoaW5nIHRvIGtlZXAgaW4gbWluZC4gSXQgd291bGQgYmUgYmVz
dCBpZiB0aGlzIGNvdWxkIGJlDQo+IGF1dG9tYXRpY2FsbHkgYW5kIHJvYnVzdGx5IGRldGVybWlu
ZWQgKGV2ZW4gd2hlbiBjcm9zcy1jb21waWxpbmcpLA0KPiByYXRoZXIgdGhhbiByZWx5aW5nIG9u
IHRoZSB1c2VyIHNldHRpbmcgbWFnaWMgbWFrZSB2YXJpYWJsZXMuDQo+IA0KPiBKb25hcw0KDQpD
b3VsZG4ndCB0aGlzIGJlIHNvbHZlZCBieSBtYWtpbmcgb3VyIGNvbmZpZ3VyZSBzY3JpcHQgc21h
cnQgZW5vdWdoIHRvIHRlbGwgd2hlbiBpdCdzIGF0IGxlYXN0IHRoZSAia25vd24iIGJyb2tlbiBP
cGVuQlNEIGltcGxlbWVudGF0aW9uPw0KDQpSZWdhcmRzLA0KSmFrZQ0KDQo=
