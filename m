From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v8 1/4] usage: make error functions a stack
Date: Tue, 15 Jul 2014 23:26:23 +0000
Message-ID: <1405466783.2577.15.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
	 <1405459754-4220-2-git-send-email-jacob.e.keller@intel.com>
	 <xmqq7g3etf1o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 01:27:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7C7k-0000m3-H8
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbaGOX0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:26:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:14926 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965214AbaGOX0x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:26:53 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 15 Jul 2014 16:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="543899524"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2014 16:26:23 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.59]) by
 ORSMSX109.amr.corp.intel.com ([169.254.2.21]) with mapi id 14.03.0123.003;
 Tue, 15 Jul 2014 16:26:23 -0700
Thread-Topic: [PATCH v8 1/4] usage: make error functions a stack
Thread-Index: AQHPoH7MecXJzaW2eE+GxUkwp9ZNCpuiPLyA
In-Reply-To: <xmqq7g3etf1o.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <3F43B7583B85D9468E783F0AFBC27AD4@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253620>

T24gVHVlLCAyMDE0LTA3LTE1IGF0IDE1OjQ3IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gIGV4dGVybiB2b2lkIHNldF9lcnJvcl9yb3V0aW5lKHZvaWQgKCpyb3V0aW5lKShjb25zdCBj
aGFyICplcnIsIHZhX2xpc3QgcGFyYW1zKSk7DQo+ID4gK2V4dGVybiB2b2lkIHBvcF9lcnJvcl9y
b3V0aW5lKHZvaWQpOw0KPiANCj4gcG9wIHRoYXQgdW5kb2VzIHNldCBzbWVsbHMgc29tZXdoYXQg
d2VpcmQuICBQZXJoYXBzIHdlIHNob3VsZCByZW5hbWUNCj4gc2V0IHRvIHB1c2g/ICBUaGF0IHdv
dWxkIGFsbG93IHVzIGNhdGNoIHBvc3NpYmxlIHRvcGljcyB0aGF0IGFkZCBuZXcNCj4gY2FsbHMg
dG8gc2V0X2Vycm9yX3JvdXRpbmUoKSBhcyB3ZWxsIGJ5IGZvcmNpbmcgdGhlIHN5c3RlbSBub3Qg
dG8NCj4gbGluayB3aGVuIHRoZXkgYXJlIG1lcmdlZCB3aXRob3V0IG5lY2Vzc2FyeSBmaXhlcy4N
Cj4gDQoNCkFsc28gY3VyaW91cyB3aGF0IHlvdXIgdGhvdWdodHMgb24gbWFraW5nIGV2ZXJ5IHNl
dF8qX3JvdXRpbmUgdG8gYmUgYQ0Kc3RhY2s/IEZvciBub3cgSSB3YXMgb25seSBwbGFubmluZyBv
biBlcnJvciBidXQgaXQgbWF5YmUgbWFrZXMgc2Vuc2UgdG8NCmNoYW5nZSB0aGVtIGFsbD8NCg0K
VGhhbmtzLA0KSmFrZQ0KDQo=
