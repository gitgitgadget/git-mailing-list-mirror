From: Luis Ressel <aranea@aixah.de>
Subject: Re: [GSoC microproject] Add XDG support to the credential-store
 helper
Date: Fri, 6 Mar 2015 00:15:34 +0100
Message-ID: <20150306001534.06882282@gentp.lnet>
References: <20150305215146.394caa71@gentp.lnet>
	<CAP8UFD3kHKsUWqmfr3mEtTYwVFwGGqMF_wJgVQyoaH=2i9Ge=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/2Cv3Rknp0RVziGT.IUr2=6d"; protocol="application/pgp-signature"
Cc: <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 00:15:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTezg-0002Ip-KW
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 00:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbbCEXPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 18:15:47 -0500
Received: from wp260.webpack.hosteurope.de ([80.237.133.29]:33782 "EHLO
	wp260.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751088AbbCEXPq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 18:15:46 -0500
Received: from hsi-kbw-046-005-229-078.hsi8.kabel-badenwuerttemberg.de ([46.5.229.78] helo=gentp.lnet); authenticated
	by wp260.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1YTezY-00050t-RL; Fri, 06 Mar 2015 00:15:44 +0100
Received: from gentp.lnet (gentp.lnet [IPv6:::1])
	by gentp.lnet (Postfix) with ESMTP id 4232F260166;
	Fri,  6 Mar 2015 00:15:44 +0100 (CET)
In-Reply-To: <CAP8UFD3kHKsUWqmfr3mEtTYwVFwGGqMF_wJgVQyoaH=2i9Ge=A@mail.gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1425597346;b5cea2d6;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264879>

--Sig_/2Cv3Rknp0RVziGT.IUr2=6d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Mar 2015 23:38:19 +0100
Christian Couder <christian.couder@gmail.com> wrote:

> Hi,
>=20
> Last year, on the ideas page:
>=20
> http://git.github.io/SoC-2014-Ideas.html
>=20
> we also had the following improvement:
>=20
> "in some cases, git bisect may test too many merge bases, thus slowing
> down the bisection (making it closer to linear than logarithmic)."
>=20
> so you could work on that too.
>=20
> And if you really want and have time you can also rewrite
> git-bisect.sh into a builtin command. There is already
> builtin/bisect--helper.c where you can put some migrated code step by
> step.
>=20

Thanks for those suggestions!

> First, it looks like another student started working on the same
> microproject. Did you have a look at what he did? If you didn't, you
> probably should, so that reviewers don't need to tell you what they
> already told the other student. And if you did, you should tell it,
> and maybe explain what you did differently and why.
>=20
> If it looks like the other student is more advanced on this subject,
> you might want to try another microproject. And if all the
> microprojects are already taken, you might want to ask the list for
> other microprojects, or you may want to have a look at the many merge
> bases improvement above. (You could start by having a look at
> check_merge_bases() in "bisect.c" and by creating a script or better a
> test case that reproduces the problem, see
> t/t6030-bisect-porcelain.sh.)
>=20

Oops. I had a quick glance at the list archives, but apparently I
missed this. I'll have a look.

> Welcome to the Git community!
>=20
> Best,
> Christian.

Thanks!


Regards,
Luis Ressel

--Sig_/2Cv3Rknp0RVziGT.IUr2=6d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQJ8BAEBCgBmBQJU+OOWXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBMjU3MDBFQTc5QkYzMkY4NEQzMTFGNDlD
NzE4OTFBNkEwRUZCN0U5AAoJEMcYkaag77fpDzsP/jth2Hud72dHvDJcD6DEjpbw
KhgzT/EcEgLgZyYpU1XIbcIDNXNyF/FghwCuP/OH9wjvcqZ5nfeZtKbnzCuE+QwD
5Ejo7RU6yamKQ/G5CbqZIfz2PMjoa+479Nfytk68ASXIqSrb+Ep94t/jGf7HiJQu
EVSmHvhlBRnf71d+Bpe+rLawy0vlIU3dze2wIb6sZubBUDUbihtdNjP9hvFGVpPW
y5bhlKVy3mrh6di+xYxdf672sG7/mQYZlDtwTQkgFiDIuh9OtgIvw+d8cvAIxC8/
Ni3QF9WrEEaXIHi281VoCxGGmZwBYJGHUi7kkXvdtgHM8333C+62knYbKys7jALm
sV6dUvSf0sBFkE52mIU9eRV41ewIV3oZ2RrC/g1gRuFlmvyrwE9sQ2yLjqgLmFvQ
uSARAflpgDiG6XwdgGQE+gfT5P4tbbPmO8UkpgZVbh7eY/0gqrBQ3luSwxY5dDsV
7Ys3E8LFAdfge9ryV0y029XeKIDo8MMdG+WZlT60Q3XMCLLFqoIusKmrSK1u2Vp3
IY6bNJ2zEEBpCYu5JPxuULUadIobAz2yQsNLg7GNXN6iWw0k+zRIZILXiYf0Iv2j
cJbat3vwceGIYSC+njy/TiUGLUpRsa5mb92DY8vLOBlhnGkB6n8g4ZB/3+rsk8xK
dAuQNfw+dM8cllZk8MZf
=YVmO
-----END PGP SIGNATURE-----

--Sig_/2Cv3Rknp0RVziGT.IUr2=6d--
