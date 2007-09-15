From: martin f krafft <madduck@debian.org>
Subject: Re: Track /etc directory using Git
Date: Sat, 15 Sep 2007 17:24:55 +0200
Organization: The Debian project
Message-ID: <20070915152455.GA16223@piper.oerlikon.madduck.net>
References: <38b2ab8a0709130511q7a506c5cvb0f8785a1d7ed7ad@mail.gmail.com> <20070913123137.GA31735@piper.oerlikon.madduck.net> <38b2ab8a0709140108v2a9c3569i93b39f351f1d4ec3@mail.gmail.com> <20070914091545.GA26432@piper.oerlikon.madduck.net> <e47324780709141031t79981b04q3a91984668ea723e@mail.gmail.com> <20070914212643.GA10970@amy.inscure.wireless.home.vilz.de> <20070915142932.GB27494@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Cc: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Vilz <niv@iaglans.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 17:25:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWZWK-0003tf-0u
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 17:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbXIOPZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 11:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbXIOPZQ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 11:25:16 -0400
Received: from clegg.madduck.net ([82.197.162.59]:55409 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbXIOPZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 11:25:15 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 2F733BA3A7;
	Sat, 15 Sep 2007 17:24:56 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 949129F161;
	Sat, 15 Sep 2007 17:24:55 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 5DB42B3106; Sat, 15 Sep 2007 17:24:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070915142932.GB27494@artemis.corp>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4279/Sat Sep 15 14:53:34 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58255>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Pierre Habouzit <madcoder@debian.org> [2007.09.15.1629 +0200]:
>   I fear that you'll end up with quite a big bloat of git, for a use
> case that is fairly limited.

I think it doesn't get bloated until you try to support the model of
tracking different stuff for different files in the same repo. If
you just track one set of data across all files in the repo, I don't
think it'll cause too much bloat.

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
gentoo: the performance placebo.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG6/lHIgvIgzMMSnURAkENAKCTQXIOsOO+p+IyH2+1fhirF3oMtACg3NZe
l32K7xGXDxYXGnnI1al9EGs=
=nscR
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
