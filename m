From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Continued work on sr/vcs-helper and sr/gfi-options
Date: Sun, 6 Dec 2009 02:05:48 +0100
Message-ID: <20091206010548.GB31763@genesis.frugalware.org>
References: <fabb9a1e0912051653s77ba25e1g9ff1e21219cd06c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v+ytF4ERyld7fWQH"
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 02:06:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH5Zc-0002SE-5U
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 02:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbZLFBFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 20:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbZLFBFo
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 20:05:44 -0500
Received: from virgo.iok.hu ([212.40.97.103]:38103 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbZLFBFn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 20:05:43 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 72A335809B;
	Sun,  6 Dec 2009 02:05:49 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1278D42F0A;
	Sun,  6 Dec 2009 02:05:49 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DBA331240011; Sun,  6 Dec 2009 02:05:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0912051653s77ba25e1g9ff1e21219cd06c9@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134640>


--v+ytF4ERyld7fWQH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 06, 2009 at 01:53:03AM +0100, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> (with a three-way merge), but I'm not sure? Also, when I try to rebase
> sr/vcs-helper onto master I get conflicts yet again, since these were

That part is fairly easy, just don't forget to enable rerere. :)

--v+ytF4ERyld7fWQH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksbA2wACgkQe81tAgORUJYZeQCfVs0Hocn0RudqVNt5td2zJUcA
V94AnAnxJJj6SXQB9UpTX7HrmA/CYRTI
=arlh
-----END PGP SIGNATURE-----

--v+ytF4ERyld7fWQH--
