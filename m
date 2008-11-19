From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: removing svn remotes
Date: Wed, 19 Nov 2008 16:26:13 -0500
Message-ID: <1c5969370811191326j46b8ae1r6e916c239cc6be82@mail.gmail.com>
References: <1c5969370811181747i240ed22bk73ca62e09b3d0172@mail.gmail.com>
	 <20081119083219.GB3538@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "=?UTF-8?Q?Bj=C3=B6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 19 22:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2uaF-0000hf-D2
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 22:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbYKSV0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 16:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYKSV0Q
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 16:26:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:42538 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbYKSV0P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 16:26:15 -0500
Received: by ug-out-1314.google.com with SMTP id 39so97902ugf.37
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 13:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OIfMYc0mEH/6oW3g7EbpX6H0LVp/dNaFPx8glzsPikg=;
        b=gbHu92smwIxkMlcOe6mcLFlW03/k6PF6FWDBeh8VkBeKnBrqAz5PeHoYNhTv8wnEJx
         9Wf3LrXwtfR3YC18ZReq3eW61MkeiQmdVnaC2yMSNl8UtJWpQLeGOT9QGSYGGTSNAsdl
         NzsWdsqESsGnI4i4ub3uC5YpAYUX6jJGi9dPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=A3HorrjoCHKrY1L4HRhomVsxeBd7dVLSc2Lg5K1BxRZVBerx+4Nbs1cDt5bBoGsolH
         3MRXRELHwq0vT+wIGf/JFWThSmMc2UGy1j0gGHkLe3lCdP2zTCEENirbdYbR+0fpa/xi
         6px6KauzuJbmglJIFTxpoH5NztJ6eKpvmumMg=
Received: by 10.187.239.18 with SMTP id q18mr323774far.16.1227129973152;
        Wed, 19 Nov 2008 13:26:13 -0800 (PST)
Received: by 10.187.187.7 with HTTP; Wed, 19 Nov 2008 13:26:13 -0800 (PST)
In-Reply-To: <20081119083219.GB3538@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101377>

T24gV2VkLCBOb3YgMTksIDIwMDggYXQgMDM6MzIsIEJqw7ZybiBTdGVpbmJyaW5rIDxCLlN0ZWlu
YnJpbmtAZ214LmRlPiB3cm90ZToKPiBPbiAyMDA4LjExLjE4IDIwOjQ3OjI0IC0wNTAwLCBNYXR0
IEdyYWhhbSB3cm90ZToKPj4gSGksCj4+IEkgaGF2ZSBhIHN2biByZXBvIGNsb25lZCBpbnRvIGEg
Z2l0IHJlcG8uICBUaGVyZSBhcmUgc2V2ZXJhbCByZW1vdGUKPj4gcmVmcyB0aGF0IGFyZSB0aGVy
ZSB0aGF0IEkgZG9uJ3QgY2FyZSBhYm91dCBhbmQgZG9uJ3Qgd2FudCB0byBmZXRjaC4KPj4KPj4g
Z2l0IHN2biBmZXRjaCAtLWZldGNoLWFsbCBnZXRzIGEgYnVuY2ggb2Ygc3R1ZmYgZnJvbSBicmFu
Y2hlcyBJIGRvbid0IHdhbnQKPj4gZ2l0IHN2biBmZXRjaCByZXF1aXJlcyBJIGNoZWNrb3V0IHRo
ZSBicmFuY2hlcyBJIGNhcmUgYWJvdXQgYmVmb3JlIGZldGNoaW5nCj4+Cj4+IGdpdCBzdm4gZmV0
Y2ggZG9lc24ndCBhY2NlcHQgYSBicmFuY2ggbmFtZQo+PiBnaXQgcmVtb3RlIHJtIGlzbid0IGFi
bGUgdG8gc2VlIHRoZSBzdm4gcmVtb3Rlcwo+Pgo+PiBJcyB0aGVyZSBhIHdheSB0byBlaXRoZXI6
Cj4+IDEpIGdldCByaWQgb2YgdGhlIHN2biByZW1vdGVzIHRoYXQgSSBkb24ndCB3YW50Pwo+PiAy
KSBmZXRjaCBvbmx5IHRoZSByZW1vdGVzIHRoYXQgSSBkbyB3YW50Pwo+Cj4gVWhtLCBhcmUgeW91
IHRhbGtpbmcgYWJvdXQgcmVtb3RlIHRyYWNraW5nIGJyYW5jaGVzICh3aGF0ICJnaXQgYnJhbmNo
Cj4gLXIiIHNob3dzKSwgb3Igc3ZuLXJlbW90ZXMgKG5vdCBzdXJlIGlmIGdpdC1zdm4gY2FuIGxp
c3QgdGhlbSwgdGhleSdyZQo+IGluIC5naXQvY29uZmlnKT8KPgo+IFRoZSBiZWhhdmlvdXIgeW91
IGRlc2NyaWJlIGRvZXNuJ3QgbWF0Y2ggbXkgZXhwZXJpZW5jZSB3aXRoIGdpdC1zdm4sIHNvCj4g
bWF5YmUgeW91IGNvdWxkIGVsYWJvcmF0ZSBhIGJpdCBvbiB0aGUgZXhhY3QgcHJvYmxlbT8KClNv
cnJ5IHRoZSBxdWVzdGlvbiB3YXMgbm90IGNsZWFyLgoKZ2l0IGJyYW5jaCAtciAtZApkaWQgZXhh
Y3RseSB3aGF0IEkgbmVlZC4gIEkgZ3Vlc3MgSSBqdXN0IGRpZG4ndCBrbm93IGhvdyB0byBhc2sg
Zm9yCml0LiAgQW5vdGhlciBoYXBweSBkaXNjb3ZlcnkuCgpVc2luZyBnaXQgYnJhbmNoIC1yIC1k
LCBJIHdhcyBhYmxlIHRvIGRlbGV0ZSBteSBzdm4tcmVtb3Rlcy4KTm93IHdoZW4gSSBydW4gZ2l0
IHN2biBmZXRjaCAtLWZldGNoLWFsbCwgaXQgYXBwZWFycyB0byBmZXRjaCBvbmx5CmZyb20gdGhl
IHJlbWFpbmluZyBicmFuY2hlcyB0aGF0IEkgZGlkbid0IGRlbGV0ZS4gIEkgaG9wZSB0aGF0CmNs
YXJpZmllcyBpdC4KCnRoYW5rIHlvdSEK
