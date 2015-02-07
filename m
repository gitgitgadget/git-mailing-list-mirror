From: Joachim Schmitz <jojo@schmitz-digital.de>
Subject: Re: read() =?utf-8?b?TUFYX0lPX1NJWkU=?= bytes, more than =?utf-8?b?U1NJWkVfTUFYPw==?=
Date: Sat, 7 Feb 2015 22:31:39 +0000 (UTC)
Message-ID: <loom.20150207T232422-706@post.gmane.org>
References: <loom.20150207T174514-727@post.gmane.org> <54D64939.4080102@web.de> <loom.20150207T182443-33@post.gmane.org> <54D67662.7040504@web.de> <CAPc5daUnKcktv0xcz-fGEApckbkQksKuZO53ZL20E1MhtZmn4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 23:31:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKDur-00085d-08
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 23:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758815AbbBGWbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 17:31:49 -0500
Received: from plane.gmane.org ([80.91.229.3]:34633 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069AbbBGWbs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 17:31:48 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YKDuj-00082e-6W
	for git@vger.kernel.org; Sat, 07 Feb 2015 23:31:45 +0100
Received: from dslb-188-109-251-074.188.109.pools.vodafone-ip.de ([188.109.251.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 23:31:45 +0100
Received: from jojo by dslb-188-109-251-074.188.109.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 23:31:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.109.251.74 (Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263459>

SnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXIgPGF0PiBwb2JveC5jb20+IHdyaXRlczoKCj4gCj4gT24gU2F0LCBGZWIgNywgMjAxNSBhdCAxMjozMiBQTSwgVG9yc3RlbiBCw7ZnZXJzaGF1c2VuIDx0Ym9lZ2kgPGF0PiAKd2ViLmRlPiB3cm90ZToKPiA+IEkgZG9uJ3Qga25vdyBldmVyeSBwbGF0Zm9ybSBvZiB0aGUgcGxhbmV0IHdlbGwgZW5vdWdoIHRvIGJlIGhlbHBmdWwgCmhlcmUsCj4gPiBlc3BlY2lhbGx5IHRoZSBvbmVzIHdoaWNoIGRvbid0IGZvbGxvdyBhbGwgdGhlIHNwZWNpZmljYXRpb25zLgo+ID4KPiA+IEluIG90aGVyIHdvcmRzOiBBcyBsb25nIGFzIHdlIGNhbiBub3QgZ3VhcmFudGVlIHRoYXQgU1NJWkVfTUFYIGlzIApkZWZpbmVkLAo+ID4gKGFuZCBpcyBkZWZpbmVkIHRvIHNvbWV0aG9uZyB1c2VmdWwgZm9yIHhyZWFkKCkveHdyaXRlKCkgKQo+ID4gd2Ugc2hvdWxkIGJlIG1vcmUgZGVmZW5zaXZlIGhlcmU6Cj4gPgo+ID4gdHdlYWsgb25seSBvbiBwbGF0Zm9ybSB3aGVyZSB3ZSBrbm93IGl0IGlzIG5lZWRlZCBhbmQgd2Uga25vdyB0aGF0IGl0IAp3b3Jrcy4KPiAKPiBZdXAsIEkgYWdyZWUgdGhhdCBpcyBhIHNlbnNpYmxlIHdheSB0byBn
 by4KPiAKPiAgKDEpIGlmIE1ha2VmaWxlIG92ZXJyaWRlcyB0aGUgc2l6ZSwgdXNlIGl0OyBvdGhlcndpc2UKPiAgKDIpIGlmIFNTSVpFX01BWCBpcyBkZWZpbmVkLCBhbmQgaXQgaXMgc21hbGxlciB0aGFuIG91ciBpbnRlcm5hbAo+IGRlZmF1bHQsIHVzZSBpdDsgb3RoZXJ3aXNlCj4gICgzKSB1c2Ugb3VyIGludGVybmFsIGRlZmF1bHQuCj4gCj4gQW5kIGxlYXZlIG91ciBpbnRlcm5hbCBkZWZhdWx0IHRvIDhNQi4KPiAKPiBUaGF0IHdheSwgbm9ib2R5IG5lZWRzIHRvIGRvIGFueXRoaW5nIGRpZmZlcmVudGx5IGZyb20gaGlzIGN1cnJlbnQgYnVpbGQgCnNldC11cCwKPiBhbmQgSSBzdXNwZWN0IHRoYXQgaXQgd291bGQgbWFrZSBzdGVwICgxKSBvcHRpb25hbC4KPiAKCnNvbWV0aGluZyBsaWtlIHRoaXM6CgovKiBhbGxvdyBvdmVyd3JpdGluZyBmcm9tIGUuZy4gTWFrZWZpbGUgKi8KI2lmICFkZWZpbmVkKE1BWF9JT19TSVpFKQojIGRlZmluZSBNQVhfSU9fU0laRSAoOCoxMDI0KjEwMjQpCiNlbmRpZgovKiBmb3IgcGxhdHRmb3JtcyB0aGF0IGhhdmUgU1NJWkUgYW5kIGhhdmUgaXQgc21hbGxlciAqLwojaWYgZGVmaW5lZChTU0laRV9NQVggJiYgKF
 NTSVpFX01BWCA8IE1BWF9JT19TSVpFKSAKIyB1bmRlZiBNQVhfSU9fU0laRSAvKiBhdm9pZCB3YXJuaW5nICovCiMgZGVmaW5lIE1BWF9JT19TSVpFIFNTSVpFX01BWAojZW5kaWYKClN0ZXBzIDIgYW5kIDMgb25seSAsIGluZGVlZCBzdGVwIDEgbm90IG5lZWRlZC4uLgoKQnllLCBKb2pv
