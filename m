From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH 1/9] git-compat-util.h: Add missing semicolon after
 struct itimerval
Date: Fri, 29 Aug 2014 16:48:36 +0000
Message-ID: <1409330916.18778.17.camel@jekeller-desk1.amr.corp.intel.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "sortie@maxsi.org" <sortie@maxsi.org>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 18:49:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPMD-0003xg-9y
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbaH2Qs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:48:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:62198 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509AbaH2Qs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:48:56 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 29 Aug 2014 09:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,425,1406617200"; 
   d="scan'208";a="591782527"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2014 09:48:37 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Fri, 29 Aug 2014 09:48:36 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX158.amr.corp.intel.com ([10.22.240.20]) with mapi id 14.03.0195.001;
 Fri, 29 Aug 2014 09:48:36 -0700
Thread-Topic: [PATCH 1/9] git-compat-util.h: Add missing semicolon after
 struct itimerval
Thread-Index: AQHPw6h3riieMpZGL065ZKapuehL6ZvoQC4A
In-Reply-To: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <A484512ECBAC144EA6529AEE11A40A47@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256163>

T24gRnJpLCAyMDE0LTA4LTI5IGF0IDA5OjQyIC0wNzAwLCBKYWNvYiBLZWxsZXIgd3JvdGU6DQo+
IEZyb206IEpvbmFzICdTb3J0aWUnIFRlcm1hbnNlbiA8c29ydGllQG1heHNpLm9yZz4NCj4gDQo+
IFRoaXMgaGFzbid0IGJlZW4gYSBwcm9ibGVtIGluIHByYWN0aWNlIGFzIGFsbW9zdCBhbGwgc3lz
dGVtcyBoYXZlIHRoZQ0KPiBzZXRpdGltZXIoKSBBUEkgKG9yIGl0IGlzIHByb3ZpZGVkIGJ5IGdp
dCBpbiB0aGUgY2FzZSBvZiBtaW5ndykuIFRoaXMgY29kZQ0KPiB3YXNuJ3QgdXNlZCBpbiBhbnkg
ZGVmYXVsdCBjaXJjdW1zdGFuY2VzLCBhcyB0aGUgYnVpbGQgc3lzdGVtIG5ldmVyIHNldHMNCj4g
Tk9fU1RSVUNUX0lUSU1FUlZBTCAtIHRoaXMgYnJlYWthZ2Ugb25seSBvY2N1cmVkIGlmIHRoZSB1
c2VyIGFza2VkIGZvciBpdC4NCj4gDQo+IFdlIHJlcGFpciB0aGlzIGNhc2Ugc28gd2UgY2FuIHJl
bHkgb24gaXQgaW4gdGhlIGZvbGxvd2luZyBjb21taXRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Sm9uYXMgJ1NvcnRpZScgVGVybWFuc2VuIDxzb3J0aWVAbWF4c2kub3JnPg0KPiAtLS0NCg0KSSBm
aXhlZCB1cCBKb25hcycgc2VyaWVzIGFuZCB0cmllZCB0byByZXNvbHZlIHRoZSBpc3N1ZXMgSSBm
b3VuZCBhcyB3ZWxsDQphcyByZS1vcmRlcmVkIHRoZSBwYXRjaGVzIHNvIHRoYXQgdGhleSBmaXQg
d2hhdCBKdW5pbyByZXF1ZXN0ZWQuIEkgYWxzbw0KbW9kaWZpZWQgdGhlIGxhc3QgdHdvIHBhdGNo
ZXMgdG8gbWFrZSB0aW1lcl9zZXR0aW1lIGZhbGxiYWNrIHRvDQpzZXRpdGltZXIuIEkgYW0gbm90
IHN1cmUgdGhpcyBpcyB0aGUgYmVzdCBhcHByb2FjaCwgYnV0IGl0IHNob3VsZCBiZQ0KZWFzeSB0
byB0YWtlIGF0IGxlYXN0IHRoZSBvYnZpb3VzIGJ1ZyBmaXhlcyBmcm9tIHRoZSBmaXJzdCB0aHJl
ZQ0KcGF0Y2hlcywgYW5kIHRoaXMgZ2l2ZXMgYW4gb3V0bGluZSBmb3IgaG93IHdlIGNvdWxkIHdy
YXAgdGhlIHNldGl0aW1lcg0Kc3R1ZmYuDQoNCk9uZSBjb3VsZCBhbHNvIHdyaXRlIGFub3RoZXIg
bGF5ZXIgb2Ygd3JhcHBlciBpbiBzb21lIGNvbXBhdC9pdGltZXIuYw0KY29kZSwgYnV0IEkgZG9u
J3QgdGhpbmsgdGhpcyBpcyBuZWNlc3NhcnkuDQoNClJlZ2FyZHMsDQpKYWtlDQo=
