From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: git annoyances
Date: Fri, 11 Apr 2008 11:15:17 +0100
Message-ID: <20080411101516.GA31248@bit.office.eurotux.com>
References: <20080409101428.GA2637@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 12:19:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkGIk-00068B-0B
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 12:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205AbYDKKPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 06:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758119AbYDKKPZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 06:15:25 -0400
Received: from os.eurotux.com ([216.75.63.6]:50237 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758030AbYDKKPY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 06:15:24 -0400
Received: (qmail 10943 invoked from network); 11 Apr 2008 10:15:21 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 11 Apr 2008 10:15:21 -0000
Content-Disposition: inline
In-Reply-To: <20080409101428.GA2637@elte.hu>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79269>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Another inconsistency:
$ git remote prune
usage: git remote
   or: git remote add <name> <url>
   or: git remote rm <name>
   or: git remote show <name>
   or: git remote prune <name>
   or: git remote update [group]

show specific options
    -n, --dry-run         dry run

It took me a while to parse the "show specific options" properly.

Wouldn't "specific options for show" be better?

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH/zo0inSul6a7oB8RAqcOAJ9FCmhpwkY/39ajmPd4GyhEWeVCuQCfcXpw
5pRfaWHbrNqz6g64zg9dTqk=
=/Cos
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
