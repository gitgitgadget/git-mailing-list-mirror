From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Make the ftplugin right wrt gitdir
Date: Wed, 18 Oct 2006 11:07:54 +0200
Organization: Polytechnique.org
Message-ID: <200610181107.56260.madcoder@debian.org>
References: <11611319762395-git-send-email-madcoder@debian.org> <200610181010.59995.madcoder@debian.org> <20061018090231.GA18807@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1755179.2paUnA6yzG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 11:08:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7PB-0004Gw-MD
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 11:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWJRJIA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 05:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWJRJIA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 05:08:00 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:9685 "EHLO
	mx1.polytechnique.org") by vger.kernel.org with ESMTP
	id S932108AbWJRJH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 05:07:59 -0400
Received: from mad.intersec.eu (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ssl.polytechnique.org (Postfix) with ESMTP id 137F4332BC;
	Wed, 18 Oct 2006 11:07:58 +0200 (CEST)
To: Jeff King <peff@peff.net>
User-Agent: KMail/1.9.5
In-Reply-To: <20061018090231.GA18807@coredump.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
X-AV-Checked: ClamAV using ClamSMTP at djali.polytechnique.org (Wed Oct 18 11:07:58 2006 +0200 (CEST))
X-DCC-xorg-Metrics: djali 32702; Body=2 Fuz1=2 Fuz2=2
X-Spam-Flag: No, tests=bogofilter, spamicity=0.013460, queueID=36020332E5
X-Org-Mail: pierre.habouzit.2000@polytechnique.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29210>

--nextPart1755179.2paUnA6yzG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le mer 18 octobre 2006 11:02, Jeff King a =C3=A9crit :
> On Wed, Oct 18, 2006 at 10:10:59AM +0200, Pierre Habouzit wrote:
> > > Looks like the patch is missing (more sleep required?).
> >
> > err, the patch is here:
> > <1161132446703-git-send-email-madcoder@debian.org>
>
> Right, that's the "be more robust" patch which applies on top of
> something else (presumably "nice ftplugin for vim"), but the last one
> I got of that (<11611319761977-git-send-email-madcoder@debian.org>)
> causes vim errors and you immediately followed up with "that's still
> not the good one." Where is that patch?

hmm I see, curious though, I must have do sth stupid :|

well the result file is here:=20
http://madism.org/~madcoder/dotfiles/vim/ftplugin/git.vim

I've not access to my git repo from here, feel free to grab it and=20
commit it, I don't care if there is not my name on it.

and as of gitEmail you're right I don't use it, I wanted to to hilight=20
the email address in the gitAuthor zone, but well, basically, it sucks,=20
that makes too many colors.
=2D-=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--nextPart1755179.2paUnA6yzG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNe7svGr7W6HudhwRArkrAJ9U/caHSV1p6GSijmPPkjHDq4gqIwCZASR7
9zxjuxui85nvYWdUs/+72mQ=
=OuJG
-----END PGP SIGNATURE-----

--nextPart1755179.2paUnA6yzG--
