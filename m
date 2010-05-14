From: "Akhbari, Farshad" <farshad.akhbari@intel.com>
Subject: Git methodology question
Date: Fri, 14 May 2010 09:14:18 -0700
Message-ID: <F802F7F4D3C2674881AB105A9CD324A804EE0D0D8D@azsmsx504.amr.corp.intel.com>
References: <20100505033536.GB8779@coredump.intra.peff.net>
 <cover.1273760226.git.git@drmicha.warpmail.net>
 <20100514060612.GA19652@coredump.intra.peff.net>
 <4BED7574.4070503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 14 18:14:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCxWt-0002Vz-K9
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 18:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab0ENQOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 12:14:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:32683 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995Ab0ENQOU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 12:14:20 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 14 May 2010 09:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.53,231,1272870000"; 
   d="scan'208";a="567224262"
Received: from unknown (HELO azsmsx603.amr.corp.intel.com) ([10.2.161.23])
  by fmsmga002.fm.intel.com with ESMTP; 14 May 2010 09:13:31 -0700
Received: from azsmsx504.amr.corp.intel.com ([10.2.121.37]) by
 azsmsx603.amr.corp.intel.com ([10.2.161.23]) with mapi; Fri, 14 May 2010
 09:14:19 -0700
Thread-Topic: Git methodology question
Thread-Index: Acrzf7BUO2vqmbVaSZiZ8BtRibyD9QAACgbw
In-Reply-To: <4BED7574.4070503@drmicha.warpmail.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147097>

DQpBbGwsDQoNCkkgYW0gdHJ5aW5nIHRvIHNldHVwIGEgInJlbGlhYmxlIiBmbG93IHdpdGggZ2l0
LiBJIGFtIHNvcnQgb2YgbmV3IHRvIHRoZSB0b29sIGFuZCBuZWVkIHNvbWUgaGVscCBmcm9tIHRo
ZSBleHBlcnRzLiBUaGUgcXVlc3Rpb24gcGVydGFpbnMgdG8gdGhlIHdheSBTSEExIHRhZ3MgY2Fu
IGJlIGJhY2stdHJhY2tlZCBpbiBwYXJhbGxlbCBjbG9uZXMuIEhlcmUgaXMgdGhlIHNjZW5hcmlv
IEkgaGF2ZSBpbiBtaW5kOg0KDQpJbiBvcmRlciBvZiB0aW1lOg0KVXNlcjEg4oCTIHB1bGxzIGZy
b20gdGhlIG9yaWdpbjsgdXBkYXRlcywgbW9kaWZpZXMsIHZlcmlmaWVzIGFuZCBjb21taXRzIGlu
dG8gaGlzIGNsb25lLiBUaGlzIHdpbGwgZ2VuZXJhdGUgU0hBMV8xDQpVc2VyMiDigJMgcHVsbHMg
ZnJvbSB0aGUgb3JpZ2luOyB1cGRhdGVzLCBtb2RpZmllcywgdmVyaWZpZXMgYW5kIGNvbW1pdHMg
aW50byBoaXMgY2xvbmUuIFRoaXMgd2lsbCBnZW5lcmF0ZSBTSEExXzINClVzZXIzIOKAkyBwdWxs
cyBmcm9tIHRoZSBvcmlnaW47IHVwZGF0ZXMsIG1vZGlmaWVzLCB2ZXJpZmllcyBhbmQgY29tbWl0
cyBpbnRvIGhpcyBjbG9uZS4gVGhpcyB3aWxsIGdlbmVyYXRlIFNIQTFfMw0KDQpJbiBub25lIG9m
IHRoZXNlIGNhc2VzLCBhbnlvbmUgaXMgdXBkYXRpbmcgZnJvbSBlYWNoIG90aGVy4oCZcyBjbG9u
ZXMNCg0KQXQgdGhlIGVuZCBvZiB0aGUgd2VlaywgdGhlIG1vZGVsIGJ1aWxkZXIgbmVlZHMgdG8g
bWVyZ2UgYW5kIHZlcmlmeSBhbGwgY29tbWl0cyBmcm9tIHVzZXIxLCB1c2VyMiBhbmQgdXNlcjMg
YmVmb3JlIHB1c2hpbmcgaW50byB0aGUgb3JpZ2luIG1hc3Rlci4gDQoNClRoZSBxdWVzdGlvbiBp
cywNCiAgICAgICAgICAgIENhbiB0aGUgbW9kZWwgYnVpbGRlciB1c2UgU0hBMV8zIHRhZyBvbmx5
IHRvIGdldCBhbGwgdGhlIHVwZGF0ZXMgbWFkZSBieSB1c2VyMSwgdXNlcjIgYW5kIHVzZXIzOyBv
ciBhbGwgU0hBMSB0YWdzIGFyZSBuZWVkZWQ/DQoNCg0KDQpUaGFua3MsDQpGYXJzaGFkLg0K
