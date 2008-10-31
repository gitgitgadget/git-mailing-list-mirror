From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/3] git send-email: do not ask questions when  --compose is used.
Date: Fri, 31 Oct 2008 22:38:03 +0100
Message-ID: <20081031213803.GB21799@artemis.corp>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225456609-694-1-git-send-email-madcoder@debian.org> <1225456609-694-2-git-send-email-madcoder@debian.org> <1225456609-694-3-git-send-email-madcoder@debian.org> <20081031213338.GB21345@maintenance05.msc.mcgregor-surmount.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="98e8jtXdkpgskNou";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Ian Hilt <ihilt@mcgregor-surmount.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:39:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw1iC-0008Oj-VQ
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 22:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbYJaViH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbYJaViG
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:38:06 -0400
Received: from pan.madism.org ([88.191.52.104]:35957 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbYJaViF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:38:05 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 751183B6C4;
	Fri, 31 Oct 2008 22:38:04 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2C4E15EE243; Fri, 31 Oct 2008 22:38:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081031213338.GB21345@maintenance05.msc.mcgregor-surmount.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99649>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 09:33:38PM +0000, Ian Hilt wrote:
> On Fri, Oct 31, 2008 at 01:36:48PM +0100, Pierre Habouzit wrote:
> > +GIT: Please enter your email below this line.
>=20
> At first glance I thought this meant to enter my email address here.
> So, instead of "email" would "message" be better?  Although on second
> glance I realized this is where the body of the message went.  Not sure
> if this is worth changing.

Well, this line sounds kind of awkward actually, so I was even thinking
about removing it.

Decent editors should probably have a plugin to put the cursor here and
be done with it.


In fact what looks odd is the GIT: stuff. a line looking like:

    --- write your message below this line ---

Looks 10x better, though need some code to strip it out if the user kept
it, and I'm lazy, GIT: stuff is automatically removed...


But if that's the only thing that you don't like in the series, I'm
glad, this is quite a minor issue ;)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLersACgkQvGr7W6HudhzzTgCgoUpUdKT/v5GHr7W8cM+TC63w
zm4An2C45eW4l01JNLSsOygTT3WKWQya
=QB/E
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
