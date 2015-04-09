From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC/PATCH 1/4] submodules: implement synchronizing of remotes.
Date: Thu, 9 Apr 2015 13:57:16 +0200
Message-ID: <20150409115716.GA347@pks-pc>
References: <1428490705-11586-1-git-send-email-ps@pks.im>
 <1428490705-11586-2-git-send-email-ps@pks.im>
 <CAPc5daWarayCBKyzrcNoh07RtPZhu4WjaT8QNsuHDtphxvz1DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 13:57:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgB5N-0007Gh-QH
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 13:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933834AbbDIL5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 07:57:25 -0400
Received: from sender1.zohomail.com ([74.201.84.162]:53330 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933335AbbDIL5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 07:57:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; 
  b=kt9Jzf9R0ADI3oeeUg5ocEty5ukjov5LeqSxUMdEos7GT2AFknIBsidtP3ymvlx8Ob9WQ84jbTtJ
    ftEry9wFZ2XOjsurekkz/5ZCYNwl56es7mtD2Hufzav/JhaldZzUVIVWq7FXvYB7fe1F+SMDsvsn
    cBbCUmWvA/8vYiU4QeI=  
Received: from localhost (x5ce10066.dyn.telefonica.de [92.225.0.102]) by mx.zohomail.com
	with SMTPS id 1428580642356803.6665153011844; Thu, 9 Apr 2015 04:57:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPc5daWarayCBKyzrcNoh07RtPZhu4WjaT8QNsuHDtphxvz1DQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266991>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2015 at 08:46:28AM -0700, Junio C Hamano wrote:
> On Wed, Apr 8, 2015 at 3:58 AM, Patrick Steinhardt <ps@pks.im> wrote:
> > Previously it was not possible to specify custom remotes for
> > submodules. This feature has now been implemented and can be
>=20
> I am not going to say whether it makes sense to add this feature or not,
> but I'll just react to "Previously".
>=20
> Let's stop saying "Previously we couldn't do X, now we can".
>=20
> Instead, let's consistently say "We don't do X. Being able to do X is a
> good thing for such and such reasons. Make us capable of doing X by
> doing this and that."
>=20
> Some people even say "Currently we cannot do X. Teach us to do so",
> which is equally bad but that is primarily because some people say
> "Previously" and they feel the need to clarify which reality they are
> talking about. Once we stop saying "Previously", they will stop saying
> "Currently", and the world would be a better place ;-).
>=20
> Thanks.

Points taken, I'll reword the message if there is any interest in
the proposed feature. ;)

Patrick

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVJmkcAAoJEBF8Z7aeq/EsPx0P/1VuGb7NH7De3mO/Ay7TEyEC
s3eu0k3FeFWbzvL5Oe4VQerLcE9wGOcVyr6VK7kGfpREz94KRJOGsTkI/AEnLZfd
YNLCXc1S/tgYOr0/pRMLHoT7fvQJqUfEMoRE2J7GaJ54tdTFNtEjbH9VrrcMJOWr
gdhHiNFUruVcm2nH8IFznZAppdMp/3U41R1GISbBMXEZWU58lmuTaJtGRhnM2ckM
NNy4iKVmQgazFpDgxs4bHEwRLX9cd1qG/mD0jHgFfFlaUxsmMc76NYu42+GNlZNk
rHt8husJiabZb/yThnJc2hqyUZ1crsXleMGuAIFaQOSJ05v/s6JVNa/TqoO0Zo4g
oH7MxFq8v3grbtF6fToxyOA3QRKu5ErACv97Nz/rbI5+RLIouzN21E+6h57yYLyZ
ohMd7A8H+9sSHE8dZPG7VqNrX8ggdQYzJ0j6Dkren76S2cWaK6bOywrORd+2EP5z
QLMjh0cF7b5aKPTk53cXMunWKIn3XxqnqYu5m2SHiRNt503NA4fD4dgwexG46lae
I2g5efnKYbIDWHUASidAgm/VOnO6uiMVUcNXuILT/YqPDfjfsLeMDymMTP77w8Pq
WX8PRFcPaOt112z7Kh1Y6IRL4AkeznHBwLAswZLzvSl1bHuLrGdMQXcz5FlSIOo5
KAMhgVza0jwIAAli4J6h
=83bl
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
