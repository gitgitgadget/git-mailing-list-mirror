From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Git and Media repositories....
Date: Sun, 9 Nov 2008 11:58:41 +0700
Message-ID: <fcaeb9bf0811082058i2d0dab9et3de216f7bdb8036d@mail.gmail.com>
References: <1225655428.11693.10.camel@vaio>
	 <adf1fd3d0811070519qc54369vf0da3bc28182460a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Tim Ansell" <mithro@mithis.com>, git@vger.kernel.org
To: "=?UTF-8?Q?Santi_B=C3=A9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 06:00:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kz2P3-00048I-CL
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 06:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbYKIE6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 23:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbYKIE6p
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 23:58:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:4063 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbYKIE6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 23:58:44 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1727563fgg.17
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 20:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VK3W0zzEr4FX09t9C4VYUcQGb8qmWuX85p5bXUcbw70=;
        b=bNLawl9M5PVVNS4DadwTReSbpJR6fDHqK/ts11T01i3AEL4URhFObhNpMmDHWVy+nk
         bXrLEvQsyslzJX2tV2Bm+UpXGAfJn/ywoBx8v9/LWgCYlZl2qmk2E/A+1spfwhI/qrXu
         oe57RoMYDEK0gWphvGla/LJFlS4XAjSmNbrRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JoaS8cgEO2pkHs9TRZUQ5cdkaUDJOaU8clwg/3dlMcLHlQO7Kf6uVHLcRxA1DNeCSa
         qQ1rgVfT0huhS/1ppVQuvXYJ+x28rlbALgyMU96OWfvhV0AImQsNPIRBaLZma3mPwihQ
         JKUQ2JOWWljJY6DXVYSLfUAWFBn786V9BxoA0=
Received: by 10.86.28.2 with SMTP id b2mr5794138fgb.54.1226206721652;
        Sat, 08 Nov 2008 20:58:41 -0800 (PST)
Received: by 10.86.27.20 with HTTP; Sat, 8 Nov 2008 20:58:41 -0800 (PST)
In-Reply-To: <adf1fd3d0811070519qc54369vf0da3bc28182460a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100435>

T24gMTEvNy8wOCwgU2FudGkgQsOpamFyIDxzYW50aUBhZ29saW5hLm5ldD4gd3JvdGU6Cj4gT24g
U3VuLCBOb3YgMiwgMjAwOCBhdCA4OjUwIFBNLCBUaW0gQW5zZWxsIDxtaXRocm9AbWl0aGlzLmNv
bT4gd3JvdGU6Cj4gID4gSGV5IGd1eXMsCj4gID4KPgo+ICBbLi4uXQo+Cj4KPiAgPgo+ICA+IFRo
ZSBnZW5lcmFsIGlkZWEgaXMgdGhhdCB3ZSBhbHdheXMgY2xvbmUgdGhlIGNvbXBsZXRlIG1ldGEt
ZGF0YSAodGFncywKPiAgPiBjb21taXRzIGFuZCB0cmVlcykgYW5kIHRoZW4gb25seSBjbG9uZSBi
bG9icyB3aGVuIHRoZXkgYXJlIG5lZWRlZCAodXNpbmcKPiAgPiBzb21ldGhpbmcgbGlrZSBhbHRl
cm5hdGVzKS4gVGhpcyBhbGxvd3MgdXMgdG8gc3VwcG9ydCBzaGFsbG93LCBuYXJyb3cKPiAgPiBh
bmQgc3BhcnNlIGNoZWNrb3V0cyB3aGlsZSBzdGlsbCBiZWluZyBhYmxlIHRvIHBlcmZvcm0gb3Bl
cmF0aW9ucyBzdWNoCj4gID4gYXMgY29tbWl0dGluZyBhbmQgbWVyZ2luZy4KPiAgPgo+Cj4KPiBB
IHJlbGF0ZWQgdXNlIGNhc2UgY291bGQgYmUgdG8gcmVtb3ZlIGEgYmxvYiBmcm9tIGEgcmVwbyBi
dXQgYmVpbmcKPiAgYWJsZSB0byB3b3JrIG5vcm1hbGx5IHdpdGggaXQsIHNpbWlsYXIgdG86Cj4K
PiAgaHR0cDovL3dpa2kuZnJlZWJzZC5vcmcvVkNTRmVhdHVyZU9ibGl0ZXJhdGUKCk1heWJlIGFu
b3RoZXIgdXNlIGNhc2U6IGVuY3J5cHRlZCBibG9icyAodGhvc2UgYXJlIGdlbmVyYWxseQp1bmF2
YWlsYWJsZSB1bnRpbCBjb3JyZWN0ZWQgcGFzc3dvcmQgaXMgZ2l2ZW4sIHNvIHRoZXkgYXJlICJo
b2xlcyIgaW4KY2hlY2tvdXQvY2xvbmUpLiBJdCBjb3VsZCBiZSB1c2VkIHRvIHN0b3JlIHNlbnNp
dGl2ZSBjb250ZW50IChpbiAkSE9NRQpmb3IgZXhhbXBsZSkKLS0gCkR1eQo=
