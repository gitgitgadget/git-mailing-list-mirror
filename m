From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs.
Date: Tue, 3 Oct 2006 22:28:31 +0200
Message-ID: <20061003202831.GS2871@admingilde.org>
References: <20060929221641.GC2871@admingilde.org> <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net> <20060930181408.GD2871@admingilde.org> <7vfye9dtv7.fsf@assigned-by-dhcp.cox.net> <20061001215748.GG2871@admingilde.org> <eftkdk$2ii$3@sea.gmane.org> <7vbqotpadg.fsf@assigned-by-dhcp.cox.net> <efu7r9$fra$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q8dntDJTu318bll0"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 22:28:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUqsW-0002cs-G4
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 22:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWJCU2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 16:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWJCU2d
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 16:28:33 -0400
Received: from agent.admingilde.org ([213.95.21.5]:53707 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S964802AbWJCU2c
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 16:28:32 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GUqsR-0006j2-SB; Tue, 03 Oct 2006 22:28:31 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <efu7r9$fra$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28301>


--q8dntDJTu318bll0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :-)

On Tue, Oct 03, 2006 at 07:50:00PM +0200, Jakub Narebski wrote:
> Perhaps we should not add 'override' key, and test for existence
> of 'override' to fallback on 'sub'.

this is a no-op: if the config file sets override to 1 then
we still break.

Of course one say: don't do it then.
But then we don't need the check at all.

--=20
Martin Waitz

--q8dntDJTu318bll0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFIsfvj/Eaxd/oD7IRAhtjAJ93zal1bUt5ST+B62F3RF+70irwMwCeNYqA
TOT3meeSF7DVDkWMy65xC+w=
=BpRq
-----END PGP SIGNATURE-----

--q8dntDJTu318bll0--
