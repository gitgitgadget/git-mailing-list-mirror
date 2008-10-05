From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Numeric Revision Names?
Date: Sun, 5 Oct 2008 11:19:38 +0200
Message-ID: <81b0412b0810050219t31b0c71dhdafb7b94070657ac@mail.gmail.com>
References: <19796862.post@talk.nabble.com>
	 <m3d4ihr7as.fsf@localhost.localdomain>
	 <20081003115557.08d80c2f.stephen@exigencecorp.com>
	 <200810031913.55594.trast@student.ethz.ch>
	 <20081003124224.843a5a21.stephen@exigencecorp.com>
	 <b8bf37780810042013g57fc7073xd638e44bb666bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Stephen Haberman" <stephen@exigencecorp.com>,
	"Thomas Rast" <trast@student.ethz.ch>,
	"Jakub Narebski" <jnareb@gmail.com>,
	marceloribeiro <marcelo@sonnay.com>, git@vger.kernel.org
To: "=?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?=" <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 11:20:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmPnI-0006OJ-0d
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 11:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYJEJTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 05:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbYJEJTk
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 05:19:40 -0400
Received: from rn-out-0910.google.com ([64.233.170.184]:13609 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbYJEJTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 05:19:39 -0400
Received: by rn-out-0910.google.com with SMTP id k40so727759rnd.17
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=la5k2aUQYRK2x7m2oW/9KIiBx7FD70FgX7V/WFTfmvo=;
        b=rOE/EcnLhzja1W4i4pX3L25nIaXrvsQzNI91kddqKrpt8aQVH7IuXEoKr2voez0TbE
         RSEhuYgmmGC/PwDad8IO7HwcYkCZDkqoSyFJtuiGklXeJTLaR2kgfOfCuhDJ1WcY/ofU
         QSraB1iKIjYnCYen3ZuxRFglAdtjZCd6p+dOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ORJX7AjpITy5ULT/z84Zo+7dQyHoTyXzJ/OSYYwJxtPgsW869j57Rm/uC54tau0I0p
         ZtqNyynwhsjS7yx3VHchgXEPMWCo7fq0PC28HbWKuFYWQvJMJF4EG7pgk9xqp1eM/RGY
         xQaPLbv7A97MTsgm+HTavh1ZqJCjySdbhz6uo=
Received: by 10.100.91.17 with SMTP id o17mr3464260anb.85.1223198378326;
        Sun, 05 Oct 2008 02:19:38 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Sun, 5 Oct 2008 02:19:38 -0700 (PDT)
In-Reply-To: <b8bf37780810042013g57fc7073xd638e44bb666bf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97503>

MjAwOC8xMC81IEFuZHLDqSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21haWwuY29tPjoK
PiBUaGlzIGlzIHNvIHRydWUgaW4gYSBjb3Jwb3JhdGUgZW52aXJvbm1lbnQgd2l0aCBjZW50cmFs
aXplZAo+IHJlcG9zaXRvcmllcywgdGhlbiBJIGNvbXBsZXRlbHkgYWdyZWUKPiB0aGF0IGluIHRo
ZSBjYXNlIGdpdCBpcyBiZWluZyB1c2VkIGluIHRoaXMgbW9kZWwgKG1hbnkgY29tcGFuaWVzIGFy
ZQo+IHJlYWxseSB1c2VkIHRvIHRoYXQpLCB0aGUKPiBtb25vdG9uaWMgcmV2aXNpb24gbnVtYmVy
IGlzIGhlbHBmdWwgYW5kIHNvbWV0aW1lcyBpcyBzaG93c3RvcHBlciB0bwo+IG5vdCBoYXZlIHRo
ZW0uCgpCdXQgeW91IGRvIGhhdmUgdGhlbSwgZXZlbiBub3cuIFdpdGggdGhhdCBzaW1wbGUgaG9v
ayBzY3JpcHQuCgpBbmQgb3V0c2lkZSBvZiB5b3VyIHNtYWxsIGNvcnBvcmF0aW9uIG5vb25lIG5l
ZWRzIHRoZW0KKGFuZCB5b3VyIGNvbXBhbnkgZG9lc24ndCBuZWVkIHRoZW0gZWl0aGVyLCB0aGV5
IGp1c3QgY2FuJ3QKZ2V0IG92ZXIgdGhlIG1pbmRzZXQgb2YgcmNzIG9yIHZtcyBuYXRpdmUgdmVy
c2lvbmluZyBvciB3aGF0ZXZlcgplbHNlIHRoZXkncmUgcGxhaW5seSB1c2VkIHRvKS4K
