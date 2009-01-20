From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH,v4] git-checkout(1): mention fate of extraneous files
Date: Mon, 19 Jan 2009 18:54:53 -0600
Message-ID: <200901191854.58029.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901200040550.3586@pacific.mpi-cbg.de> <878wp6voar.fsf_-_@jidanni.org> <alpine.DEB.1.00.0901200110410.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6525536.z8dRlSbM6x";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jidanni@jidanni.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 01:56:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP4ur-0003jM-VM
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 01:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbZATAzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 19:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755030AbZATAzE
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 19:55:04 -0500
Received: from eastrmmtao101.cox.net ([68.230.240.7]:37466 "EHLO
	eastrmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbZATAzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 19:55:01 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090120005502.HODU26835.eastrmmtao101.cox.net@eastrmimpo03.cox.net>;
          Mon, 19 Jan 2009 19:55:02 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 5cuz1b0012i4SyG02cuzss; Mon, 19 Jan 2009 19:55:00 -0500
X-Authority-Analysis: v=1.0 c=1 a=yrE2ROmFOcQA:10 a=pVinu0nkv-wA:10
 a=Fq1VQ0LPAAAA:8 a=je-7Tk70uTAjhUEbMn4A:9 a=UIhgP9gT18j9CgAyKUYA:7
 a=D5bB8sEAwXfTC9CCb8R7o3KqCQ4A:4 a=_RhRFcbxBZMA:10 a=Vuv1EOu76mEA:10
 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10 a=Jz4apJqxKP2nm0COd2kA:9
 a=CiQ1xQztgCMY-2lnCPHJU-o4Ns0A:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LP4tO-000MYl-DK; Mon, 19 Jan 2009 18:54:58 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901200110410.3586@pacific.mpi-cbg.de>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106422>

--nextPart6525536.z8dRlSbM6x
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 19 January 2009, Johannes Schindelin <Johannes.Schindelin@gmx.de>=
=20
wrote about 'Re: [PATCH,v4] git-checkout(1): mention fate of extraneous=20
files':
>On Tue, 20 Jan 2009, jidanni@jidanni.org wrote:
>> Signed-off-by: jidanni <jidanni@jidanni.org>
>> ---
>> OK thanks Johannes.
>> I'm still worried that there is no exact statement on the fate of the
>> various different classes of files, but OK, moving this to only a SEE
>> ALSO.
>
>You completely misread me.  So I will say it out directly: I think no
>patch is needed.

I think some users will expect to get a clean checkout when simply=20
doing "git checkout <branch>".  It would be nice for the documentation=20
mention that is not the case, and reference the tool that helps get the=20
tree into that state.  Just my opinion, though.

It seems natural to me for this to be mentioned in the 'git checkout'=20
documentation.  Perhaps there's a better place?
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart6525536.z8dRlSbM6x
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkl1IN0ACgkQ55pqL7G1QFnbwwCfah2C7zFJM12xeiNMhuwNETXd
DjAAniAZmY+vlYBW7ek9mku9YuKxGXpH
=BECT
-----END PGP SIGNATURE-----

--nextPart6525536.z8dRlSbM6x--
