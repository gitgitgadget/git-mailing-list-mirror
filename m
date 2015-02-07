From: Joachim Schmitz <jojo@schmitz-digital.de>
Subject: Re: read()  =?utf-8?b?TUFYX0lPX1NJWkU=?= bytes, more than =?utf-8?b?U1NJWkVfTUFYPw==?=
Date: Sat, 7 Feb 2015 18:36:35 +0000 (UTC)
Message-ID: <loom.20150207T193242-470@post.gmane.org>
References: <loom.20150207T174514-727@post.gmane.org> <54D64939.4080102@web.de> <01f201d04300$cce22ca0$66a685e0$@nexbridge.com> <01f501d04302$bb9a46b0$32ced410$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 19:36:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKAFM-00016D-7e
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 19:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624AbbBGSgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 13:36:43 -0500
Received: from plane.gmane.org ([80.91.229.3]:55450 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756634AbbBGSgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 13:36:43 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YKAFF-00011g-EQ
	for git@vger.kernel.org; Sat, 07 Feb 2015 19:36:41 +0100
Received: from dslb-188-109-251-074.188.109.pools.vodafone-ip.de ([188.109.251.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 19:36:41 +0100
Received: from jojo by dslb-188-109-251-074.188.109.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 19:36:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.109.251.74 (Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263451>

UmFuZGFsbCBTLiBCZWNrZXIgPHJzYmVja2VyIDxhdD4gbmV4YnJpZGdlLmNvbT4gd3JpdGVzOgoKPiAKPiBPbiAyMDE1LTAyLTA3IDEzOjA3UE0gUmFuZGFsbCBTLiBCZWNrZXIgd3JvdGU6Cj4gPk9uIDIwMTUtMDItMDcgMTI6MzBQTSBUb3JzdGVuIELDtmdlcnNoYXVzZW4gd3JvdGU6Cj4gPj5PbiAyMDE1LTAyLTA3IDE3LjQ1LCBKb2FjaGltIFNjaG1pdHogd3JvdGU6CjxzcGlwPiAKPiBBbHRob3VnaCBJIGRvIGFncmVlIHdpdGggSm9qbywgdGhhdCBNQVhfSU9fU0laRSBzZWVtcyB0byBiZSBhIHBsYXRmb3JtCj4gY29uc3RhbnQgYW5kIHNob3VsZCBiZSBkZWZpbmVkIGluIHRlcm1zIG9mIFNTSVpFX01BWC4gU28gc29tZXRoaW5nIGxpa2U6Cj4gCj4gI2lmbmRlZiBNQVhfSU9fU0laRQo+ICMgaWZkZWYgU1NJWkVfTUFYCj4gIyAgZGVmaW5lIE1BWF9JT19TSVpFIChTU0laRV9NQVgpCj4gIyBlbHNlCj4gIyAgZGVmaW5lIE1BWF9JT19TSVpFICg4KjEwMjQqMTAyNCkKPiAjIGVuZGlmCj4gI2VuZGlmCj4gCj4gd291bGQgYmUgZGVzaXJhYmxlLgoKSXQgd291bGQgYmUgd2F5IHRvbyBsYXJnZSBvbiBzb21lIHBsYXRmb3Jtcy4gdGhvc2UgOE1CIGhhZCBi
 ZWVuIGNob3NlbiBmb3IgCmEgZ29vZCByZWFzb24sIEkgYXNzdW1lOgoKLyoKICogTGltaXQgc2l6ZSBvZiBJTyBjaHVua3MsIGJlY2F1c2UgaHVnZSBjaHVua3Mgb25seSBjYXVzZSBwYWluLiAgT1MgWAogKiA2NC1iaXQgaXMgYnVnZ3ksIHJldHVybmluZyBFSU5WQUwgaWYgbGVuID49IElOVF9NQVg7IGFuZCBldmVuIGluCiAqIHRoZSBhYnNlbmNlIG9mIGJ1Z3MsIGxhcmdlIGNodW5rcyBjYW4gcmVzdWx0IGluIGJhZCBsYXRlbmNpZXMgd2hlbgogKiB5b3UgZGVjaWRlIHRvIGtpbGwgdGhlIHByb2Nlc3MuCiAqLwoKSG93ZXZlciBpdCBzaG91bGQgbmV2ZXIgYmUgbGFyZ2VyIHRoYW4gU1NJWkVfTUFYCgo=
