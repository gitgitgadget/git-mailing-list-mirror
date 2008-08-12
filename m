From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: How to show an annotated tag's timestamp?
Date: Tue, 12 Aug 2008 22:35:44 +0200
Message-ID: <237967ef0808121335s499fbdbbgaaf5a15c511a2246@mail.gmail.com>
References: <48A1E739.3010803@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?UTF-8?Q?Dirk_S=C3=BCsserott?=" <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Tue Aug 12 22:37:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT0bo-0001TM-Ru
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 22:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbYHLUfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 16:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYHLUfq
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 16:35:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:47319 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbYHLUfp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 16:35:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so942873nfc.21
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1lPyjCu+PCq4yVQS6dKCz9NTSyjAtu9EH4fKTwQDEak=;
        b=uNymopsx+F16f8cjzWnBI2VUbJlui733b1ep0XbXbd6io79arz7w3s1+ea2wxWc6Ue
         pu0KWhH/SFfD9Y7GXuRU6p8aLzd5KLcVvlrwJQclbJRqBG1+daqR7DS0CyBdiALgnDiu
         UTy5iOda750iJVXfNmAdM/l4l52UNYO9dP12g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=q38PH0+cAJ43W4rxeIDR7mrCx+474TogzJlhqurwwkNg6qLNdIyqv4BF2SiDrAsbq0
         Xi09M+9ZX/DOBWC8ijMubJgywY3EO+8uGUOUfnn/OEnbsO8VQw7d00frIOATFjMUIYPC
         URdTux9EuuBsj4akKVr8YvbIyBIxfa5qQ/Fbo=
Received: by 10.210.126.5 with SMTP id y5mr10880871ebc.29.1218573344090;
        Tue, 12 Aug 2008 13:35:44 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Tue, 12 Aug 2008 13:35:44 -0700 (PDT)
In-Reply-To: <48A1E739.3010803@dirk.my1.cc>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92136>

MjAwOC84LzEyIERpcmsgU8O8c3Nlcm90dCA8bmV3c2xldHRlckBkaXJrLm15MS5jYz46Cj4gSSdk
IGxpa2UgdG8gZGlzcGxheSAqd2hlbiogYSBjZXJ0YWluIGFubm90YXRlZCB0YWcgd2FzCj4gY3Jl
YXRlZCwgaS5lLiBpdHMgdGltZXN0YW1wLiBJIGtub3cgdHdvIHdheXMgYnV0IGFtIGxvb2tpbmcK
PiBmb3IgYSB0aGlyZCBvbmU6Cj4KPiBHaXRrOiBXaGVuIGNsaWNraW5nIHRoZSB5ZWxsb3cgdGFn
IGl0ZW0gKGNhbGxlZCAndGVzdHRhZycKPiBpbiBteSBjYXNlKSBpdCBzYXlzOgo+IC0tLS0tLS0t
LS0tLS0KPiBvYmplY3QgOWEwNGEyNmQzZTVlYTA5YmUzMjkzNGY1MDAyMGQwMjg2ZWJlNzMyNQo+
IHR5cGUgY29tbWl0Cj4gdGFnIHRlc3R0YWcKPiB0YWdnZXIgPHRhZ2dlcidzIG5hbWU+IDx0YWdn
ZXIncyBlbWFpbC1hZGRyZXNzPiAxMjE4NTY4MzAwICswMjAwCj4gLS0tLS0tLS0tLS0tLQo+IFdl
bGwsIEkgY2FuIGNvbnZlcnQgMTIxODU2ODMwMCBpbnRvIHNvbWUgaHVtYW4gcmVhZGFibGUgc3Ry
aW5nLAo+IGJ1dCB0aGF0J3Mgbm90IGNvbnZlbmllbnQuCj4KPiBTbyBJIHRyaWVkICdnaXQgc2hv
dyB0ZXN0dGFnJy4gSXQgc2F5czoKPiAtLS0tLS0tLS0tLS0tCj4gKCopIHRhZyB0ZXN0dGFnCj4g
KCopIFRhZ2dlcjogPHRhZ2dlcidzIG5hbWU+IDx0YWdnZXIncyBlbWFpbC1hZGRyZXNzPgo+ICgq
KSBEYXRlOiAgIFR1ZSBBdWcgMTIgMjE6MTc6MTcgMjAwOCArMDIwMAo+ICgqKQo+ICgqKSB0ZXN0
dGFnCj4gY29tbWl0IDBhNjJiMzM4MGQyMWJmNjUyNzA0OTA2MTlkYTRhMmVmZDZkMmNhN2EKPiBB
dXRob3I6IC4uLgo+IERhdGU6ICAgVGh1IEFwciAyNCAxODo0OTozOCAyMDA4ICswMjAwCj4gWy4u
Ll0KPiAtLS0tLS0tLS0tLS0tCj4KPiAuLi4gZm9sbG93ZWQgYnkgdGhlIHdob2xlIGNvbW1pdCBt
ZXNzYWdlIGFuZCBkaWZmIG9mIHRoZQo+IGNvbW1pdCB0aGF0J3MgcG9pbnRlZCB0byBieSB0aGUg
dGFnLiBUaGF0J3MgdG9vIG11Y2ggZm9yCj4gbXkgcHVycG9zZS4KPgo+IElzIHRoZXJlIGEgd2F5
IHRvIG91dHB1dCBvbmx5IHdoZW4gYW5kIGJ5IHdob20gdGhlIHRhZwo+IHdhcyBjcmVhdGVkIChp
bmNsLiB0aGUgdGFnJ3MgbWVzc3NhZ2UpLCBpLmUuIHRoZSBsaW5lcwo+IGFib3ZlIG1hcmtlZCB3
aXRoICgqKT8KCiUgZ2l0IHNob3cgLXMgLS1wcmV0dHk9Zm9ybWF0OiB2MS42LjAtcmMyCnRhZyB2
MS42LjAtcmMyClRhZ2dlcjogSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPgpEYXRl
OiAgIFdlZCBBdWcgNiAxNDowMDo0MSAyMDA4IC0wNzAwCgpHSVQgMS42LjAtcmMyCi0tLS0tQkVH
SU4gUEdQIFNJR05BVFVSRS0tLS0tClZlcnNpb246IEdudVBHIHYxLjQuNiAoR05VL0xpbnV4KQoK
aUQ4REJRQkltaEQ4d01iWnBQTVJtNW9SQXByR0FKNGsrMitqVEk5VC9EVFA5cXdhVWpmZ0lRRmRF
QUNkR2p4MAphZi9Vc1JINXFwZVJIUThmM2VDTmQ1ND0KPVM5UE8KLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCgoKLS0gCk1pa2FlbCBNYWdudXNzb24K
