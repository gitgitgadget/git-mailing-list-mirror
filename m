From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 2/2] completion: add support for completing email
 aliases
Date: Mon, 16 Nov 2015 23:40:46 +0000
Message-ID: <1447717246.23262.11.camel@intel.com>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
	 <1447618940-27446-2-git-send-email-jacob.e.keller@intel.com>
	 <CAPig+cST4iGdv0B91C_sWs85OMyw5c77ivjZ50xkbF+_uTr1YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>,
	"lee.marlow@gmail.com" <lee.marlow@gmail.com>
To: "sunshine@sunshineco.com" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:40:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyTOH-0006ai-7M
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 00:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbbKPXkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 18:40:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:50610 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbbKPXks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 18:40:48 -0500
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP; 16 Nov 2015 15:40:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,304,1444719600"; 
   d="scan'208";a="687039831"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga003.jf.intel.com with ESMTP; 16 Nov 2015 15:40:48 -0800
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Mon, 16 Nov 2015 15:40:47 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.96]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.39]) with mapi id 14.03.0248.002;
 Mon, 16 Nov 2015 15:40:47 -0800
Thread-Topic: [PATCH v2 2/2] completion: add support for completing email
 aliases
Thread-Index: AQHRH+NcStoNCHxpvkm5w1PM157BkZ6f1KQAgAACHwA=
In-Reply-To: <CAPig+cST4iGdv0B91C_sWs85OMyw5c77ivjZ50xkbF+_uTr1YA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.123]
Content-ID: <AEDF6161DCAB9649A7495C4F6BC143BC@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281367>

T24gTW9uLCAyMDE1LTExLTE2IGF0IDE4OjMzIC0wNTAwLCBFcmljIFN1bnNoaW5lIHdyb3RlOg0K
PiBPbiBTdW4sIE5vdiAxNSwgMjAxNSBhdCAzOjIyIFBNLCBKYWNvYiBLZWxsZXIgPGphY29iLmUu
a2VsbGVyQGludGVsLmMNCj4gb20+IHdyb3RlOg0KPiA+IFVzaW5nIHRoZSBuZXcgLS1saXN0LWFs
aWFzZXMgb3B0aW9uIGZyb20gZ2l0LXNlbmQtZW1haWwsIGFkZA0KPiA+IGNvbXBsZXRpb24NCj4g
PiBmb3IgLS10bywgLS1jYywgYW5kIC0tYmNjIHdpdGggdGhlIGF2YWlsYWJsZSBjb25maWd1cmVk
IGFsaWFzZXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5r
ZWxsZXJAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+IGRpZmYgLS1naXQgYS9jb250cmliL2NvbXBs
ZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaA0KPiA+IGIvY29udHJpYi9jb21wbGV0aW9uL2dpdC1j
b21wbGV0aW9uLmJhc2gNCj4gPiBAQCAtMTcxMSw2ICsxNzEyLDE1IEBAIF9fZ2l0X3NlbmRfZW1h
aWxfc3VwcHJlc3NjY19vcHRpb25zPSJhdXRob3INCj4gPiBzZWxmIGNjIGJvZHljYyBzb2IgY2Nj
bWQgYm9keSBhbGwiDQo+ID4gDQo+ID4gwqBfZ2l0X3NlbmRfZW1haWwgKCkNCj4gPiDCoHsNCj4g
PiArwqDCoMKgwqDCoMKgwqBjYXNlICIkcHJldiIgaW4NCj4gPiArwqDCoMKgwqDCoMKgwqAtLXRv
fC0tY2N8LS1iY2MpDQo+IA0KPiBXaGF0IGFib3V0IC0tZnJvbSwgd2hpY2ggYWxzbyB1bmRlcmdv
ZXMgYWxpYXMgZXhwYW5zaW9uPw0KPiANCg0KTWFrZXMgc2Vuc2UsIHllcC4NCg0K
