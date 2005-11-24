From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: files are disappearing in git
Date: Thu, 24 Nov 2005 11:38:33 +0100
Message-ID: <20051124103833.GF19989@schottelius.org>
References: <20051123142303.GJ22568@schottelius.org> <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org> <20051124084633.GA3361@schottelius.org> <7vfypmwgny.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 11:39:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfEV1-00086V-Bo
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 11:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbVKXKik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 05:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbVKXKik
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 05:38:40 -0500
Received: from wg.technophil.ch ([213.189.149.230]:41907 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1030363AbVKXKij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 05:38:39 -0500
Received: (qmail 5615 invoked by uid 1000); 24 Nov 2005 10:38:33 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfypmwgny.fsf@assigned-by-dhcp.cox.net>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12704>


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano [Thu, Nov 24, 2005 at 01:15:13AM -0800]:
> Nico -telmich- Schottelius <nico-linux-git@schottelius.org> writes:
>=20
> > Linus Torvalds [Wed, Nov 23, 2005 at 09:20:28AM -0800]:
> >> On Wed, 23 Nov 2005, Nico -telmich- Schottelius wrote:
> >>...
> >> I bet somebody just messed up the index before that commit.
> >
> > What would be the best things to corrupt the index?
> > Our developers here do the following each day:
> >
> > - cg-update
> > - <work>
> > - cg-commit
> > - cg-update + merge if there are changes
> > - cg-push origin
>=20
> Was any of the CG:F line changed/removed by the developer during
> cg-commit?

He said it could be possible. In fact the situation that we delete those li=
nes
are not so seldem.

> Does any of the files under Code/Spikes/Statistik/ have funny
> characters in their pathnames?

No:

Code/Spikes/Statistik/Project.dpr   [new file with mode: 0644]    blob
Code/Spikes/Statistik/Statistik.pas    [new file with mode: 0644]    blob
Code/Spikes/Statistik/Statistik.xfm    [new file with mode: 0644]    blob

Nico

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ4WYKbOTBMvCUbrlAQJs0g//fqk7eSWtX7BPkOWN9gMgS8OcIyvwjJYT
gcTPVDB/ICWR7sgvCOW1XW9FyWCOM6eDDKySuFnwhzdTr6zpn/sfynmHbfISjGUi
6i8FL/aul217Ht9pQoINeZDHi/5/Dfp7GaelJTk10+T4Y33ffWe0h32d/5gTph4u
X70douECtux5NkUPK8BTsq1QFVbWvF6thfAPpirDnXuTqhhF3SRumc8clnuY2+m6
QkX9MPHEBNN8UgHB3wGdI0iu5MtuQT6M58eTAOIWNKb21lUSOvHhYeEIRVnOM4bN
DkWH6fqbltSsPt9DdO4xMB/IMjBxrx+hTJ+UkGvOwo79bIyvfgsHGUImhiZ/jxCU
O13v2BybfIoItyciksWU+xxA9oxWAEc9Tzhcl8PgVBP/jkJmBZ/ipIrjBgjnk8p0
txLujxRPCXgGPTXUFzCXN0UjBVylX3aO7pVl3gO/Z1lwDtq6QZsxAE/PFhlCWMV4
Gu8YgqOuooE05Zi323Ej2T0aPJwAWk0LqHSDSljbYFvP84pC9mKf/HMLpLnXnueO
BFTWiZWf8C1FZilzDJJBbPuTUSj/803dLSiJpk9jnut1hLmH5deYLejTjT/xTcwt
IQgH1/GAm30fuPcgnnVUslsqlxcwnQNbYcNGP6HRcsW5jGjdOnceNwxDf9l8yzUx
0IvDqtBYjaE=
=7ePG
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
