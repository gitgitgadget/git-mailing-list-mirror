From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Add Swedish translation.
Date: Thu, 16 Sep 2010 15:58:19 +0200
Message-ID: <4C92227B.70800@drmicha.warpmail.net>
References: <20100912202111.B11522FC00@perkele>	<alpine.DEB.2.00.1009151124100.11791@ds9.cixit.se>	<A612847CFE53224C91B23E3A5B48BAC749BFA3D12C@xmail3.se.axis.com>	<201009160046.47367.robin.rosenberg@dewire.com>	<alpine.DEB.2.00.1009161209500.18826@ds9.cixit.se> <AANLkTin_5drpRva6jiwwC-OpMSxnYwJu5fJD4aU7P5jq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Git <git@vger.kernel.org>, Swedish <tp-sv@listor.tp-sv.se>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 15:58:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwEym-00074r-T6
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 15:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036Ab0IPN6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 09:58:15 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60077 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754360Ab0IPN6O (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 09:58:14 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E2FA2332;
	Thu, 16 Sep 2010 09:58:13 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 16 Sep 2010 09:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5nJk24d7Bl93AF8F/XfA7Pzdgao=; b=q5Z6lCwe4H6AWsRjJJFowRohFnhTlfBMoAE6TTY909B9YITvVYjT1A33NKYC8Ifwz2UUxzyyPn/WJYYp7DPisrBzMfXZcZIVLIuNegiuKm0bpE/9+xwpj7v+gWaWvt0uh4oiPcxlS1wmaKxMpRwGvqv8UoE65ERymxCageuPtuI=
X-Sasl-enc: LQvKzGI3CNxYVQyIYJOQbtMOBp4QGtLfY4xORwNCA+tx 1284645493
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CB8EF4065E8;
	Thu, 16 Sep 2010 09:58:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <AANLkTin_5drpRva6jiwwC-OpMSxnYwJu5fJD4aU7P5jq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156333>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 16.09.2010 1=
3:41:
> On Thu, Sep 16, 2010 at 11:23, Peter Krefting <peter@softwolves.pp.se=
> wrote:
>> Robin Rosenberg:
>>> (My comments are in swedish as it feels more natural in this contex=
t).
>>
>> While I do agree, I'm trying to reply in English since the Git list =
is in
>> English.
>=20
> Usually yeah, but when a PO file is under discussion only people that
> speak the language can contribute usefully anyway, so I think it's OK
> if that discussion is not in English.

How about "[L10N SE] etc." subject lines etc.? That way people can
easily filter out all L10N posts but keep those relevant to them
(including their language).

>=20
>> Fixed.
>>
>>> Tag =3D etikett
>>
>> While I do agree, I have never heard anyone use "etikett" for a tag =
in the
>> computer science sense (neither a HTML tag nor a VCS tag). While "ta=
gg" is
>> obviously horrible, I do use it in the translations simply because t=
hat is
>> what everyone else is using.
>=20
> FWIW mercurial uses m=C3=A4rke, e.g.:
>=20
>     msgid ""
>     "The reserved name \"tip\" is a special tag that always identifie=
s the\n"
>     "most recent revision."
>     msgstr ""
>     "Det reserverade namnet \"tip\" =C3=A4r ett speciellt m=C3=A4rke =
som alltid\n"
>     "identifierar den senaste revisionen."
>=20
> and:
>=20
>     "denotes the tipmost revision of that branch. Tag and branch name=
s must\n"
>     "not contain the \":\" character."
>=20
>     "anger den h=C3=B6gsta revisionen p=C3=A5 den grenen. M=C3=A4rkes=
- och grennamn kan inte\n"
>     "inneh=C3=A5lla tecknet \":\"."
>=20
> and:
>=20
>     msgid "replace existing tag"
>     msgstr "ers=C3=A4tt existerande m=C3=A4rke"
>=20
>     msgid "make the tag local"
>     msgstr "g=C3=B6r m=C3=A4rket lokalt"
>=20
>     msgid "remove a tag"
>     msgstr "ta bort ett m=C3=A4rke"
>=20
> etc.

I'm trying to advocate "Marke" for DE ;)
In fact, subversion seems to be a good source for inspiration - at leas=
t
for the terms...

Michael
