From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Splitting the mailing list up
Date: Sun, 26 Sep 2010 18:54:43 +0000
Message-ID: <AANLkTik3ES08H1VSaGxv7aDoV3Ki_Y2ea2dHYqem0S28@mail.gmail.com>
References: <20100925230022.6e2fd389.coolzone@it.dk>
	<AANLkTikXSfO0uGP1b20jkF09=Mfq0s0+4d4_ANeprXF_@mail.gmail.com>
	<8AE74FC9-6C7F-433E-A162-E56644847198@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastien Douche <sdouche@gmail.com>, Rico Secada <coolzone@it.dk>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 20:54:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzwN8-000463-7L
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 20:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376Ab0IZSyq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 14:54:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62184 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178Ab0IZSyo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Sep 2010 14:54:44 -0400
Received: by iwn5 with SMTP id 5so4077556iwn.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/AFaidlXOkdbU5xDItkYo2feSEATSpPotGP9aYuHl7s=;
        b=eMTGKjwqXuPXAJLl8rHIUejPra7MBzuiYOHIKnkxyIKQHw+fNC8A7s16MBY8cSj5rs
         kjixCPJAnTfRKHUbOqDlzBZEj+Liw/B0ln181y2lutN3SMC4XhWL9p9/MvbNdQRFjLMU
         FRhnv1xL7OJQRei4J36tSC169KhCk3VxlYiJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IVtoxs2Qu6NEEj4zMkjjPmJQOwK64FfG4aNYGKS022ckGb5yvpqOWVPeFofH0IdsLM
         9DMZAgocMquYtuwrumpOjlWRKvfFqtEyM6hDdbOQ8qMJ8SUL5J4N1S4mrP/Hwf+oPrCO
         V64ql6JLVJG8iaVmDtrXiOD19KgVzHq0nbAP4=
Received: by 10.231.149.3 with SMTP id r3mr7670236ibv.109.1285527284022; Sun,
 26 Sep 2010 11:54:44 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 26 Sep 2010 11:54:43 -0700 (PDT)
In-Reply-To: <8AE74FC9-6C7F-433E-A162-E56644847198@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157252>

On Sun, Sep 26, 2010 at 17:30, Wincent Colaiuta <win@wincent.com> wrote=
:
> El 26/09/2010, a las 18:02, Sebastien Douche escribi=C3=B3:
>
>> On Sat, Sep 25, 2010 at 23:00, Rico Secada <coolzone@it.dk> wrote:
>>> Would it be a bad idea to split the Git mailing list up in several
>>> sub-categories?
>>>
>>> Example:
>>>
>>> announce@
>>> dev@
>>> user@
>>
>> Why not, but the simple way is to create another ml for patchs.
>> Without patchs, the traffic seems relatively low.
>
> This has come up many times, and been rejected each time. Check the a=
rchives for the reasons why.

Right, but for the *main* mailing list. However if Rico, Walter and
others would find a limited traffic mailing list valuable there's
nothing stopping them from setting one up.

Jay linked to an archive where someone is running RSS feeds of the
different parts of the git list, similarly you could set up a git-user
list which would be a version of the git list filtered to reduce patch
traffic.

Maybe that list wouldn't make much sense when patches are intermingled
with regular discussion, but it's worth a try.
