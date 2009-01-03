From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 2/3] unpack-trees: fix path search bug in verify_absent
Date: Sat, 3 Jan 2009 15:01:38 +0100
Message-ID: <20090103140138.GX21154@genesis.frugalware.org>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at> <1230843273-11056-2-git-send-email-drizzd@aon.at> <1230843273-11056-3-git-send-email-drizzd@aon.at> <alpine.DEB.1.00.0812170605300.14632@racer> <20081216232452.GV5691@genesis.frugalware.org> <alpine.DEB.1.00.0901022244240.27818@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/OxAoNYcURhUkoHv"
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 03 15:03:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ75l-0001is-85
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 15:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758865AbZACOBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 09:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758280AbZACOBn
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 09:01:43 -0500
Received: from virgo.iok.hu ([212.40.97.103]:49044 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758773AbZACOBm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 09:01:42 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 937A3580D1;
	Sat,  3 Jan 2009 15:01:41 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 29ADF4465E;
	Sat,  3 Jan 2009 15:01:38 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3F6CD11B8630; Sat,  3 Jan 2009 15:01:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901022244240.27818@racer>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104468>


--/OxAoNYcURhUkoHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 02, 2009 at 10:59:43PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> Just for the record, this patch fixes the testcase Miklos reported=20
> earlier.

Indeed, thanks for the notice.

--/OxAoNYcURhUkoHv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklfb8IACgkQe81tAgORUJYZKACgqmPY18Vsx/uTHP1hvkB4rhHN
nhkAn3K/a1CUIigMvKsLZze8fjx9amNn
=+CQe
-----END PGP SIGNATURE-----

--/OxAoNYcURhUkoHv--
