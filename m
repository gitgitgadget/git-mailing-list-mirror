From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Pull is Evil
Date: Thu, 1 May 2014 18:10:05 -0700
Message-ID: <20140502011004.GD28634@odin.tremily.us>
References: <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362266a3ca00_284da2f2eca3@nysa.notmuch>
 <7vbnvhil5x.fsf@alter.siamese.dyndns.org>
 <53629da233345_76612eb2f075@nysa.notmuch>
 <20140501194846.GA6227@odin.tremily.us>
 <20140501200703.GB6227@odin.tremily.us>
 <5362d7dc7b12_12fe14dd31095@nysa.notmuch>
 <20140502000208.GB28634@odin.tremily.us>
 <5362e8b09aba1_429131b31038@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 03:10:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg1zV-00025U-7L
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 03:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbaEBBKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 21:10:10 -0400
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:47881
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751338AbaEBBKJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 21:10:09 -0400
Received: from omta16.westchester.pa.mail.comcast.net ([76.96.62.88])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id woka1n0021uE5Es5BpA7U1; Fri, 02 May 2014 01:10:07 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta16.westchester.pa.mail.comcast.net with comcast
	id wpA51n011152l3L3cpA6m2; Fri, 02 May 2014 01:10:07 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 280EC1173B87; Thu,  1 May 2014 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1398993005; bh=12vKuayz9+M3/F/l1r7wEEyunAw9e1fq6t6XJip0QkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HU55Wy2GS503hjNtYfUgVp4j3BFgo3ndd1A4262lGKArHyUgQYjtVlaDHymUxJoSC
	 +znOQbKRIFJAvhmxwzG53fKxy4ObpLjTYrviODxiqkn8ZeRl3xwV3NDBoh8P+be6hS
	 knjUZtr1Su0k/RRCVfJfotJqB6dyRf9w+e0vyZzo=
Content-Disposition: inline
In-Reply-To: <5362e8b09aba1_429131b31038@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1398993007;
	bh=ciYuzUT4njM4aHUhuW2pdY5/7BDqufRMF4MP5IbXe2c=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=XoCVHWtkjEZhQAib+TvqyfUMbp9Gz8/o3BDN1aGhOPFHxc9eHnYIS/QQSp3W+AbV0
	 RnaUwWLcAnWFIeNNbG4J1dSj2zHzMs7fUdwgx47cf9BU7djhFsasoIgzKafctXJn0R
	 uH8n9XVci2i89Tx7XsRptEHys7qc+f7PvYq9PjAgKdG9P5VA/UXWgzZSv8Ymq469+h
	 H/W1JfqIy5ZYyIkOhpJpbVtyKbFv10djRVxVOTIxKdmlDb8OfEd6FNKh/Xi0gkL0/O
	 pVlWi7B4Z/S3GfFH2Oe8fVnZKjr8fg6xhEpX+NluIC+MNPPhTt5aniQkasLSrA2Iew
	 SQU1W++vMNVxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247917>


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 07:37:04PM -0500, Felipe Contreras wrote:
> W. Trevor King wrote:
> > On Thu, May 01, 2014 at 06:25:16PM -0500, Felipe Contreras wrote:
> > > W. Trevor King wrote:
> > > > Fast-forward $current_branch by $count commits to $repository
> > > > $refpec?
> > >=20
> > > Why would anyone say 'no' to this one?
> >=20
> > Because the want explicit merges when they bring in topic
> > branches?
>=20
> If that was the case the user wouls have run `git merge
> --no-ff`. Only expereinced users would answer 'no'.

Folks who are setting any ff options don't need any of these training
wheels.  My proposed --prompt behavior is for folks who think =E2=80=9CI of=
ten
run this command without thinking it through all the way.  I'm also
not used to reading Git's output and using 'reset --hard' with the
reflog to reverse changes.  Instead of trusting me to only say what I
mean or leaving me to recover from mistakes, please tell me what's
about to change and let me opt out if I've changed my mind.=E2=80=9D

> > > > and have a chance to bail out if you saw:
> > > >=20
> > > >   Merge 1003 commits from git://example.net/main.git master into my=
-feature?
> > > >=20
> > > > because you forgot which branch you were on.
> > >=20
> > > Yes, that might be nice. But we still need to change the defaults.
> >=20
> > So I should submit an orthogonal patch with -i/--interative/--prompt?
>=20
> I'm not entirely sure what would be the ideal behavior.
>=20
> For example, I'm thinking that by default when the a fast-forward is
> possible, just do it, =E2=80=A6

But just because a ff is possible doesn't mean it's what the
user/project wants.  It may be the most likely guess, but why guess
when they've explicitly asked for a prompt?

> when it's not, ask if the user wants to do a merge or a rebase, if
> the user just press 'enter' a merge is attempted.

I'll just mimic however mergetool currently handles prompt
accept/decline.

> In addition a summary of the commits ahead behind would be helpful.

Good idea.

> If the user wants to cancel the operation, he can just do CTRL+C.

I'll just mimic mergetool.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYvBrAAoJEKKfehoaNkbtfI0QAI8r1692ywsJJ9SMZJiLK3Qp
NwqP5wmS3VcwX0xS15SscEqUeCof9JHzso4NKb2umOTJHEj9vU2Cx2CjZ3KBTz4n
e6euBsN6X8XHKdstljdnbwPxin1laVOHhHGfHrp8eQaI5StUyDaN0mZ11xZ5R8m8
xYjn4Ff7FEMkB0nIf6kkRXs2Q7LlGpd/5GfFS3HEJhf+anh5pawquXpYIS9u7Jzp
+sZfqLllePCT9fLphgaYnRAxEQHhDMM4wMyOAfFEyP6omr+0J0kvQuOGQ08d/AzA
ZgTuXKxQIwBgeuVE+0VqmUxiuwNDYo+RXlLgEGIdBO9MUPiulzciKG/Gf3cl6d8O
Hh6ChhzwNu2iIH8lYx+vSkZa0zuy8eHijbwgHeXQeu1nfI8gfH2f08BGQtzhWX8r
ve0RlF67MuF+1lEBql7K6fy+sVkF+BkPkQLMla0nXFCkRi7CeFPl3TjiwXr1K9wb
9vJo9dRTcdAMO3ml/z37WQTn2VuLjQcmeUD+8qhLNgmPGI3egjlSzC0sX75uhYbL
Aic9xtyybTQTeMK12ua7JEX4SJ5jj22S/oNuDVp+Q0+Au7YGxiSfRzg0d0P8tD/l
zDrGiJuEb5H/ns5NRwPyGj1lKLwwI5YcfSY7aartbsx4tLl5r3f6GmqDFtc8gbX/
q65SGVu0SNI7lMBNBkA+
=h8Bt
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
