From: Adrian Ang <adrian.c.ang@gmail.com>
Subject: Re: error opening
Date: Fri, 11 Sep 2015 21:33:42 +0000 (UTC)
Message-ID: <loom.20150911T232244-141@post.gmane.org>
References: <CAF2U6N0HzgWK-4D2Ednt46u_R+eL2-2C9g9GpczyAvj+pKv-EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 23:35:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaVyd-0008S8-7M
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 23:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbbIKVfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 17:35:14 -0400
Received: from plane.gmane.org ([80.91.229.3]:47880 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125AbbIKVfI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 17:35:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZaVyK-00083Y-N3
	for git@vger.kernel.org; Fri, 11 Sep 2015 23:35:04 +0200
Received: from mail02.westjet.com ([198.84.14.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 23:35:04 +0200
Received: from adrian.c.ang by mail02.westjet.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 23:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 198.84.14.10 (Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277697>

UmVuYXRvIEFrYWJvY2kgPHJlbmF0by5ha2Fib2NpIDxhdD4gZ21haWwuY29tPiB3cml0ZXM6Cgo+IAo+IEhpLAo+IAo+IEnCtG0gaW4gdHJvdWJsZSBqdXN0IGFmdGVyIGluc3RhbGxhdGlvbiBvZiBteSBHaXQgZm9yIFdpbmRvd3MuCj4gSSBnZXQgYSBib3ggd2l0aCBlcnJvciBzYXlpbmc6Cj4gCj4gY291bGRuwrR0IHJlYWQgZmlsZSAiQzpcUHJvZ3JhbQo+IEZpbGVzXEdpdFxjbWRcbWluZ3c2NFxsaWJleGVjXGdpdC1jb3JlXGdpdC1ndWkiOiBubyBzdWNoIGZpbGUgb3IKPiBkaXJlY3RvcnkKPiAKPiBJwrR2ZSBqdXN0IGluc3RhbGxlZCBnaXQgYXMgbm9ybWFsLiBHaXQgQmFzaCB3b3JrcyBwZXJmZWN0bHksIGFuZCBpZiBJCj4gY2FsbCAiZ2l0IGd1aSIgb24gYmFzaCBvciBjbWQsIGl0IG9wZW4uIEkgZ3Vlc3MgdGhhdCBpcyBzb21ldGhpbmcKPiBtaXNzaW5nIG9uIG15IG1hY2hpbmUsIGJ1dCBJIGRvbsK0dCBrbm93IHdoYXQuCj4gLSBNeSBPcGVyYXRpb25hbCBTeXN0ZW0gaXMgV2luZG93cyAxMCB4NjQKPiAKPiBBbnkgYWR2aWNlIHdpbGwgYmUgYXBwcmVjaWF0ZWQuCj4gVGhhbmtzIGluIGFkdmFuY2UKPiAKCgpJJ20gaGF2aW5nIHRoZSBleGFj
 dCBzYW1lIHByb2JsZW0uIAoKSW5zdGFsbGF0aW9uIHByb2NlZWRzIG5vcm1hbGx5LCBidXQgdHJ5aW5nIHRvIG9wZW4gR2l0IEdVSSB3aWxsIGFsd2F5cyAKZmFpbCB3aXRoIHRoZSBzYW1lIGVycm9yIG1lc3NhZ2UgeW91IGhhdmUuCgpJIHRyaWVkIHNlYXJjaGluZyB0aGUgUmVnaXN0cnkgdG8gc2VlIGlmIHRoaXMgaXMgYSBtaXNjb25maWd1cmF0aW9uIApzb21ld2hlcmUsIGJ1dCBubyBzdWNoIHNldHRpbmcgZXhpc3RzIGluIG15IHJlZ2lzdHJ5LiBJIGRvbid0IGtub3cgaWYgCnRoaXMgY29uZmlndXJhdGlvbiBpcyBiYWtlZCBpbnRvIHRoZSBXaW5kb3dzIHg2NCBHaXQgR1VJIGV4ZWN1dGFibGUgb3IgCnNldCBpbiBhbiBpbmkgb3IgY29uZmlnIGZpbGUgc29tZXdoZXJlLgoKSSdtIHRyeWluZyB0byBkb2N1bWVudCB0aGUgaW5zdGFsbCBwcm9jZXNzIGZvciBteSB0ZWFtJ3MgaW1wbGVtZW50YXRpb24gCm9mIGdpdC4gSWYgdGhpcyBpc3N1ZSBjYW4ndCBiZSByZXNvbHZlZCwgb3IgaWYgcHJldmlvdXMgV2luZG93cyAKaW5zdGFsbGVyIHZlcnNpb25zIGFyZW4ndCBhdmFpbGFibGUsIG15IHRlYW0ncyBnaXQgaW1wbGVtZW50YXRpb24gaXMgCmJsb2
 NrZWQuCgpXZSBjb3VsZCB0cnkgdG8gc2ltcGx5IGNvcHkgdGhlICJtaXNzaW5nIiBzdWJkaXJlY3RvcnkgKHdoaWNoIGFjdHVhbGx5IApkb2VzIGV4aXN0IHNvbWV3aGVyZSBlbHNlKSBpbnRvIHRoZSAiY21kIiBzdWJkaXJlY3RvcnksIGJ1dCB0aGF0IHdvdWxkIApzZWVtIHJlYWxseSBjbHVtc3kgYW5kIGl0IHdpbGwgYWZmZWN0IHRoZSB0ZWFtIG1lbWJlcnMnIGZpcnN0IAppbXByZXNzaW9ucyBvZiBnaXQuIFdlJ3JlIHRyeWluZyB0byBtb3ZlIGZyb20gU1ZOIHRvIGdpdCwgYW5kIG1vc3Qgb2YgbXkgCnRlYW0gbWVtYmVycyBoYXZlIG5vdCB1c2VkIGdpdCBiZWZvcmUuCgpBbnkgYXNzaXN0YW5jZSBvciByZXBseSBmcm9tIHRoZSBkZXZzIHdvdWxkIGJlIGFwcHJlY2lhdGVkLiAgVGhhbmsgeW91LgoKCg==
