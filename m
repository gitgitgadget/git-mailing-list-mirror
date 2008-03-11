From: Luciano Rocha <luciano@eurotux.com>
Subject: commit 0? (or: create new empty branch)
Date: Tue, 11 Mar 2008 12:30:04 +0000
Message-ID: <20080311123004.GA27577@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 13:31:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ3dG-00051Z-6M
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 13:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbYCKMaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 08:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbYCKMaL
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 08:30:11 -0400
Received: from os.eurotux.com ([216.75.63.6]:58173 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442AbYCKMaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 08:30:10 -0400
Received: (qmail 22306 invoked from network); 11 Mar 2008 12:30:08 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 11 Mar 2008 12:30:08 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76832>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

I'd like to create a new branch, without any pre-existing data, for
purposes similar to git's html/man/.....

However, I've been unable to do that using the higher level tools.

Even starting from an empty git rep, I can't create a branch:

$ git init
Initialized empty Git repository in .git/
$ git branch empty
fatal: Not a valid object name: 'master'.

How were the different git.git branches created?

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH1ntMinSul6a7oB8RAk3nAJ9hLuPB2rQPeJmg6rmSybbVH1aCmQCfZqzE
3Tuy2fdT7HfnqyG9icJ9bUU=
=/3PC
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
