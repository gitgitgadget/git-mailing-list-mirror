From: Armen Baghumian <armen@OpenSourceClub.org>
Subject: Re: git include
Date: Mon, 30 Nov 2009 10:40:55 +0330
Message-ID: <20091130104055.3c3274f5@Office>
References: <4B136932.9000908@gulfsat.mg>
	<fcaeb9bf0911292245t6b18c238s2859d2cbd5dd26be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/6dg/SrfQy.1BCowJ9ViikU.";
 protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 08:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0Yd-0007iI-VX
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbZK3HUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753753AbZK3HUO
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:20:14 -0500
Received: from julius.technotux.org ([88.198.8.89]:51648 "EHLO
	julius.technotux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbZK3HUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:20:13 -0500
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2009 02:20:13 EST
Received: from localhost (localhost [127.0.0.1])
	by julius.technotux.org (Postfix) with ESMTP id B3DE5F6C15D
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 08:08:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at julius.technotux.org
Received: from julius.technotux.org ([127.0.0.1])
	by localhost (julius.technotux.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgEXdduOOEi9 for <git@vger.kernel.org>;
	Mon, 30 Nov 2009 08:08:59 +0100 (CET)
Received: from Office (unknown [213.207.255.133])
	by julius.technotux.org (Postfix) with ESMTPA id 7F456F6C030
	for <git@vger.kernel.org>; Mon, 30 Nov 2009 08:08:58 +0100 (CET)
In-Reply-To: <fcaeb9bf0911292245t6b18c238s2859d2cbd5dd26be@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.16.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134065>

--Sig_/6dg/SrfQy.1BCowJ9ViikU.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


Probably you want to add .gitignore too

*
!*.ml
!.gitignore

On Mon, 30 Nov 2009 13:45:57 +0700
Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> On Mon, Nov 30, 2009 at 1:41 PM, Rakotomandimby Mihamina
> <mihamina@gulfsat.mg> wrote:
> > Hi all,
> >
> > I would like to track only *.ml files and ignore all others.
> > Is there a way to do that in .gitignore?
>=20
> This .gitignore should work (of course for new files only):
> -->8--
> *
> !*.ml
> -->8--

--Sig_/6dg/SrfQy.1BCowJ9ViikU.
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksTb/8ACgkQ6Z1ZqiMrQgCqZgCfVgjTATmPfACAp+g4ED5vvn+g
4pkAoNnvw+v7s7tK3SOtVzTu8oUiZxQE
=gvL9
-----END PGP SIGNATURE-----

--Sig_/6dg/SrfQy.1BCowJ9ViikU.--
