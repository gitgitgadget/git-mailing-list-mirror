From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] add option to find zlib in custom path
Date: Wed, 1 Aug 2007 03:01:56 +0200
Message-ID: <20070801010156.GF29424@schiele.dyndns.org>
References: <20070729183545.GC29424@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 03:02:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG2bL-0003dZ-RP
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 03:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422AbXHABCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 21:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756378AbXHABCG
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 21:02:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:36874 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbXHABCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 21:02:03 -0400
Received: by nf-out-0910.google.com with SMTP id g13so14793nfb
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 18:02:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=umWSXhOtKYj4vV0Fg+u6zLr7hfOdvlYysvP84cFeb7rWnUTs0ECL9NInj0PVRx8M4moHfssY2PGCeAp+M+KOJ5Sk8h+PKMvjwOMFgrAs1vyBTU/E0qhUr5yKa+14ooJrRWupnB1VmVyk85nSLD4O8cJWxz7oVzGy868Y0eakkKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=q2B/P6aPDXxOYhNYHPXsowqIHPhU6Rav2unfYo9pFzsHcH0NfatVuL71ciCnmtKiye1GBtK/mwyv5Ji/+T//Pb/r4WCSELxcB90M9X3VdIlNtarfmruhEqg4rBKRu0SrQbMQ5hXEMQpa9IKiMpL2aPn9ap4v6s9fiGVHkkcD0kg=
Received: by 10.86.54.3 with SMTP id c3mr149401fga.1185930122278;
        Tue, 31 Jul 2007 18:02:02 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.90.149])
        by mx.google.com with ESMTPS id o11sm298871fkf.2007.07.31.18.01.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2007 18:01:59 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 34DE2C0DB70; Wed,  1 Aug 2007 03:01:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070729183545.GC29424@schiele.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54391>


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 29, 2007 at 08:35:45PM +0200, Robert Schiele wrote:
> Some systems do not provide zlib development headers and libraries in
> default search path of the compiler.  For these systems we should allow
> specifying the location by --with-zlib=3DPATH or by setting ZLIB_PATH in
> the makefile.

Just wanted to ping about that patch I sent.  After I did not get any respo=
nse
on earlier patches I sent I found that they did not comply to the patch
submission policy.  Thus I did this one according to the policy (as far as I
understand it but still don't get any reply.

So I just wanted to ask what's the cause of that?

Didn't you just have time to look at it?

Did I do something wrong?  In that case it would be useful if I knew what it
is.

Any other reason?

I mean if it is a timing issue it is not a big issue.  Just wanted to know
whether it does make sense to submit more patches or if they all get lost f=
or
some reason I am currently not aware of.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGr9uExcDFxyGNGNcRAnAzAJ0VRg1s+5qT3XV2iQc+HcJrun4JWwCg2nUl
LIKiTX1QX6ApDI9mei73JYU=
=ODXB
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
