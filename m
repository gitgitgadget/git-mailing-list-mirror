From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: Merging repositories and their histories
Date: Thu, 21 Aug 2008 17:48:22 -0400
Message-ID: <48ADE2A6.2020407@gmail.com>
References: <19035412.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5EB8F54E48BAF38C1FBE8D09"
Cc: git@vger.kernel.org
To: Peter Waller <peter.waller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 23:49:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWI2O-0004Bc-Ji
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 23:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYHUVsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 17:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbYHUVsp
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 17:48:45 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:16781 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbYHUVso (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 17:48:44 -0400
Received: by an-out-0708.google.com with SMTP id d40so27427and.103
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type;
        bh=8MfuW+9hfIVz46KBxX2F4eyNUI6qF1fO7LAcMPLYjlA=;
        b=kJP7CpO6zGvETC9zMR5JHeosp3133EhBvfUnykwAFZBHCuFNeJQY82IPzfqOC9UzYE
         SSxIZRw1PR+99WA1z7o+TszOEb2qD2V8v/vqx+V3loGJdmO2IIBh5J7jryv8047bg94n
         ffKUziuVM+uXwPNfJFqD7CJTqr20ZSl75W9Gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        b=Fa+3/9iS88RBAHmtujp+cfVucNG6oIFwSJf2uc2uixTUp7uE1XK5sMAr+odtO+WHQb
         29Zn4jZlMmiCNeJ8W2BT7FQMPmQkWEfdZrTduiyFFBXiIhjcb7GIURcI3G0Kcx301EGH
         c2SfI/gQ/NFg37IaklSbV9zTd0LH7md8eVpJc=
Received: by 10.100.94.14 with SMTP id r14mr566705anb.8.1219355323159;
        Thu, 21 Aug 2008 14:48:43 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id g3sm769162wra.2.2008.08.21.14.48.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 14:48:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <19035412.post@talk.nabble.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93216>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5EB8F54E48BAF38C1FBE8D09
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Peter Waller wrote:
> I have three repositories, A, B and C. I wish to bring them together to=
 only
> one repository (.), where they are in a directory called ./Archive, so.=
=2E
> ./Archive/{A,B,C}. Then I plan at a later date to move files arbitraril=
y
> from ./Archive/{A/B/C}/Something and into ./Something{A/B/C}. (A lame
> example, but illustrates what I want to do).

Peter Waller also wrote:
> Thanks, it worked.
>=20
> 2008/8/18 Alex Riesen <raa.lkml@gmail.com>:
> > > Peter Waller, Mon, Aug 18, 2008 20:15:52 +0200:
> >> >> 2008/8/18 Alex Riesen <raa.lkml@gmail.com>
> >> >>
> >>> >> > Peter Waller, Mon, Aug 18, 2008 18:46:14 +0200:
> >>>> >> > >
> >>>> >> > > (The same thing as above)

Did it actually not work?

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enig5EB8F54E48BAF38C1FBE8D09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSK3iuAPFruyc22R/AQIPZhAA237fzjTJoBbM9lNMjkKcM+/B0gzS1yeo
ekma+aqoSoBDeRVZzuBf00X3apETlWvvZ+RbrkArAxxJnguqkxGatJLEOIeF9+K9
QtKeHlnr+H3hB/Obfksat7IOV0/1BKK/VfQdQmc4VJudFv56GJjLarK0WcEuiPBo
/GNVzGTDoTInqUJBAaqz3CU/PH0s7/+Pr9BV9Jn4IXBSI67Ekcw8NMe2q/U0WDim
dVSjdViZSIPfcxRnA7UFpnICB9GRM+G/rHyPGMMRFxSpkp45u3ohIWktoxvA5tmq
D6SjPfbUneZvtsMIVx/vneB7k59s9CfO/korqYGTJoIjM9aLlqtWmThyE1sbUm0d
45z3fXl8FPje4oRp9jn0hMQsqwjy999Zb1NNPDbFFHSbYXyJcAHhaVWGiGN5J+bz
9EwRhTDzTMlk4Wk6UYAIWiuuHJRDx+eWHWdh7t8ZI1vHVkIM7Im02ZAgnarQCpd8
kuhhogN3ny8Y2w1EK5mKEjO+B7Dnis0RUopxmWhEDZqA50pjU68F+TXmowP/aVx3
eJUCx6tBn8JyOSSGJPA6BKEzsp4ahDLhFW7SqqTViOu/LMhLJwU/Ktl6VH06lYBc
qNlSdXDT8UsR9/1cfldqgEiA8+DjNScUaDlLNpYfwIgJANnR8WMQC1MFGTsSdIGX
6U5vWyaaq2s=
=lRrz
-----END PGP SIGNATURE-----

--------------enig5EB8F54E48BAF38C1FBE8D09--
