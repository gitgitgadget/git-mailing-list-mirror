From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH] makefile: add ability to run specific test files
Date: Wed, 9 Jul 2014 23:49:23 +0000
Message-ID: <1404949763.23510.42.camel@jekeller-desk1.amr.corp.intel.com>
References: <1404945412-10197-2-git-send-email-jacob.e.keller@intel.com>
	 <xmqq61j69m0m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "gitster@pobox.com" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 01:49:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X51c9-0007Xd-5F
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 01:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbaGIXtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 19:49:25 -0400
Received: from mga03.intel.com ([143.182.124.21]:25152 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbaGIXtY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 19:49:24 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 09 Jul 2014 16:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,634,1400050800"; 
   d="scan'208";a="455180330"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by azsmga001.ch.intel.com with ESMTP; 09 Jul 2014 16:49:23 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.193]) by
 ORSMSX110.amr.corp.intel.com ([169.254.3.171]) with mapi id 14.03.0123.003;
 Wed, 9 Jul 2014 16:49:23 -0700
Thread-Topic: [PATCH] makefile: add ability to run specific test files
Thread-Index: AQHPm8ZLdNa2z5Fi2Um4FWbUI/IL6JuYW1xVgACDQYA=
In-Reply-To: <xmqq61j69m0m.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.134.173.156]
Content-ID: <1E846CDABC4E3242A9C4734AFA9B1BED@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253169>

T24gV2VkLCAyMDE0LTA3LTA5IGF0IDE1OjU5IC0wNzAwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToN
Cj4gSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+
ID4gUnVubmluZyBhIHNwZWNpZmljIHRlc3QgZmlsZSBtYW51YWxseSBkb2VzIG5vdCBvYnRhaW4g
dGhlIGV4YWN0DQo+ID4gZW52aXJvbm1lbnQgc2V0dXAgYnkgdGhlIE1ha2VmaWxlLg0KPiANCj4g
V2hhdCBraW5kIG9mIHRoaW5ncyBhcmUgbWlzc2luZywgZXhhY3RseT8gIFBlcmhhcHMgdGhhdCBp
cyBzb21ldGhpbmcNCj4geW91IG5lZWQgdG8gZml4LCBpbnN0ZWFkIG9mIG11Y2tpbmcgd2l0aCB0
aGUgdG9wLWxldmVsIE1ha2VmaWxlLg0KPiANCj4gSSByZWNhbGwgbGFzdCB0aW1lIHdoZW4gSSBk
aWQgYSBwYXRjaCBsaWtlIHRoaXMgSSB3YXMgdG9sZCB0byBsb29rDQo+IGludG8gIm1ha2UgLUMg
dCIgOy0pICBXaGF0IGlzIGRpZmZlcmVudCB0aGlzIHJvdW5kPw0KDQpJdCB1c2VzIHRoZSBnaXQg
ZnJvbSBteSBlbnZpcm9ubWVudCBpbnN0ZWFkIG9mIHRoZSBnaXQgSSBoYXZlIGJ1aWx0LA0Kd2hp
Y2ggaXMgYmFkIHNpbmNlIEkgZG9uJ3QgcmVhbGx5IHdhbnQgdG8gcnVuIG1ha2UgaW5zdGFsbC4N
Cg0KVGhhbmtzLA0KSmFrZQ0K
