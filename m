From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Fast forward strategies allow, never, and only
Date: Mon, 12 May 2008 14:13:54 +0200
Message-ID: <20080512121354.GM27724@genesis.frugalware.org>
References: <402c10cd0805112217u2688eac6h8a650b7ab7bb4883@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaPAUYI/0vT2YKpA"
Cc: git@vger.kernel.org
To: Sverre Hvammen Johansen <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 14:15:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvWva-0007S2-N9
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 14:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040AbYELMOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 08:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYELMOA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 08:14:00 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48719 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbYELMN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 08:13:59 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 700861B2508;
	Mon, 12 May 2008 14:13:55 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3F9D54465E;
	Mon, 12 May 2008 14:06:23 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E223A178801E; Mon, 12 May 2008 14:13:54 +0200 (CEST)
Mail-Followup-To: Sverre Hvammen Johansen <hvammen@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <402c10cd0805112217u2688eac6h8a650b7ab7bb4883@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81855>


--yaPAUYI/0vT2YKpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2008 at 10:17:26PM -0700, Sverre Hvammen Johansen <hvammen@=
gmail.com> wrote:
> I am hereby sending an updated version of these patches as
> attachments to this mail.  The patch series consists of the
> following six patches:
>=20
>   0001-Documentation-for-joining-more-than-two-histories.patch
>   0002-New-merge-tests.patch
>   0003-Introduce-ff-fast-forward-option.patch
>   0004-Restructure-git-merge.sh.patch
>   0005-Head-reduction-before-selecting-merge-strategy.patch
>   0006-Introduce-fast-forward-option-only.patch
>=20
> The first patch add some documentation, for how git currently handles
> merges where more than one remote is involved.   The second patch add
> some tests.  The third, fifth, and sixth adds new features and they are a=
ll
> trivial.  The fourth patch computes the reduced parents but uses it only
> to determine whether we are up-to-date or doing a fast forward.

According to Documentation/SubmittingPatches, you should not attach
patches, but send one email / patch with the patch inline.

Just use git-send-email to do so. :)

--yaPAUYI/0vT2YKpA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkgoNIIACgkQe81tAgORUJbpnQCfQOaT1asqupQ7EOS3ygwIjb+e
JdEAnjSALii69JRP9ykGq1g2E6FT7HTL
=GS7M
-----END PGP SIGNATURE-----

--yaPAUYI/0vT2YKpA--
