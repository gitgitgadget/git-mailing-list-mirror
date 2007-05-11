From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Fri, 11 May 2007 22:50:03 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200705112250.07340.ismail@pardus.org.tr>
References: <200705081349.34964.ismail@pardus.org.tr> <200705112242.44618.ismail@pardus.org.tr> <7vwszf9md5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7372859.Vv2iiDz2k3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 21:49:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmb71-0003zB-Az
	for gcvg-git@gmane.org; Fri, 11 May 2007 21:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031174AbXEKTsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 15:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031171AbXEKTsU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 15:48:20 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:40080 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1031164AbXEKTsS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 15:48:18 -0400
Received: from southpark.local (unknown [88.233.178.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 45AC75F861EE;
	Fri, 11 May 2007 22:48:09 +0300 (EEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vwszf9md5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46976>

--nextPart7372859.Vv2iiDz2k3
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 11 May 2007 22:44:06 Junio C Hamano wrote:
> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> > Most(All?) distros /usr/share/man in MANPATH so I believe this
> > patch shouldn't break anything but well you have the final
> > say. I am ok with doing make mandir=3D/usr/share/man install-doc
>
> My preference is to do this early after 1.5.2.  I do not want to
> touch builds with trivial changes before the final.

Ok with me, thank you.

Regards,
ismail

=2D-=20
Perfect is the enemy of good

--nextPart7372859.Vv2iiDz2k3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iD8DBQBGRMjvGp0leluI9UwRAl1XAJ91WkddzJYqZ3JwxFomyqh+Eik9BgCeNYXx
S19nX342K0578+MMNKcf/jc=
=VeKW
-----END PGP SIGNATURE-----

--nextPart7372859.Vv2iiDz2k3--
