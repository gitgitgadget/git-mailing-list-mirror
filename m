From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] Add Swedish translation.
Date: Thu, 16 Sep 2010 11:41:23 +0000
Message-ID: <AANLkTin_5drpRva6jiwwC-OpMSxnYwJu5fJD4aU7P5jq@mail.gmail.com>
References: <20100912202111.B11522FC00@perkele>
	<alpine.DEB.2.00.1009151124100.11791@ds9.cixit.se>
	<A612847CFE53224C91B23E3A5B48BAC749BFA3D12C@xmail3.se.axis.com>
	<201009160046.47367.robin.rosenberg@dewire.com>
	<alpine.DEB.2.00.1009161209500.18826@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Git <git@vger.kernel.org>, Swedish <tp-sv@listor.tp-sv.se>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Sep 16 13:41:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwCqI-0001AS-Bf
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 13:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0IPLlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 07:41:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52423 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab0IPLlY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 07:41:24 -0400
Received: by iwn5 with SMTP id 5so1005770iwn.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GXRoDT0qudQrfnz9lskWvYRu04DKEuDP7CnmOV3xf1k=;
        b=jqGtjPzzj+atYsRhcmFIM/v7hv047oQ4upbOpK7yYXzkP99zUMD2K6jWu8+sXF6Fe6
         vuRyRl+p7Ci3TT/bZrkB6v50gxHjgOshvD93Ufa4vcPl9TaIdDs84exAlk7Z9vdDyFU9
         6UysVAgm8dvAQm3qL7ZBYaKy0szbd/BN4OUFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E2R8KyoaIBKU6sMFTpf8VDrxvi7JD+7lVFbR0Xc6BGAgmqP57LgHvm6wujao8mzDvI
         5ZcC5+j+O5yISWq6DaO7yDWln3khWKfpmv12H5RbvIHnow6NRumar/cctRBBo9tEIW+E
         rXx687ZjCUXRhM7pAsV4hcN693QxaHk0XJSxk=
Received: by 10.231.168.21 with SMTP id s21mr3270726iby.123.1284637283996;
 Thu, 16 Sep 2010 04:41:23 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 16 Sep 2010 04:41:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1009161209500.18826@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156323>

On Thu, Sep 16, 2010 at 11:23, Peter Krefting <peter@softwolves.pp.se> =
wrote:
> Robin Rosenberg:
>> (My comments are in swedish as it feels more natural in this context=
).
>
> While I do agree, I'm trying to reply in English since the Git list i=
s in
> English.

Usually yeah, but when a PO file is under discussion only people that
speak the language can contribute usefully anyway, so I think it's OK
if that discussion is not in English.

> Fixed.
>
>> Tag =3D etikett
>
> While I do agree, I have never heard anyone use "etikett" for a tag i=
n the
> computer science sense (neither a HTML tag nor a VCS tag). While "tag=
g" is
> obviously horrible, I do use it in the translations simply because th=
at is
> what everyone else is using.

=46WIW mercurial uses m=C3=A4rke, e.g.:

    msgid ""
    "The reserved name \"tip\" is a special tag that always identifies =
the\n"
    "most recent revision."
    msgstr ""
    "Det reserverade namnet \"tip\" =C3=A4r ett speciellt m=C3=A4rke so=
m alltid\n"
    "identifierar den senaste revisionen."

and:

    "denotes the tipmost revision of that branch. Tag and branch names =
must\n"
    "not contain the \":\" character."

    "anger den h=C3=B6gsta revisionen p=C3=A5 den grenen. M=C3=A4rkes- =
och grennamn kan inte\n"
    "inneh=C3=A5lla tecknet \":\"."

and:

    msgid "replace existing tag"
    msgstr "ers=C3=A4tt existerande m=C3=A4rke"

    msgid "make the tag local"
    msgstr "g=C3=B6r m=C3=A4rket lokalt"

    msgid "remove a tag"
    msgstr "ta bort ett m=C3=A4rke"

etc.
