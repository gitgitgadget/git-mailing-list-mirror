From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: cherry picking and merge
Date: Thu, 21 Aug 2014 17:58:07 +0000
Message-ID: <1408643887.20771.8.camel@jekeller-desk1.amr.corp.intel.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	 <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
	 <AC750A73-4FE9-4BCB-9A51-4DE28F2110A7@comcast.net>
	 <1408642561.20771.7.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
To: "mikestump@comcast.net" <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 19:58:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKWdC-0005Cd-FO
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 19:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbaHUR6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 13:58:34 -0400
Received: from mga03.intel.com ([143.182.124.21]:27735 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbaHUR6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 13:58:34 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 21 Aug 2014 10:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,909,1406617200"; 
   d="scan'208";a="471298444"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by azsmga001.ch.intel.com with ESMTP; 21 Aug 2014 10:58:09 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Thu, 21 Aug 2014 10:58:08 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.235]) by
 ORSMSX111.amr.corp.intel.com ([169.254.11.75]) with mapi id 14.03.0195.001;
 Thu, 21 Aug 2014 10:58:08 -0700
Thread-Topic: cherry picking and merge
Thread-Index: AQHPrSPD+/6v1TJ/S0WPKdhqxfKaW5u7f9GAgADuboCAH3mRgIAABi2A
In-Reply-To: <1408642561.20771.7.camel@jekeller-desk1.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <3283131E93245A419111EBF4E4341A3A@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255626>

T24gVGh1LCAyMDE0LTA4LTIxIGF0IDE3OjM2ICswMDAwLCBLZWxsZXIsIEphY29iIEUgd3JvdGU6
DQo+IE9uIEZyaSwgMjAxNC0wOC0wMSBhdCAwOTo1NiAtMDcwMCwgTWlrZSBTdHVtcCB3cm90ZToN
Cj4gPiBTaW5jZSBldmVyeXRoaW5nIEkgZG8gZ29lcyB1cCBhbmQgZG93biBpbnRvIHJlcG9zaXRv
cmllcyBhbmQgSSBkb27igJl0IHdhbnQgbXkgZnJpZW5kcyBhbmQgZmFtaWx5IHRvIHNjb3JuIG1l
LCByZWJhc2UgaXNu4oCZdCB0aGUgY29tbWFuZCBJIHdhbnQgdG8gdXNlLg0KPiANCj4gWW91IGNv
bXBsZXRlbHkgbWlzLXVuZGVyc3RhbmQgd2hhdCAicHVibGlzaGVkIiBtZWFucy4gUHVibGlzaGVk
IGhpc3RvcnkNCj4gaXMgaGlzdG9yeSBmcm9tIHdoaWNoIG90aGVyIHBlb3BsZSBjYW4gcHVsbCBy
aWdodCBub3cuDQo+IA0KPiBUaGF0IG1lYW5zIGl0IGhhcyB0byBiZSBpbiBhIHB1YmxpY2x5IGFk
ZHJlc3NhYmxlIHJlcG9zaXRvcnkgKGllOiBqdXN0DQo+IGxpa2UgdGhlIHJlbW90ZSB0aGF0IHlv
dSBhcmUgcHVsbGluZyBmcm9tIGFzIHVwc3RyZWFtKS4NCj4gDQo+IHJlYmFzaW5nIGNvbW1pdHMg
d2hpY2ggYXJlIGFscmVhZHkgaW4gdGhlIHVwc3RyZWFtIGlzIGJhZC4gUmViYXNpbmcNCj4gY29t
bWl0cyB3aGljaCB5b3UgaGF2ZSBjcmVhdGVkIGxvY2FsbHkgaXMgTk9UIGJhZC4gVGhlc2UgY29t
bWl0cyB3b3VsZA0KPiBub3QgYmUgcHVibGlzaGVkIHVudGlsIHlvdSBkbyBhIHB1c2guDQo+IA0K
PiBUaGlzIGlzIHRoZSBmdW5kYW1lbnRhbCBpc3N1ZSB3aXRoIHJlYmFzZSwgYW5kIGl0IGlzIGlu
ZmFjdCBlYXN5IHRvDQo+IGF2b2lkIG1pcy11c2luZywgZXNwZWNpYWxseSBpZiB5b3UgZG9uJ3Qg
cHVibGlzaCBjaGFuZ2VzLiBUaGUga2V5IGlzDQo+IHRoYXQgYSBjb21taXQgaXNuJ3QgcHVibGlz
aGVkIHVudGlsIGl0J3Mgc29tZXRoaW5nIHNvbWVvbmUgZWxzZSBjYW4NCj4gZGVwZW5kIG9uLg0K
PiANCj4gRG9pbmcgImdpdCBwdWxsIC0tcmViYXNlIiBlc3NlbnRpYWxseSBkb2Vzbid0IGV2ZXIg
Z2V0IHlvdSBpbnRvIHRyb3VibGUuDQo+IA0KPiBSZWdhcmRzLA0KPiBKYWtlDQo+IATvv717Lm7v
v70r77+977+977+977+977+977+977+9KyXvv73vv71sendt77+977+9Yu+/veunsu+/ve+/vXLv
v73vv716CO+/ve+/vXthee+/vR3Kh9qZ77+9LGoH77+977+9Zu+/ve+/ve+/vWjvv73vv73vv716
77+9Hu+/vXfvv73vv73vv70M77+977+977+9ajordu+/ve+/ve+/vXfvv71q77+9be+/ve+/ve+/
ve+/vQfvv73vv73vv73vv716Wivvv73vv73vv73vv73vv73domoi77+977+9Ie+/vWkNCg0KUGFy
ZG9uIG1lLiBZb3UgY2FuIGFjdHVhbGx5IGlnbm9yZSB0aGlzIHBvc3QuIEkgcmVhZCB0aHJvdWdo
IG1vcmUgb2YgdGhlDQp0aHJlYWQsIGFuZCBhY3R1YWxseSByZWFsaXplIEkgY29tcGxldGVseSBt
aXN1bmRlcnN0b29kIHdoYXQgeW91ciBpc3N1ZQ0Kd2FzLCBhbmQgd2h5IHJlYmFzZSBtaWdodCBu
b3Qgd29yay4NCg0KUmVnYXJkcywNCkpha2UNCg==
