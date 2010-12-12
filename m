From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: Re: [PATCH] git_getpass: fix ssh-askpass behaviour
Date: Sun, 12 Dec 2010 14:07:54 +0100
Message-ID: <20101212140754.36d6b469@laptop.localhost>
References: <AANLkTinES5dqt+JAMOrp7gAYJ4UgK9ipfEN9ag5qSCLp@mail.gmail.com>
	<1292157174-4033-2-git-send-email-alexander@sulfrian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/26pCUQaAL.3Ndw=UGrvZ6r2"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 12 14:08:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRlex-0004Du-RE
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 14:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab0LLNIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 08:08:11 -0500
Received: from animux.de ([78.46.93.45]:35430 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707Ab0LLNII (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 08:08:08 -0500
Received: from laptop.localhost (p5DD632C0.dip.t-dialin.net [93.214.50.192])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 9B31A82E6003
	for <git@vger.kernel.org>; Sun, 12 Dec 2010 14:08:05 +0100 (CET)
In-Reply-To: <1292157174-4033-2-git-send-email-alexander@sulfrian.net>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163481>

--Sig_/26pCUQaAL.3Ndw=UGrvZ6r2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Dec 2010 13:32:54 +0100
Alexander Sulfrian <alexander@sulfrian.net> wrote:

> call ssh-askpass only if the display environment variable is also set

Oh forgot to sign-off... I'll wait if there are other comments and
resend it in a few days.

Alex

--Sig_/26pCUQaAL.3Ndw=UGrvZ6r2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk0EyS8ACgkQ1SSUxvEq73wXDgCfeUtq7vqCgovshpR/SjTnUZ4I
PAYAnRME07liZmLZbYfP7y3DlPX9Wd3Z
=LJ+o
-----END PGP SIGNATURE-----

--Sig_/26pCUQaAL.3Ndw=UGrvZ6r2--
