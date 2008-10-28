From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Tue, 28 Oct 2008 01:13:08 +0100
Message-ID: <20081028001308.GA24201@genesis.frugalware.org>
References: <ge0rla$mce$1@ger.gmane.org> <200810272149.13542.arne_bab@web.de> <20081027210716.GS2273@genesis.frugalware.org> <200810272230.51683.arne_bab@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	mercurial@selenic.com, SLONIK.AZ@gmail.com
To: Arne Babenhauserheide <arne_bab@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 28 01:14:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KucE5-0002lJ-1p
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 01:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbYJ1ANM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 20:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYJ1ANL
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 20:13:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:46376 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbYJ1ANL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 20:13:11 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 07C3F58105;
	Tue, 28 Oct 2008 01:13:09 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C01264465E;
	Tue, 28 Oct 2008 01:13:08 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AD2BD11901A1; Tue, 28 Oct 2008 01:13:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200810272230.51683.arne_bab@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99269>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2008 at 10:30:44PM +0100, Arne Babenhauserheide <arne_bab@w=
eb.de> wrote:
> Means git can provide additional commands and only has the limitation tha=
t I=20
> can't overwrite the basic commands, right?=20

Yes. And in general the API is the output of the plumbing commands, not
the API of libgit which is totally unstable.

> But we're slowly moving off topic, aside from "OK, git also has extension=
s -=20
> they are called external commands".=20

I think we're offtopic since the dragonfly list is not in cc. :)

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkGWRQACgkQe81tAgORUJYfEQCeKKqZxyFeQNQvkFw+0lMIOW6J
TmMAnj58k/8hAw2NXmx3VawMS8x9ZeI6
=CwG+
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
