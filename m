From: Radoslaw Szkodzinski <astralstorm@o2.pl>
Subject: Re: What should I use instead of git show?
Date: Mon, 13 Mar 2006 17:17:47 +0100
Message-ID: <200603131717.53416.astralstorm@o2.pl>
References: <20060313144747.GA81092@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3255539.GuaBJMhGPn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 13 17:21:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIpmm-0007IZ-QV
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 17:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWCMQUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 11:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWCMQUm
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 11:20:42 -0500
Received: from mx.go2.pl ([193.17.41.41]:40361 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S932155AbWCMQUl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 11:20:41 -0500
Received: from zen.localdomain (host-81-190-201-167.gorzow.mm.pl [81.190.201.167])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by poczta.o2.pl (Postfix) with ESMTP id 833A0137864;
	Mon, 13 Mar 2006 17:20:39 +0100 (CET)
Received: from zen.localdomain ([192.168.0.1])
	by zen.localdomain with esmtpa (Exim 4.60)
	(envelope-from <astralstorm@o2.pl>)
	id 1FIpka-00033O-1Q; Mon, 13 Mar 2006 17:18:28 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <20060313144747.GA81092@dspnet.fr.eu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17569>

--nextPart3255539.GuaBJMhGPn
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 13 March 2006 15:47, Olivier Galibert wrote yet:
> Since it seems to be gone.
>
> Up until now, when I wanted to send a patch to someone with the
> associated changelog, I just did a git log to find the changelog sha1
> then a git show to get the goods.  How am I supposed to do that now?
>
>   OG.

Why not use git-whatchanged? It's exacly meant to do this.
Or try qgit, or even gitk (which is what git show did).

--
GPG Key id:  0xD1F10BA2
Fingerprint: 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2

AstralStorm

--nextPart3255539.GuaBJMhGPn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBEFZsxlUMEU9HxC6IRAqS/AJ915BcLkv8A/dregDJxAXrXihMMiACgpEPc
lAKelMW+npOTaUkjfk9W7Rk=
=JTm2
-----END PGP SIGNATURE-----

--nextPart3255539.GuaBJMhGPn--
