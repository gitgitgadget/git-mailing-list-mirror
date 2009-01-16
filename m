From: "=?UTF-8?Q?Jonas_Flod=C3=A9n?=" <jonas@floden.nu>
Subject: [PATCH/RFC] git-am: Make it easier to see which patch failed
Date: Fri, 16 Jan 2009 14:18:39 +0100
Message-ID: <636ecac0901160518o16706bbia9acaf09fdf92946@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 14:20:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNocH-0008WN-RI
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765019AbZAPNSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 08:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764360AbZAPNSm
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:18:42 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:19445 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763146AbZAPNSk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 08:18:40 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1875471wfd.4
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 05:18:39 -0800 (PST)
Received: by 10.142.125.9 with SMTP id x9mr1043571wfc.38.1232111919517;
        Fri, 16 Jan 2009 05:18:39 -0800 (PST)
Received: by 10.142.253.12 with HTTP; Fri, 16 Jan 2009 05:18:39 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105956>

V2hlbiBnaXQtYW0gZmFpbHMgaXQncyBub3QgYWx3YXlzIGVhc3kgdG8gc2VlIHdoaWNoIHBhdGNo
IGZhaWxlZCwKc2luY2UgaXQncyBvZnRlbiBoaWRkZW4gYnkgYSBsb3Qgb2YgZXJyb3IgbWVzc2Fn
ZXMuCkFkZCBhbiBleHRyYSBsaW5lIHdoaWNoIHByaW50cyB0aGUgbmFtZSBvZiB0aGUgZmFpbGVk
IHBhdGNoIGp1c3QKYmVmb3JlIHRoZSByZXNvbHZlIG1lc3NhZ2UgdG8gbWFrZSBpdCBlYXNpZXIg
dG8gZmluZC4KClNpZ25lZC1vZmYtYnk6IEpvbmFzIEZsb2TDqW4gPGpvbmFzQGZsb2Rlbi5udT4K
LS0tCgpUaGlzIGlzIHNvbWV0aGluZyBJIGhhdmUgdGhvdWdodCBhYm91dCBmb3IgYSBsb25nIHRp
bWUuCkkgYWx3YXlzIHdvbmRlciB3aHkgZ2l0IHJlYmFzZSBjb3VsZG4ndCBwcmludCB0aGUgcGF0
Y2gKbmFtZSB3aGVuIGl0IGZhaWxlZC4uLiBGaW5hbGx5IEkgdG9vayB0aGUgdGltZSB0byBmaXgg
aXQuClBsZWFzZSBmZWVsIGZyZWUgdG8gY29tbWVudC4gSXQncyBteSBmaXJzdCBHaXQgcGF0Y2gu
Li4KCldpdGggcmVnYXJkcywKSm9uYXMKCiBnaXQtYW0uc2ggfCAgICAxICsKIDEgZmlsZXMgY2hh
bmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1h
bS5zaCBiL2dpdC1hbS5zaAppbmRleCA0YjE1N2ZlLi41ZDcyYTY2IDEwMDc1NQotLS0gYS9naXQt
YW0uc2gKKysrIGIvZ2l0LWFtLnNoCkBAIC01MDIsNiArNTAyLDcgQEAgZG8KIAlpZiB0ZXN0ICRh
cHBseV9zdGF0dXMgIT0gMAogCXRoZW4KIAkJZWNobyBQYXRjaCBmYWlsZWQgYXQgJG1zZ251bS4K
KwkJcHJpbnRmICdcbkZhaWxlZCB0byBhcHBseTogJXNcbicgIiRGSVJTVExJTkUiCiAJCXN0b3Bf
aGVyZV91c2VyX3Jlc29sdmUgJHRoaXMKIAlmaQoKLS0gCjEuNi4xLjI4LmdjMzJmNzYK
