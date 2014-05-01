From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: Pull is Evil
Date: Thu, 1 May 2014 12:48:47 -0700
Message-ID: <20140501194846.GA6227@odin.tremily.us>
References: <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
 <53629da233345_76612eb2f075@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KjcUHqqCp23GY06r"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 21:48:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfwyW-0000Xa-Oh
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 21:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbaEATsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 15:48:52 -0400
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:42005
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751247AbaEATsv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 15:48:51 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id wjFD1n00527AodY51joqsl; Thu, 01 May 2014 19:48:50 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id wjon1n00w152l3L3fjoo3w; Thu, 01 May 2014 19:48:50 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 288D311733DE; Thu,  1 May 2014 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1398973727; bh=1MGEX829ipYSnVqSS54GSmeYFwZzsxdycCUU5sE24b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WqthiGol1t+9LGGBCZa8L91qniP65AzN3lYlvltsDJCC6hbXG90o0dsI0YnyfcqCA
	 6uDeqDOUMHpzb4qTwe1p00YMElm5fOnJpHzQfvynLGh/wKF8sGGcc34BjEJFK0iVdr
	 K2ayZTp3UnUIoGPv59AjNVGac0rb1wueKVOjBM7g=
Content-Disposition: inline
In-Reply-To: <53629da233345_76612eb2f075@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1398973730;
	bh=cNnsHx3I02NRg1XE1wlTkvATgKKwkP9/kmnPexhHvdw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=CfHOZyX9EXfDHtHdYL83SCNjcfVABcU0B7d3YFn7cUi4bhT+bDpAgmaW6M0skyG7g
	 qj5jv8/RoAGGzZK/323wfh8JFc865I+tTb0Pc++oyZMmrE89eZci/G1y7ZJbLe9LUH
	 FrtqYMUmMb4zLxn9WogZP1BOtr9XG1ma4ittHrnaekSFTsYKowcoFOeO1kynSSbNtQ
	 rPvkME4Zp4qXp7+WwSAPpUHhwhLhIF1KDchCtsBnoNwSR6XnO9Af5B4ajttkfCD+uj
	 Hp6xiIKFknh+kBys/s5yeG1mY9m1QKQJF4aKZWlqe2wOn5QPxut2CbCNvdWl7L1gvG
	 jX//fxeoUiIZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247833>


--KjcUHqqCp23GY06r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 02:16:50PM -0500, Felipe Contreras wrote:
> The only problem would be when it's not desirable, however, that's a
> problem of the user's ignorance, and the failure of the project's
> policity to communicate clearly to him that he should be running
> `git merge --no-ff`. There's absolutely nothing we can do to help him.

I think =E2=80=9Cuser ignorange=E2=80=9D is the *only* problem with git pul=
l.  Once
you understand the ff flags, you can set them however you like, and
pull will do what you tell it to.

> The only thing we could do is not allow fast-forward merges either, in
> which case `git pull` becomes a no-op that can't possibly do anything
> ever.

My interest in all of the proposed git-pull-training-wheel patches is
that they give users a way to set a finger-breaking configuration that
makes pull a no-op (or slows it down, like 'rm -i =E2=80=A6').  Then folks =
who
compulsively run 'git pull' (e.g. because SVN habits die slowly) can
set an option that gives them something to think about before going
ahead and running the pull anyway.  The space in 'git pull' makes a
shell-side:

  $ alias 'git pull'=3D'echo "try fetch/merge!"'

solution unfeasible, and clobbering /usr/libexec/git-core/git-pull
seems a bit extreme.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--KjcUHqqCp23GY06r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYqUdAAoJEKKfehoaNkbtju0QAJNu/GBIwE/IQf8S3rmIUxYA
vUH0rScaIdlCq6WgCwrDiGXnmEZpOLYCvTpTnE35+lRDHkFYtI7ZDQiUZBWJp6ne
Wu44xq04I8VFPyuwgtOTlBDvTfaUrj9Mui6OMAkwZZ5w0omniUXFeFe0Vw2ffoVL
Ceqk49fUq4iMx++sxm8sy73ZF0pctZBGrO2CWMjCR44UwaAyNYOs+efKmmWrjw89
bQ7gVAAhJUE5truVjMQhG9hPQX6h3diEvpVdPZoFvBieJjQrE+ku92qK1LAJAvin
+zPuKiJzhfmx6SuzogndRQo+O6lF52evOhuJQfI2i5h4aBnQ0PvpjM7FU2bJ+LFK
TaK/g4jyRskGCE59X3H2+vYbcPJBpI9KaxVG2m74YJH29qWihI+vVifb3cEdpaOo
73rVuzz5FJdQNmSQmKVsMBFPTOEIusNNJboPBrlz03wLZ3kBQZNMQElSelWMIY1S
NSRJ7NYIjJAGN4FJVqJNfz6Teh65QFLD9TKIpyZiZbenrB6u0EtN92uGJWSjryRv
gYyO0dsRVTxI9v3jhxSzgq+f5Nr9pQ0oSUFztSdTS4Xbse0aegvQQpE3sfKlICcs
JIiNVkgxCgMdsP3vF9br31l005kG601BBlAfmsWcx3pEkJQZ3wbMZsUPiwXDD3x6
sGRXPw9S69Whep135hzf
=RLYd
-----END PGP SIGNATURE-----

--KjcUHqqCp23GY06r--
