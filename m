From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Re: Cloning from sites with 404 overridden
Date: Wed, 22 Mar 2006 22:24:02 +0100
Message-ID: <200603222224.08061.astralstorm@o2.pl>
References: <20060322025921.1722.qmail@science.horizon.com> <20060322183621.GP3997@reactrix.com> <7vslpa8fld.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1688361.4aa6sqJJdO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Wed Mar 22 22:28:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMAs5-00060i-4S
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 22:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbWCVV15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 16:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWCVV15
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 16:27:57 -0500
Received: from mx.go2.pl ([193.17.41.41]:32437 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932759AbWCVV1z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 16:27:55 -0500
Received: from zen.localdomain (host-81-190-201-167.gorzow.mm.pl [81.190.201.167])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id 548B71376F8;
	Wed, 22 Mar 2006 22:27:54 +0100 (CET)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FMAol-0001PC-PJ; Wed, 22 Mar 2006 22:24:35 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <7vslpa8fld.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17830>

--nextPart1688361.4aa6sqJJdO
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 22 March 2006 20:05, Junio C Hamano wrote yet:
>
> .. and note if that is an HTML document or not.
>

Better yet, see first if the object is corrupt. If it is and its Content-Ty=
pe=20
is text/html, error out.

> We do bend backwards to support ISP HTTP servers, but this might
> be going a bit too far.  Also I wonder if ISP runs a really
> dumb-friendly configured server that defaults to text/html
> unless the mimemap says otherwise.  Loose object files do not
> have suffixes and I am expecting these servers would give
> whatever the server default is.

That server would break a *lot* of file types. That admin should be hanged,=
=20
shot, then burned.

I think of only one reason for doing that: to restrict file types posted on=
=20
the server to, say, zip and html.

=2D-=20
GPG Key id:  0xD1F10BA2
=46ingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart1688361.4aa6sqJJdO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEIcB4lUMEU9HxC6IRAobQAKCK7I1HDjVR+LLtnSs8zfPGhAhCOACcDYNH
30sAhwxzkqBk0yDOk5QNpZw=
=8LPO
-----END PGP SIGNATURE-----

--nextPart1688361.4aa6sqJJdO--
