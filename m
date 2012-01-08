From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: SVN -> Git *but* with special changes
Date: Sun, 8 Jan 2012 11:33:03 +0100
Message-ID: <20120108103303.GC2714@centaur.lab.cmartin.tk>
References: <1317227849979-6840904.post@n2.nabble.com>
 <20110928190445.GC1482@sigill.intra.peff.net>
 <1325999031923-7163706.post@n2.nabble.com>
 <20120108051051.GA10129@sigill.intra.peff.net>
 <1325999865995-7163737.post@n2.nabble.com>
 <1326000327637-7163752.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Cc: git@vger.kernel.org
To: Abscissa <bus_nabble_git@semitwist.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 11:33:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjq4C-0006fK-Ba
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 11:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab2AHKdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 05:33:04 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:37168 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab2AHKdD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 05:33:03 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9ffcd.pool.mediaWays.net [77.185.255.205])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 3B5A2461C3;
	Sun,  8 Jan 2012 11:32:50 +0100 (CET)
Received: (nullmailer pid 9534 invoked by uid 1000);
	Sun, 08 Jan 2012 10:33:03 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Abscissa <bus_nabble_git@semitwist.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1326000327637-7163752.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188097>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 07, 2012 at 09:25:27PM -0800, Abscissa wrote:
> Well that's strange, it finished "upgrading", but now git is still just
> reporting 1.7.0.4, which is *exactly* the same version it said before. The
> git-svn package should already be up-to-date because I just installed it=
=20
> today. So I don't know what's up with that.

Nothing odd about that. apt-get upgrade means "upgrade my system". If
you want to get a newer version of package X, you do apt-get install X
and it will install the latest version of that package.

Your OS seems ancient, you might be better off installing from source.

   cmn

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPCXDfAAoJEHKRP1jG7ZzT21oH/2gwA/7QIHYxzZxXIL+DSjYS
MNUtqr3778YZior+P0o3kNR738AY79x99msc26Sx+NytSpQIDYMxgGVxcS9/3dqB
L1GP4evjPXqzCRE5kh0zL6t3GogVFdS168RyvXYsPWg0kdGKQWNJ0at0Wci55JLE
4jhECSrNlFtaynVstZ7DNY/plqxK7MtMXmqXBDYGxf0DuOBRjcLqCGSJn+ZF4tsu
Bk3tpP5PA1m+1tytP+ImxuEvK7lXwHgs2L1t3xnup00JIaM7+6DWi7xmKthQ4sA2
amAJnq/ZI/ZinZ90BlJo4ewj31Qzsw11Ofn1Fs/yujevLV68xtTqc+XR47mA4v8=
=IYw2
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
