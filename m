From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 27 new messages
Date: Sat, 8 Feb 2014 21:20:06 +0100
Message-ID: <CAN0XMOLmcj0pqtbfGL7u+FOAg5_dv3+5Twb=SFju7BW=vkq1YQ@mail.gmail.com>
References: <1390511452-6553-1-git-send-email-ralf.thielow@gmail.com>
	<877g95motv.fsf@thomasrast.ch>
	<874n49ctsz.fsf@fencepost.gnu.org>
	<87fvntl8xh.fsf@thomasrast.ch>
	<87zjm1bea6.fsf@fencepost.gnu.org>
	<CAN0XMOL29EgA4KHHP1qqGo4vd7ezKMzPnxGzc0gcY_fbNe6bsQ@mail.gmail.com>
	<87vbwpbcjx.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	git <git@vger.kernel.org>, Xin Jiang <worldhello.net@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 08 21:20:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCENs-0005Cz-4E
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 21:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbaBHUUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 15:20:09 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:50492 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaBHUUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 15:20:08 -0500
Received: by mail-wi0-f170.google.com with SMTP id hi5so1711890wib.5
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 12:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3EWiyf7pN/qxXHsa7JKaV08adqnMdoE5funY6CDSeoI=;
        b=BECd2gVG6iMBj+K/tuHD4qv+J6MuZ5OwC6zFoU5jK1eAZLM3V+tXh7/BDvKm/wtBsD
         dHYMCPC92dLZ8pZ+9FgO6i0zYgHAIu+p9yWBVJNt2QzuFi1nMBGccn2wyOrsGDJev/z8
         /LWDH//WqIOMFDU4KJoX1H0TL9Y7FOMCqxxN06jjZ+D7y5Wzav97NdKtFRkGp9wd9lAa
         bWpinPSdAYH3KtfrgdSs878OCzfIyTxoAVKGGckVE+sw4GypHyx9X29tkfwmCD1j8a0U
         i2nofjSTro39NyfDYfSd+i7veuVWMiN/KXGi2AOHbdbypHBRVU6y7KGJ5Ig5kag6UIt7
         540Q==
X-Received: by 10.181.13.11 with SMTP id eu11mr4541691wid.30.1391890806971;
 Sat, 08 Feb 2014 12:20:06 -0800 (PST)
Received: by 10.194.23.1 with HTTP; Sat, 8 Feb 2014 12:20:06 -0800 (PST)
In-Reply-To: <87vbwpbcjx.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241853>

2014-02-08 20:59 GMT+01:00 David Kastrup <dak@gnu.org>:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> 2014-02-08 20:22 GMT+01:00 David Kastrup <dak@gnu.org>:
>>> "verberge keine aufgepfropften Commits" seems much more in the spir=
it of
>>> the original terminology.  "verbirgt keine Commits mit k=C3=BCnstli=
chen
>>> Vorg=C3=A4ngern" is plainly wrong anyway since it is not the commit=
s _with_
>>> grafts which are hidden but rather the commits _provided_ by grafts=
=2E
>>>
>>
>> Maybe "verbirgt keine Commits auf Basis k=C3=BCnstlicher Vorg=C3=A4n=
ger"?
>
> No.  If at all "Verbirgt keine k=C3=BCnstlichen Vorg=C3=A4nger" or "k=
eine
> k=C3=BCnstlichen Vorg=C3=A4ngercommits" since the "k=C3=BCnstlicher V=
org=C3=A4nger" _is_ the
> commit that is hidden: the graft, if we are being totally meticulous,=
 is
> the list of artificial parents for a given commit.  The option, when
> activated, hides those artificial parents.
>
> And "Do not" is not "Does not", so "Verbirgt" seems also wrong as it
> likely should be "Verberge" (imperative).  But then it would depend o=
n
> the overall style in which this imperative is usually translated.
>

Oh, I seem to have misunderstood the thing :/
So I'd be "verbirgt keine k=C3=BCnstlichen Vorg=C3=A4nger-Commits".
=46or short descriptions of options we currently don't use the imperati=
ve.
This should be changed.
Thanks




> --
> David Kastrup
