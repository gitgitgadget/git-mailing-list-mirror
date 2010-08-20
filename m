From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Fri, 20 Aug 2010 20:48:38 +0200
Message-ID: <20100820184838.GA8861@localhost>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org>
 <20100818233900.GA27531@localhost>
 <m3aaoiq41v.fsf@localhost.localdomain>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 20:49:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmWer-0001U5-8u
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 20:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab0HTSta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 14:49:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53350 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab0HTSt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 14:49:29 -0400
Received: by fxm13 with SMTP id 13so1947367fxm.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=gCRWXSeDulVRvNdqmwGWWTmLjmQneMioM9PtUE1gDV8=;
        b=sFSK9+fsoGlMdvxjxV44pwvGDk1tdPZYphick1quoqI2vqX1HFGqfAy3NKGqiRIURq
         N5aTt2uF8YYd8Js4doAoxRL/mJloPdEK/y856Aqqpg4Yqh8KvxWiUQbGdLh+UiUu2HaO
         av+iEFeNeXaLOUXTOnrJAiiOVEsDW8+FqF83g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Bb4TiPBU4wKu3boJ0c83ipYiZtC27FHm6SZCrDQjB8J2Hc+ePX5vznfJYeCZ5VZpeX
         cZ9fw5lY1eRANy94LWCIOh+hexuXegCOwZjhUEbVGw6arYegCoMu9MCBAXNT9ijoeJWt
         watsnnYJ2MvqT2i14XIvNxIPs1wvvD23+PZDU=
Received: by 10.223.116.193 with SMTP id n1mr875627faq.77.1282330167640;
        Fri, 20 Aug 2010 11:49:27 -0700 (PDT)
Received: from darc.lan (p549A2DB8.dip.t-dialin.net [84.154.45.184])
        by mx.google.com with ESMTPS id r8sm1292045faq.34.2010.08.20.11.49.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 11:49:26 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OmWdq-0002Jb-6i; Fri, 20 Aug 2010 20:48:38 +0200
Content-Disposition: inline
In-Reply-To: <m3aaoiq41v.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154066>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2010 at 03:41:08AM -0700, Jakub Narebski wrote:
>=20
> You forgot to update Documentation/git-checkout.txt and
> Documentation/git-merge.txt with the new '-i' option.

Thanks. I am just waiting for some kind of feedback. I'm not going
to write documentation for something that won't get accepted.

Clemens

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMbs4GAAoJELKdZexG8uqMvZUH/jaQW8drdhnelIu421RMCzf/
CESzECcEq3OxCCCw5IbBJ2NOAFw+Jchhj46xGZjAKxf+/ZmMSCJEpkdj2yHa+JLo
9I7+4sm/JOsfmiVyFr6HGZDi0TUt5Mr8F7tahT+eWWCPjPW39HLw26BmlxEFVjZX
rY8ymnrGJAbdbLj7VLL1X3nuIZdN2y0PFMOtbNGSitlL73q2b2oJngnNAWLz21Ka
YRT+vjrPd/ppVQZ7YMWeFOrGJKxufn4H6b3EW7VhaNz0s1Ni+R7bQA87dTGnIW2E
Z51BbAC61rajpu3vNxYq0rE6QrQm0mwUln/9uO+1NaZ+wYYmh7tRCz8gp/6Y7Dc=
=Le4q
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
