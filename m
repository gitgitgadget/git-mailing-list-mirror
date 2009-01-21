From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add --contains flag to git tag
Date: Wed, 21 Jan 2009 04:20:58 +0100
Message-ID: <20090121032058.GG21473@genesis.frugalware.org>
References: <1232501631-21531-3-git-send-email-goulding@vivisimo.com> <4448209.246381232501828959.JavaMail.root@scalix.vivisimo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hcut4fGOf7Kh6EdG"
Cc: git@vger.kernel.org
To: Jake Goulding <goulding@vivisimo.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 04:22:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPTfd-00028X-Ea
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 04:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026AbZAUDVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 22:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755922AbZAUDVB
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 22:21:01 -0500
Received: from virgo.iok.hu ([212.40.97.103]:54747 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755601AbZAUDVA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 22:21:00 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0B85D580A0;
	Wed, 21 Jan 2009 04:21:00 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4E7AA4465E;
	Wed, 21 Jan 2009 04:20:58 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7906311B87A9; Wed, 21 Jan 2009 04:20:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4448209.246381232501828959.JavaMail.root@scalix.vivisimo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106563>


--hcut4fGOf7Kh6EdG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2009 at 08:37:09PM -0500, Jake Goulding <goulding@vivisimo.=
com> wrote:
> Please let me know what else I have inevitably messed up, and I shall
> endeavor to fix and resubmit.=20

Please document your improvements in Documentation/git-tag.txt and don't
forget to add a testcase to t7004-tag.sh.

--hcut4fGOf7Kh6EdG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl2lJoACgkQe81tAgORUJYwsACdH+meIi6m0QcZ6sTCzscevvwF
oFkAmQGtjkz4QazNLM95gSjVpRRzrrbt
=sq2r
-----END PGP SIGNATURE-----

--hcut4fGOf7Kh6EdG--
