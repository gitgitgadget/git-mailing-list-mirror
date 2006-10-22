From: David Clymer <david@zettazebra.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 15:36:47 -0400
Message-ID: <1161545807.22276.135.camel@zepto.home.zettazebra.com>
References: <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	 <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org>
	 <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org>
	 <45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org>
	 <20061021130111.GL75501@over-yonder.net>  <87ac3p1jn7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-twkn8rNfxrVoKiUez5BN"
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 21:36:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbj77-0007Zr-82
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 21:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWJVTgA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 15:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWJVTgA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 15:36:00 -0400
Received: from zettazebra.com ([72.36.162.130]:1477 "EHLO zettazebra.com")
	by vger.kernel.org with ESMTP id S1751038AbWJVTgA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 15:36:00 -0400
Received: from 67-23-48-101.chvlva.adelphia.net ([67.23.48.101] helo=[192.168.11.100])
	by zettazebra.com with esmtpa (Exim 4.50)
	id 1Gbj6v-0001Sp-Hc; Sun, 22 Oct 2006 15:35:53 -0400
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87ac3p1jn7.wl%cworth@cworth.org>
X-Mailer: Evolution 2.6.3 
X-SA-Exim-Connect-IP: 67.23.48.101
X-SA-Exim-Mail-From: david@zettazebra.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29778>


--=-twkn8rNfxrVoKiUez5BN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-10-21 at 13:47 -0700, Carl Worth wrote:
> On Sat, 21 Oct 2006 08:01:11 -0500, "Matthew D. Fuller" wrote:
> > I think we're getting into scratched-record-mode on this.
>=20
> I apologize if I've come across as beating a dead horse on this. I've
> really tried to only respond where I still confused, or there are
> explicit indications that the reader hasn't understood what I was
> saying, ("I don't understand how you've come to that conclusion",
> etc.). I'll be even more careful about that below, labeling paragraphs
> as "I'm missing something" or "Maybe I wasn't clear".
>=20
> > G: So use revids everywhere.
> >
> > B: Revnos are handier tools for [situation] and [situation] for
> >    [reason] and [reason].
>=20
> I'm missing something:
>=20
> I still haven't seen strong examples for this last claim. When are
> they handier? I asked a couple of messages back and two people replied
> that given one revno it's trivial to compute the revno of its
> parent. But that's no win over git's revision specifications,
> (particularly since they provide "parent of" operators).

I would say that: revnos are handier tools than revids...etc

I think that since G: was making a statement about revids, B: was making
an implicit comparison with them.

bzr log -r before:1  =20

being handier than

bzr log -r before:revid:david@zettazebra.com-20061022175244-4b85cb5f0cbc79a=
d


-davidc
--=20
gpg-key: http://www.zettazebra.com/files/key.gpg

--=-twkn8rNfxrVoKiUez5BN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFO8hP2XpGgG+SNaERAgUvAKCfa9+qbbRM5DHIMNxroPwuAkcwigCg0LyO
nMkWokMlS8jhluyaS1KjiSE=
=lvBQ
-----END PGP SIGNATURE-----

--=-twkn8rNfxrVoKiUez5BN--
