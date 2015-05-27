From: Stephen Kelly <steveire@gmail.com>
Subject: Re: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated commits
Date: Wed, 27 May 2015 08:54:55 +0000 (UTC)
Message-ID: <loom.20150527T105315-517@post.gmane.org>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 10:55:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxX7I-0001nK-Gm
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 10:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbbE0IzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 04:55:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:44097 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbbE0IzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 04:55:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YxX76-0001hw-VA
	for git@vger.kernel.org; Wed, 27 May 2015 10:55:04 +0200
Received: from nat2.ableton.net ([217.110.199.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 May 2015 10:55:00 +0200
Received: from steveire by nat2.ableton.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 May 2015 10:55:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.110.199.118 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:37.0) Gecko/20100101 Firefox/37.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270038>

R2FsYW4gUsOpbWkgPHJlbWkuZ2FsYW4tYWxmb25zbyA8YXQ+IGVuc2ltYWcuZ3Jlbm9ibGUtaW5wLmZyPiB3cml0ZXM6Cgo+IAo+IENoZWNrIGlmIGNvbW1pdHMgd2VyZSByZW1vdmVkIChpLmUuIGEgbGluZSB3YXMgZGVsZXRlZCkgb3IgZHVwcGxpY2F0ZWQKPiAoZS5nLiB0aGUgc2FtZSBjb21taXQgaXMgcGlja2VkIHR3aWNlKSwgY2FuIHByaW50IHdhcm5pbmdzIG9yIGFib3J0Cj4gZ2l0IHJlYmFzZSBhY2NvcmRpbmcgdG8gdGhlIHZhbHVlIG9mIHRoZSBjb25maWd1cmF0aW9uIHZhcmlhYmxlCj4gcmViYXNlLmNoZWNrTGV2ZWwuCgpJIHNvbWV0aW1lcyBkdXBsaWNhdGUgY29tbWl0cyBkZWxpYmVyYXRlbHkgaWYgSSB3YW50IHRvIHNwbGl0IGEgY29tbWl0IGluCnR3by4gSSBtb3ZlIGEgY29weSB1cCBhbmQgZml4IHRoZSBjb25mbGljdCwgYW5kIEkga25vdyB0aGF0IEknbGwgc3RpbGwgZ2V0CnRoZSByaWdodCB0aGluZyBsYXRlciBldmVuIGlmIEkgbWFrZSBhIG1pc3Rha2Ugd2l0aCB0aGUgY29uZmxpY3QgcmVzb2x1dGlvbi4=
