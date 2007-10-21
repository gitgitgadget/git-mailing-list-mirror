From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: Announcement of Git wikibook
Date: Sat, 20 Oct 2007 23:09:27 -0400
Message-ID: <20071021030927.GA19450@dervierte>
References: <428b865e0710191321ndd08564yec6366cb10705af6@mail.gmail.com> <C0D5CAE0-A152-4572-81D5-AF2A78DD89C6@zib.de> <8e04b5820710200040q76301c58j33e5d0895956b150@mail.gmail.com> <Pine.LNX.4.64.0710202232280.25221@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Cc: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Evan Carroll <me@evancarroll.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 21 05:09:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjRCH-0006Bs-CK
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 05:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbXJUDJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 23:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbXJUDJj
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 23:09:39 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:51505 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbXJUDJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 23:09:38 -0400
Received: by py-out-1112.google.com with SMTP id u77so1753998pyb
        for <git@vger.kernel.org>; Sat, 20 Oct 2007 20:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=i95R+iG4/X8VnPZpfonvdOIeThmEloOWjRlnNtRZspE=;
        b=fHuMGGhCYLPS348s6gx94TfalFOvWP1PZYHtwRcQJdzQiRVhX5tlqa3T99Q5vtDTvlHvmVsUsHdCJK/fEx8x7X7lVP0q38kGNHxdjCKpv1BOUPIuU+NzVmTGgluf4ip54CvIDFfLWrQGM9a5ZDSVQ7iVarO2f35+LVZ53po15PM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=uhxlvDn75mhzY7os95PYl+ogqRKROgRb6ou9UDhN0KUKxwEC4zZU4H7pp+cJU2Ohl79dlI7aPAs5HUeAJEPvYJr0CfDx3y9GTOUhmY3vxnCRYE5B7G/rhLD0CmDOcD7b9WplCUswQJcc6GhXaEF4gbajMkQUyURwgQ9g8sT2hgs=
Received: by 10.65.35.6 with SMTP id n6mr6632720qbj.1192936176963;
        Sat, 20 Oct 2007 20:09:36 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.36.23])
        by mx.google.com with ESMTPS id 22sm1880058nzn.2007.10.20.20.09.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Oct 2007 20:09:35 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id EDDF0CA5583; Sat, 20 Oct 2007 23:09:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710202232280.25221@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61870>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 20, 2007 at 10:34:34PM +0100, Johannes Schindelin wrote:
> I am torn.  On one side I like the Wiki approach.  On the other hand, the=
=20
> Wiki will get less review by git oldtimers, whereas the patches to=20
> user-manual are usually reviewed as thoroughly as the code patches.

No offense, but review by old timers can be both a blessing and a curse.
Well, it's not the "review" that is so much a problem as the "editorial
control."  In my opinion (and I believe this is what the original poster
was saying), the official Git User Manual focuses more on technical
issues and less on introducing git to a new user.

This makes perfect sense given that it's edited by oldtimers, who are
neither inclined nor particularly suited to explaining git to newbies;
they have simply forgotten what it was like for these concepts to be
foreign.  They eat SHA1 hashes for breakfast and dream about index
files.  And that's great :)

I don't think the wikibook should try to duplicate the Git User Manual.
That would be a wasted effort.  But there is a niche to be filled in git
documentation, particularly in regard to specific workflows and git best
practices.  With git, TMTOWTDI.  It's quite difficult for a newbie to
know which of those ways will come back and bite them in the ass down the
road.

Of course, it is a wikibook, so it will go where it goes.  I for one am
glad to see this project started.
--=20
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 =3D 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F=20

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHGsLn/IGXd9wono8RApExAJ99v7B857uHJYA9JXyR7whOutQkjACgmmSo
qMPYLeOHsOLMqddiPCG/eG0=
=U3Uo
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
