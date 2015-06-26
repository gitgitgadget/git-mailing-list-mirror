From: <steve.norman@thomsonreuters.com>
Subject: RE: [ANNOUNCE] Git v2.5.0-rc0
Date: Fri, 26 Jun 2015 09:36:04 +0000
Message-ID: <7FAE15F0A93C0144AD8B5FBD584E1C55197CF80F@C111KJZHMBX55.ERF.thomson.com>
References: <xmqqr3ozy1zt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <junio@pobox.com>, <git@vger.kernel.org>
To: <peff@peff.net>, <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 11:36:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Q3a-0002jL-LP
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 11:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbFZJgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 05:36:19 -0400
Received: from mailout2-trp.thomsonreuters.com ([163.231.6.26]:46915 "EHLO
	mailout2-trp.thomsonreuters.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752750AbbFZJgR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2015 05:36:17 -0400
Received: from trpusmneagrly02.int.westgroup.com (relay2 [163.231.22.113])
	by mailout2-trp.thomsonreuters.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id t5Q9aB1G011710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jun 2015 09:36:11 GMT
Received: from EAGF-ERFPHUB13.ERF.thomson.com (xch2 [163.231.23.9])
	by trpusmneagrly02.int.westgroup.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id t5Q9a9I8000711
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 26 Jun 2015 09:36:10 GMT
Received: from C111KJZHMBX55.ERF.thomson.com ([fe80::f529:cc22:c054:b74f]) by
 EAGF-ERFPHUB13.ERF.thomson.com ([fe80::c833:49ed:82c8:5c0b%16]) with mapi id
 14.03.0158.001; Fri, 26 Jun 2015 04:36:06 -0500
Thread-Topic: [ANNOUNCE] Git v2.5.0-rc0
Thread-Index: AQHQr4RhCMr9F781F0GRiN2M/oB/852+hRFw
In-Reply-To: <xmqqr3ozy1zt.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.30.4]
x-tm-as-product-ver: SMEX-10.2.0.3308-8.000.1202-21634.006
x-tm-as-result: No--31.664000-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272769>

SmVmZiAvIER1eSwNCg0KPiBGaXhlcyBzaW5jZSB2Mi40DQo+ICAqIEFjY2VzcyB0byBvYmplY3Rz
IGluIHJlcG9zaXRvcmllcyB0aGF0IGJvcnJvdyBmcm9tIGFub3RoZXIgb25lIG9uIGENCj4gICAg
c2xvdyBORlMgc2VydmVyIHVubmVjZXNzYXJpbHkgZ290IG1vcmUgZXhwZW5zaXZlIGR1ZSB0byBy
ZWNlbnQgY29kZQ0KPiAgICBiZWNvbWluZyBtb3JlIGNhdXRpb3VzIGluIGEgbmFpdmUgd2F5IG5v
dCB0byBsb3NlIG9iamVjdHMgdG8gcHJ1bmluZy4NCj4gICAgKG1lcmdlIGVlMWM2YzMgamsvcHJ1
bmUtbXRpbWUgbGF0ZXIgdG8gbWFpbnQpLg0KPiANCj4gICogIkhhdmUgd2UgbG9zdCBhIHJhY2Ug
d2l0aCBjb21wZXRpbmcgcmVwYWNrPyIgY2hlY2sgd2FzIHRvbw0KPiAgICBleHBlbnNpdmUsIGVz
cGVjaWFsbHkgd2hpbGUgcmVjZWl2aW5nIGEgaHVnZSBvYmplY3QgdHJhbnNmZXINCj4gICAgdGhh
dCBydW5zIGluZGV4LXBhY2sgKGUuZy4gImNsb25lIiBvciAiZmV0Y2giKS4NCj4gICAgKG1lcmdl
IDBlZWIwNzcgamsvaW5kZXgtcGFjay1yZWR1Y2UtcmVjaGVjayBsYXRlciB0byBtYWludCkuDQoN
Ckkgd2FzIHJlYWRpbmcgdGhyb3VnaCB0aGUgMi41IHJlbGVhc2Ugbm90ZXMgYW5kIHNwb3R0ZWQg
dGhlIGFib3ZlIHR3byBlbnRyaWVzIGFuZCBJIHRoaW5rIHRoZXkgYXJlIHByb2JhYmx5IGZpeGVz
IHJlbGF0ZWQgdG8gdGhlIE5GUyBzbG93bmVzcyBJIHJlcG9ydGVkIGxhc3QgbW9udGguDQoNCkRp
ZCBzb21lIHRlc3RzIHRoaXMgbW9ybmluZyBhbmQgdGhpbmdzIGFyZSBtdWNoIGltcHJvdmVkOg0K
DQpWZXJzaW9uIDIuNC41DQogIC0gTG9jYWwgY2xvbmUgb2YgaHR0cHM6Ly9naXRodWIuY29tL2dp
dC9naXQgLSA4cw0KICAtIENsb25lIHRvIE5GUyAtIDFtIDNzDQoNClZlcnNpb24gMi41LjAucmMw
DQogIC0gTG9jYWwgLSA3cw0KICAtIE5GUyAtIDEzcw0KDQpUaGFua3MgZm9yIHRoZSBlZmZvcnQg
aW4gYWRkcmVzc2luZyB0aGlzIGFuZCBzb3JyeSBJIG1pc3NlZCB0aGUgcGF0Y2ggdG8gY2hlY2sg
aXQgb3V0IGVhcmxpZXIuIA0KDQpTdGV2ZQ0K
