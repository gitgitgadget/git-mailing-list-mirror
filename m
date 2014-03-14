From: =?GBK?B?yfKz0Lb3?= <ubuntu2012@126.com>
Subject: Re:Re: [PATCH] microproject for GSOC
Date: Sat, 15 Mar 2014 01:44:43 +0800 (CST)
Message-ID: <6c0ae8fc.7d.144c1b22cd7.Coremail.ubuntu2012@126.com>
References: <1394815367-9706-1-git-send-email-ubuntu2012@126.com>
 <vpq4n30aeou.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 14 19:16:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOWem-0005nm-5X
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 19:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817AbaCNSQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 14:16:22 -0400
Received: from m15-19.126.com ([220.181.15.19]:59389 "EHLO m15-19.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755761AbaCNSQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 14:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=sh+PK
	bmIYp70sU61Pd8Ih5wIr7dhQkZuOSleyAQM+Kc=; b=fQmchtHcn+IvKb9RuVmtU
	ro3R8UVWWYfP1tjBxgjqU7CiZjI0QG2sWpiLszzHw9dzNh65JqxGQAYNw3bHOuP4
	rySaxt+SQeYHaps0I91XAk42TnNY2Nz+HWUx+lxwxJz7nHA6zmiYPn8Rxo1whzfa
	Ji8d5WdpsyssVeQlZ7PSr8=
Received: from ubuntu2012$126.com ( [125.71.195.57] ) by
 ajax-webmail-wmsvr19 (Coremail) ; Sat, 15 Mar 2014 01:44:43 +0800 (CST)
X-Originating-IP: [125.71.195.57]
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20131204(24406.5820.5783) Copyright (c) 2002-2014 www.mailtech.cn 126com
In-Reply-To: <vpq4n30aeou.fsf@anie.imag.fr>
X-CM-TRANSID: E8qowGCJekEMQCNT4hYNAA--.38933W
X-CM-SenderInfo: hxex03jxsqija6rslhhfrp/1tbi1AFOqEsK460BhgACs5
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244102>

VGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLkkgd2lsbCBhbWVuZCB0aG9zZSBpc3N1ZXMgLkFz
IGEgQ2hpbmVzZSBzdHVkZW50LHdoYXQgbmFtZSBzaG91bGQgSSB1c2U/TXkgQ2hpbmVzZSBuYW1l
IGlzIG9rPwpBdCAyMDE0LTAzLTE1IDAxOjEwOjU3LCJNYXR0aGlldSBNb3kiIDxNYXR0aGlldS5N
b3lAZ3Jlbm9ibGUtaW5wLmZyPiB3cm90ZToKPkhpLA0KPg0KPldlbGNvbWUgdG8gdGhlIEdpdCBj
b21tdW5pdHksIGFuZCB3ZWxjb21lIHRvIHRoZSBHU09DIHByb2dyYW0uIEJlbG93IGFyZQ0KPnNv
bWUgY29tbWVudHMgdG8gZ2l2ZSB5b3UgYSB0YXN0ZSBvZiB3aGF0IGEgcmV2aWV3IGxvb2tzIGxp
a2Ugb24gdGhpcw0KPmxpc3QuIERvIHRha2UgdGhlIGNvbW1lbnRzIHNlcmlvdXNseSAodGhleSBz
aG91bGQgYmUgYWRkcmVzc2VkKSwgYnV0DQo+ZG9uJ3QgdGFrZSB0aGVtIGJhZGx5OiBjcml0aWMg
aXMgbWVhbnQgdG8gYmUgY29uc3RydWN0aXZlLg0KPg0KPnVidW50dTczMyA8dWJ1bnR1MjAxMkAx
MjYuY29tPiB3cml0ZXM6DQo+Xl5eXl5eXl5eDQo+DQo+UGxlYXNlLCB1c2UgYSByZWFsIG5hbWUg
d2hlbiB5b3UgY29udHJpYnV0ZSB0byBHaXQuDQo+DQo+PiBBcHBseSBmb3IgR1NPQy5UaGUgbWlj
cm9wcm9qZWN0cyBpcyByZXdyaXRlciBkaWZmLWluZGV4LmMNCj4NCj5UaGlzIHBhcnQgb2YgeW91
ciBtZXNzYWdlIHdpbGwgYmVjb21lIHRoZSBjb21taXQgbWVzc2FnZSAoaS5lLiBjYXN0IGluDQo+
c3RvbmUgZm9yZXZlciBpbiBnaXQuZ2l0J3MgaGlzdG9yeSkuIFRoZSBwb2ludCBpcyBub3QgdGhh
dCB5b3Ugd2FudCB0bw0KPmFwcGx5IGZvciBHU09DLCBidXQgd2hhdCB0aGUgcGF0Y2ggZG9lcyBh
bmQgbW9yZSBpbXBvcnRhbnRseSB3aHkgaXQgZG9lcw0KPml0Lg0KPg0KPj4gKyNkZWZpbmUgUkVN
T1ZFIDENCj4NCj5JZiB0aGUgY29kZSBpcyB0byBiZSByZW1vdmVkLCB0aGVuIHJlbW92ZSBpdC4g
VGhhdCdzIHdoeSB3ZSB1c2UgYQ0KPnZlcnNpb24gY29udHJvbCBzeXN0ZW0gOy0pLg0KPg0KPj4g
LQl3aGlsZSAoKGUgPSByZWFkZGlyKGRpcikpKQ0KPj4gLQkJaWYgKHN0cmNtcCgiLiIsIGUtPmRf
bmFtZSkgJiYgc3RyY21wKCIuLiIsIGUtPmRfbmFtZSkpDQo+PiAtCQkJc3RyaW5nX2xpc3RfaW5z
ZXJ0KGxpc3QsIGUtPmRfbmFtZSk7DQo+PiAtDQo+PiArCXdoaWxlICgoZSA9IHJlYWRkaXIoZGly
KSkpIHsNCj4+ICsJCXdoaWxlKGlzX2RvdF9vcl9kb3Rkb3QoZS0+ZF9uYW1lKSkNCj4NCj5NaXNz
aW5nIHNwYWNlIGJldHdlZW4gIndoaWxlIiBhbmQgIigiLg0KPg0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4NCj5Ccm9rZW4gaW5kZW50YXRpb24gKGluZGVudCB3aXRoIHNwYWNl
KS4NCj4NCj5UaGlzIHdoaWxlICguLi4pIGJyZWFrOyBzZWVtcyByZWFsbHkgd2VpcmQgdG8gbWU6
IGlmIHRoZSBjb25kaXRpb24gaXMNCj5mYWxzZSwgdGhlbiB5b3UgZXhpdCB0aGUgbG9vcCBiZWNh
dXNlIGl0J3MgYSB3aGlsZSBsb29wLCBhbmQgaWYgdGhlDQo+Y29uZGl0aW9uIGlzIHRydWUsIHlv
dSBleGl0IHRoZSBsb29wIGJlY2F1c2Ugb2YgdGhlIGJyZWFrLiBJc24ndCB0aGF0IGENCj5uby1v
cD8NCj4NCj4+ICsJCXN0cmluZ19saXN0X2luc2VydChsaXN0LCBlLT5kX25hbWUpOw0KPj4gKyAg
ICAgICAgICAgICAgfQ0KPg0KPkJyb2tlbiBpbmRlbnRhdGlvbiAobWlzcGxhY2VkIH0pLg0KPg0K
Pi0tIA0KPk1hdHRoaWV1IE1veQ0KPmh0dHA6Ly93d3ctdmVyaW1hZy5pbWFnLmZyL35tb3kvDQo=
