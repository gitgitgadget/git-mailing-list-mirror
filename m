From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Date: Mon, 25 Apr 2005 19:12:34 +0200
Message-ID: <20050425171234.GP24187@lug-owl.de>
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org> <426D21FE.3040401@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:08:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ73a-0005Ch-ME
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 19:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVDYRMj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 25 Apr 2005 13:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVDYRMj
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:12:39 -0400
Received: from lug-owl.de ([195.71.106.12]:15067 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262679AbVDYRMf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 13:12:35 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id D049E190214; Mon, 25 Apr 2005 19:12:34 +0200 (CEST)
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Mail-Followup-To: Matthias-Christian Ott <matthias.christian@tiscali.de>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <426D21FE.3040401@tiscali.de>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-25 18:59:42 +0200, Matthias-Christian Ott <matthias.chr=
istian@tiscali.de> wrote:

["register" variables]

> Literature:

> [2] Erik de Castro Lopo, Peter Aitken, Bradley L. Jones: Teach Yourse=
lf=20
> C for Linux Programming in 21 Days; SAMS Publishing; 1999

Yeah, "register" is what you use after 21 days of programming
pracitce...

SCNR, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481         =
    _ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Kri=
eg  _ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im=
 Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | T=
CPA));
