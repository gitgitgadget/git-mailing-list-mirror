From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4] linuxptp: add phc_ctl program to help debug PHC
 devices
Date: Thu, 10 Jul 2014 23:39:15 +0000
Message-ID: <1405035555.4925.46.camel@jekeller-desk1.amr.corp.intel.com>
References: <1405032485-26117-2-git-send-email-jacob.e.keller@intel.com>
	 <xmqqr41s6bsg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:39:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5NwL-000719-Au
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 01:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbaGJXjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 19:39:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:31359 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbaGJXjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 19:39:40 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 10 Jul 2014 16:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,640,1400050800"; 
   d="scan'208";a="560200924"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2014 16:39:16 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.123.3; Thu, 10 Jul 2014 16:39:15 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.128]) with mapi id 14.03.0123.003;
 Thu, 10 Jul 2014 16:39:15 -0700
Thread-Topic: [PATCH v4] linuxptp: add phc_ctl program to help debug PHC
 devices
Thread-Index: AQHPnJKm2gzF9f39XU6il+oHG+3s7JuZ8hhpgAB6bIA=
In-Reply-To: <xmqqr41s6bsg.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <FFBBD1F9B7FECF42AB267C8656F9A555@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253233>

T24gVGh1LCAyMDE0LTA3LTEwIGF0IDE2OjIwIC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gVGhpcyBpcyBhbiB1cGRhdGVkIHZlcnNpb24gb2YgYSBzY3JpcHQgSSB3cm90ZSBhIGNvdXBs
ZSB5ZWFycyBhZ28gZm9yDQo+IA0KPiBJIHN1c3BlY3QgdGhhdCB0aGlzIGlzIG5vdCBmb3IgdXMg
Oy0pDQo+IC0tDQo+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBsaXN0OiBzZW5kIHRoZSBsaW5l
ICJ1bnN1YnNjcmliZSBnaXQiIGluDQo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRv
bW9Admdlci5rZXJuZWwub3JnDQo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6Ly92Z2Vy
Lmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0KDQoNCkluZGVlZC4gVGhpcyB3YXMgaW50
ZW5kZWQgZm9yIHRoZSBMaW51eFBUUCBwcm9qZWN0LCBhbmQgSSBhY2NpZGVudGFsbHkNCnNlbnQg
aGVyZS4NCg0KUGxlYXNlIGp1c3QgaWdub3JlIHRoZXNlLg0KDQpUaGFua3MsDQpKYWtlDQo=
