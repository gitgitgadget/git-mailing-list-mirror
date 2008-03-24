From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH 4/4] git-rebase -i: New option to support rebase with
	merges
Date: Tue, 25 Mar 2008 00:40:27 +0100
Message-ID: <20080324234027.GA26905@alea.gnuu.de>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-4-git-send-email-joerg@alea.gnuu.de> <alpine.LSU.1.00.0803232334130.4353@racer.site> <20080324111413.GA18488@alea.gnuu.de> <alpine.LSU.1.00.0803241406530.4353@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je6CY-0000Xo-Ay
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbYCYKPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 06:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbYCYKPX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 06:15:23 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2840 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbYCYKPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 06:15:17 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 2F038488030; Tue, 25 Mar 2008 11:15:09 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdwHE-0002K2-Ie; Tue, 25 Mar 2008 00:40:28 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdwHE-000708-0c; Tue, 25 Mar 2008 00:40:28 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803241406530.4353@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78173>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Johannes,

Johannes Schindelin schrieb am Mon 24. Mar, 14:08 (+0100):
> On Mon, 24 Mar 2008, J=F6rg Sommer wrote:
>=20
> > Johannes Schindelin schrieb am Sun 23. Mar, 23:41 (+0100):
> > > Now, that is funny.  In case of --preserve-merges, I would have=20
> > > expected you to touch pick_one_preserving_merges(), not pick_one().
> > >=20
> > > I would find it highly illogical to try to redo merges _without_ -p.
> >=20
> > Me too, but I think it's not possible to do what I want with -p.
>=20
> But that is not a reason to mess up the source code.  If you do a thing a=
s=20
> --linear-history (or --first-parents, as I would prefer it), that should=
=20
> be in the code path of --preserve-merges (and actually _imply_ that=20
> option).

Thanks for answering my question. You are really cooperatively.

Bye, J=F6rg.
--=20
IRC: Der [Prof. Andreas Pfitzmann, TU Dresden] hat gerade vorgeschlagen, sie
  sollen doch statt Trojanern die elektromagnetische Abstrahlung nutzen. Das
  sei nicht massenf=E4hig, ginge ohne Eingriff ins System, sei zielgerichte=
t,
  und, der Hammer, das funktioniere ja bei Wahlcomputern schon sehr gut.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH6Dvrwe0mZwH1VIARAk/ZAJ0QLJlnJfJ3nmnRVSSlAviMt/WPhgCfUh1C
I5QqQCZ9lrnu6YOngBhD2sY=
=UAaI
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
