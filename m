From: Thore Husfeldt <thore.husfeldt@cs.lth.se>
Subject: [FUN] Conflicting git merge runs for several minutes. (3,5)
Date: Sat, 18 Apr 2015 11:41:50 +0000
Message-ID: <98D6B393-2331-4FC7-BF2F-66CC73826D86@cs.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: Thore Husfeldt <thore.husfeldt@cs.lth.se>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 18 13:47:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjRDf-00065T-JF
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 13:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbbDRLr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 07:47:27 -0400
Received: from edge05.net.lu.se ([130.235.240.245]:52759 "EHLO
	edge05.net.lu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbbDRLr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 07:47:26 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2015 07:47:25 EDT
Received: from UWCAS01.uw.lu.se (130.235.72.27) by mail.lu.se
 (130.235.240.245) with Microsoft SMTP Server (TLS) id 14.3.235.1; Sat, 18 Apr
 2015 13:41:50 +0200
Received: from UWMBX05.uw.lu.se ([169.254.5.8]) by UWCAS01.uw.lu.se
 ([130.235.59.231]) with mapi id 14.03.0235.001; Sat, 18 Apr 2015 13:41:50
 +0200
Thread-Topic: [FUN] Conflicting git merge runs for several minutes. (3,5)
Thread-Index: AQHQecyoyRXn4EjicU6PM5TKAUep3w==
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.235.59.251]
Content-ID: <9CAB234DFB6EA74AA5F7BBD78112F434@uw.lu.se>
Received-SPF: Pass (edge05.net.lu.se: domain of thore.husfeldt@cs.lth.se
 designates 130.235.72.27 as permitted sender) receiver=edge05.net.lu.se;
 client-ip=130.235.72.27; helo=UWCAS01.uw.lu.se;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267418>

Rm9yIHRoZSBjcnVjaXZlcmJhbGlzdHMgaW4gdGhpcyBjb21tdW5pdHksIEkgY29uc3RydWN0ZWQg
YSBjcnlwdGljIGNyb3Nzd29yZCB0aGVtZWQgZm9yIGdpdC4NCg0KaHR0cDovL3Rob3JlaHVzZmVs
ZHQubmV0LzIwMTUvMDQvMDMvY29uZmxpY3RpbmctZ2l0LW1lcmdlLXJ1bnMtZm9yLXNldmVyYWwt
bWludXRlcy0zNS8NCg0KSGVyZSBhcmUgYWxsIHRoZSBjbHVlczoNCg0KMSBnaXQgcmViYXNlIGEg
cmVmLCBrZWVwaW5nIHRoZSBjdXJyZW50IGJyYW5jaC4gKDExKQ0KOCBJdCBob3Jpem9udGFsbHkg
Y29ubmVjdHMgYSBncm91cCBvZiBkZXZlbG9wZXJzIHRoYXQgaXMgc2Vjb25kIHJhdGUgYXQgaGVh
cnQuICgzLDQpDQo5IFBvcnQgb25lIGdvb2QgdXBzdHJlYW0gY2xhc3MuICg1KQ0KMTAgU3Rhc2gg
L2hvbWUgd2l0aCBFY2xpcHNlLCBzYXkuICg0KQ0KMTEgUGx1bWJpbmcgaW4gZ2l0IGZpbmFsbHkg
b2ZmZXJzIGludGVyZmFjZSBsZXR0aW5nIGV2ZXJ5Ym9keSB0ZXN0IFNIQTEgYWJicmV2aWF0aW9u
cy4gKDcpDQoxMyBCZXR0ZXIgYnJpbmcgY2hhbmdlcyBmcm9tIHRoZSByZXBvc2l0b3J5IGludG8g
dGhlIHdvcmtpbmcgY29weSBpZiB5b3UgdXNlIFN1YnZlcnNpb24uICg2KQ0KMTQgQW5ub3VuY2Ug
bWVyZ2Ugb2YgSEVBRCBpbiByZWFsIGxpZmUuICg2KQ0KMTcgUmVwZW50IG1pc2d1aWRlZCBpbnRy
b2R1Y3Rpb24gb2YgRFZDUyBzaGFtLiAoNykNCjE5IEdpdCBpbiBkZXRhY2hlZCBIRUFEIHN0YXRl
IGF0IHRoZSBiZWdpbm5pbmcgb2YgY2hlY2tvdXQgaXMgYSBwcm92ZXJiaWFsIGlycml0YXRpb24u
ICg0KQ0KMjIgUmVidWtlIGZyb20gZ2l0LWZldGNoIEnigJlkIGVuam95LiAoNSkNCjIzIEFuZ3J5
IHJhbnQgYWJvdXQgY2VudHJhbCBwYXJ0IG9mIEdVSSBlZGl0b3IgcmV2ZWFscyBoYXZpbmcgYSB0
ZW1wZXJhbWVudCBvZiBhIHBhcnRpY3VsYXIga2luZC4gKDcpDQoyNCBTb2NpYWwgZ2F0aGVyaW5n
IGF0dGVuZGVkIG9ubHkgYnkgbWVuIGluIEZyZW5jaCB0cmFpbiBzdGF0aW9uOiBBIGZ1bmRhbWVu
dGFsIGdpdCBjb25jZXB0LiAoNyw0KQ0KDQpEb3duDQoxIEZvcmNlIHByaW50IGRvd25sb2FkIG9i
amVjdHMgYW5kIHJlZnMgZnJvbSBhbm90aGVyIHJlcG9zaXRvcnkuICg1KQ0KMiBUcnVseSBkZXBh
cnRlZCwgSSBsZWZ0IGFuZCByZXdyb3RlIGhpc3RvcnkuICg3KQ0KMyBQYXkgYXR0ZW50aW9uIHRv
IHRoZSBlZGl0b3IgZmVhdHVyZXMuICg0KQ0KNCBSb21lbyB0byBvdmVycGxheSBvcmlnaW4sIG1h
eWJlLiAoNikNCjUgQ29uZmxpY3RpbmcgZ2l0IG1lcmdlIHJ1bnMgZm9yIHNldmVyYWwgbWludXRl
cy4gKDMsNSkNCjYgU291bmRzIGxpa2UgdGhlIHJlc3VsdHMgb2YgYSBjb2xsaXNpb24sIHN0dXBp
ZC4gKDUpDQo3IE1hZGUgc2Vuc2Ugb2YgdGhlIHN5bnRheCwgcXVpZXRseSBib3RoZXJlZCwg4oCm
ICg2KQ0KMTIg4oCmIGFuZCByZXBsYWNlZCBjYXJldCB3aXRoIHJldnNwZWPigJlzIHNlY29uZCBz
eW1ib2wsIGFtb25nIG90aGVycy4gKDgpDQoxMyBDYXJlZnVsbHkgYW5hbHlzZSBnaXQgcmVzZXQg
LS1tZXJnZSBhZnRlciB0cnlpbmcgdG8gYWRkIGNoYW5nZXMgZnJvbSBhIHNwZWNpZmljIGNvbW1p
dD8gKDYpDQoxNSBIZSBtYWtlcyBjaGFuZ2VzIGxhdGVyIHJlIGNvbXBpbGF0aW9uLiAoNykNCjE2
IENyZWF0b3IgYWNjZXB0cyBmaXJzdCBwdWxsIG9uIGNvbXB1dGVyLCBiZWhhdmluZyB3aXRoIHNv
bWUgZGVncmVlIG9mIGF1dG9ub215LiAoNikNCjE4IEZpbmFsbHkgY29tbWl0dGVkIGl0cyBjaGFu
Z2VzLiAoNSkNCjIwIEhhcmR5IGVjY2VudHJpYyB1c2VkIGxvdHMgb2YgYnJhbmNoIGhlYWRzLiAo
NSkNCjIxIFNjYW5kaW5hdmlhbiBtYW7igJlzIHJldm9sdXRpb25hcnkgdmVyc2lvbiBjb250cm9s
IHN5c3RlbS4gKDQp
