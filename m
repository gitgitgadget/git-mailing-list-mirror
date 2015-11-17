From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Tue, 17 Nov 2015 00:10:35 +0000
Message-ID: <1447719035.23262.17.camel@intel.com>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
	 <CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
	 <1447717227.23262.10.camel@intel.com>
	 <CAPig+cSMW2UmTzuyvBFpcpr4tF1FRdxHUPH4+wS3vrZSP9AzJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"lee.marlow@gmail.com" <lee.marlow@gmail.com>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>
To: "sunshine@sunshineco.com" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:10:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyTr8-0004Je-52
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 01:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbbKQAKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 19:10:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:44582 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbbKQAKh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 19:10:37 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP; 16 Nov 2015 16:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,305,1444719600"; 
   d="scan'208";a="601452549"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2015 16:10:36 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.96]) by
 ORSMSX103.amr.corp.intel.com ([169.254.2.103]) with mapi id 14.03.0248.002;
 Mon, 16 Nov 2015 16:10:35 -0800
Thread-Topic: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Thread-Index: AQHRH+NeL2JBu1hRzUqsWBsvOxZ9JJ6f09QAgAAC2YCAAALsgIAABX+A
In-Reply-To: <CAPig+cSMW2UmTzuyvBFpcpr4tF1FRdxHUPH4+wS3vrZSP9AzJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.3.123]
Content-ID: <E237687BB837BB4C8CF5E131FB38BA12@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281371>

T24gTW9uLCAyMDE1LTExLTE2IGF0IDE4OjUwIC0wNTAwLCBFcmljIFN1bnNoaW5lIHdyb3RlOg0K
PiBJdCBzaG91bGQgYmUgcG9zc2libGUgdG8gZXh0cmFjdCB0aGUgYWxpYXMgd2l0aGluIHRoZSBz
aGVsbCBpdHNlbGYNCj4gd2l0aG91dCBhIHNlcGFyYXRlIHByb2Nlc3MuIEZvciBpbnN0YW5jZToN
Cj4gDQo+IMKgwqDCoMKgcmVhZCBhbGlhcyByZXN0DQo+IA0KPiB3aWxsIGxlYXZlIHRoZSBmaXJz
dCB0b2tlbiBpbiAkYWxpYXMgYW5kIHRoZSByZW1haW5kZXIgb2YgdGhlIGxpbmUgaW4NCj4gJHJl
c3QsIGFuZCBpdCdzIGFsbCBkb25lIHdpdGhpbiB0aGUgc2hlbGwgcHJvY2Vzcy4NCj4gDQoNCkkn
bGwgbG9vayBpbnRvIHRoaXMgOikNCg0KPiA+ID4gTmV3IHRlc3Qocykgc2VlbSB0byBiZSBtaXNz
aW5nLg0KPiA+IA0KPiA+IEkgaGFkIHJlbW92ZWQgdGhlIHRlc3RzIGZyb20gdGhlIG9sZCB2ZXJz
aW9uIGJlY2F1c2UgdGhleSB3ZXJlbid0DQo+ID4gbmVjZXNzYXJ5IGFueW1vcmUuIE5ldyBvbmVz
IHdvdWxkbid0IGh1cnQgaGVyZSBlaXRoZXIsIHRob3VnaC4uDQo+ID4gSSdsbA0KPiA+IHdvcmsg
b24gdGhhdC4NCj4gDQo+IEknbSBub3Qgc3VyZSB3aGljaCB0ZXN0cyB5b3UgbWVhbiwgYnV0IEkg
d2FzIHJlZmVycmluZyB0byB0ZXN0cyB0bw0KPiBtYWtlIHN1cmUgdGhhdCBnaXQtc2VuZC1lbWFp
bCByZWNvZ25pemVzIC0tbGlzdC1hbGlhc2VzIChvcg0KPiAtLWR1bXAtYWxpYXNlcyBpZiB5b3Ug
c3dpdGNoIHRvIHRoYXQpIGFuZCB0aGF0IGl0IHByb2R1Y2VzIHRoZQ0KPiBleHBlY3RlZCBvdXRw
dXQgaW4gdGhlIGV4cGVjdGVkIGZvcm1hdC4NCj4gDQoNClllcCwgSSBhZGRlZCBzb21lIGluIG15
IHJlc3Bpbi4NCg0KPiBBbHNvLCBzaG91bGRuJ3QgLS1saXN0LWFsaWFzZXMgKG9yIC0tZHVtcC1h
bGlhc2VzKSBiZSBtdXR1YWxseQ0KPiBleGNsdXNpdmUgd2l0aCBtYW55IG9mIHRoZSBvdGhlciBv
cHRpb25zPyBOZXcgdGVzdHMgd291bGQgY2hlY2sgc3VjaA0KPiBleGNsdXNpdml0eSBhcyB3ZWxs
Lg0KDQpJIGFtIGF0IGEgbG9zcyBmb3IgaG93IHRvIGRvIHRoYXQgY29ycmVjdGx5IGluIHRoZSBw
ZXJsLiBIZWxwIHdvdWxkIGJlDQphcHByZWNpYXRlZCBoZXJlLg0KDQpSZWdhcmRzLA0KSmFr
