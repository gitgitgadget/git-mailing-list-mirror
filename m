From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: ssh removed?
Date: Wed, 7 Dec 2005 15:43:39 +0100
Message-ID: <20051207144339.GF26574@schottelius.org>
References: <20051206211918.GP21705@schottelius.org> <20051206232945.GJ22159@pasky.or.cz> <20051207142938.GD26574@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 07 15:47:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek0WX-0007YV-JI
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 15:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVLGOns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 09:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVLGOns
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 09:43:48 -0500
Received: from wg.technophil.ch ([213.189.149.230]:16307 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751105AbVLGOnr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 09:43:47 -0500
Received: (qmail 30767 invoked by uid 1000); 7 Dec 2005 14:43:40 -0000
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051207142938.GD26574@schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13325>


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nico -telmich- Schottelius [Wed, Dec 07, 2005 at 03:29:39PM +0100]:
> [...]
>
> I am trying to get git with git-0.99.8, is that impossible currently?
>=20

I upgraded to 0.99.9i and the following happens when I clone:

[15:42] hydrogenium:~nico# ./update-git+cogito.sh=20
Working on git (in /home/user/nico/build/git) ...=20
Cloning git
defaulting to local storage area
Fetching head...
Fetching objects...
progress: 3 objects, 6382 bytes
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
progress: 33 objects, 82462 bytes
Getting pack list for http://www.kernel.org/pub/scm/git/git.git/
Getting index for pack 46ff81b11ed16ed38caa4aada913cb08c00185b2
Getting pack 46ff81b11ed16ed38caa4aada913cb08c00185b2
 which contains 8a6bd02d4ff1628af4c47d8c0c35d835607832d1
error: Unable to find 6ff87c4664981e4397625791c8ea3bbb5f2279a3 under http:/=
/www.kernel.org/pub/scm/git/git.git/

Cannot obtain needed blob 6ff87c4664981e4397625791c8ea3bbb5f2279a3
while processing commit e23eff8be92a2a2cb66b53deef020063cff285ed.
cg-fetch: objects fetch failed
cg-clone: fetch failed


Nico

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ5b1GrOTBMvCUbrlAQKNMA/+M7MjOy41xqxWjA7FMpV+Is7K/QqplIs6
KCpsZ0KTZgP71B8wWsP5kTVvZU62GUdSHV/oWxw9IQHUwjj2YuRXK5RI7ft+ncCl
aT/FpfJeuYoNVRhPPtcHrMn3inBu/Xk3sJhKQmHlqSciM4T8+QIkJsbpyf3BIA0G
ZxH3sifov0CKorG/pPh//lFyN26KEsVG6WW+n7DHqX93CuwP2LPOeo1rvnCC+jrF
fPK8eNYIyacuXNrp1fSvgYj8d7+S4kgwmxnh9lZut4yA4oem7WBnh4epNHSNWEoJ
QXHlPfRa4XzAtk7v4Zh2gFW/VNO3kpKIM2tDrkXyogHyllKR+RoJc5XdJj5yXyB3
h+ovIvtSXiAi8SLGaOnCVF51SGTxfTnDvNW1LwqmOhnXpoUO+r2AwbDWAkSO04u+
VLFQ6HPLfqGeUvj082+kEb9L8Hldo760iMCI+nSL2HpbYOu1/duGkckjwRx8Q19N
fhvgMh/GK9EViyK/oQikm2lmSgEGukhspNifbNuwHEFqw20/wLSEq91xD3Y3KOO0
BcsN+U8i1qHSUV6eFNTkclYhp1U7c4aWZprDAKQKoaTWtFfeLhJukPxwYajFb0lH
KCBAoyhegndhnwdbKXEpw6clydyBBlPSM30HcnPV1RU/b3cvHBJAyvzcSXrczguk
rZDZwdhe1ls=
=mmJ5
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--
