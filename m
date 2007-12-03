From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: committing only selected diff's of a file
Date: Mon, 3 Dec 2007 12:07:48 +0100
Message-ID: <20071203110748.GZ31750@genesis.frugalware.org>
References: <4753D465.10802@ecocode.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="58yjuNbz5lCTNNJH"
Cc: git@vger.kernel.org
To: Erik Colson <eco@ecocode.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 12:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz99n-0000v6-5P
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 12:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbXLCLHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 06:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbXLCLHv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 06:07:51 -0500
Received: from virgo.iok.hu ([193.202.89.103]:28832 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbXLCLHu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 06:07:50 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4166E1B252B;
	Mon,  3 Dec 2007 12:07:49 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7175344668;
	Mon,  3 Dec 2007 12:06:48 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9402D176C017; Mon,  3 Dec 2007 12:07:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4753D465.10802@ecocode.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66907>


--58yjuNbz5lCTNNJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 03, 2007 at 11:03:17AM +0100, Erik Colson <eco@ecocode.net>
wrote:
> Does Git allow to commit only selected patches from inside 1 file ?
> I'm coming from a darcs world where this is supported...
> Probably it is supported in Git too, but I can't figure out how :-/

git add -i

(i also wrote a wrapper for people who come from darcs:
http://git.frugalware.org/repos/pacman-tools/darcs-git.py
but it contains many hacks so i don't want to advertise it too much as
others on this list will burn me :) )

- VMiklos

--58yjuNbz5lCTNNJH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHU+OEe81tAgORUJYRAmFHAJ43o9Zev3WJy2/Kd/hNYfLEjA0F9ACgiDBB
WUoa7F5DsQYXbQIWvwTz9ig=
=yphm
-----END PGP SIGNATURE-----

--58yjuNbz5lCTNNJH--
