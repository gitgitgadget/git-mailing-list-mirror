From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Mon, 11 Jun 2012 12:27:02 +0200
Message-ID: <CAMP44s1ESu0WKYmR6g51q3cwJ-BWC22SuTHucGVSEsGuGTrxDQ@mail.gmail.com>
References: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
	<CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com>
	<7vbokwmifp.fsf@alter.siamese.dyndns.org>
	<CAMP44s2VGLj8kRih-95A0VDq86WKWHF3EhLvz0etyHHtP27qLA@mail.gmail.com>
	<4FD4DBD7.5070204@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 11 12:27:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se1q2-0005oa-Ls
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 12:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084Ab2FKK1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 06:27:05 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52493 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751806Ab2FKK1D convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 06:27:03 -0400
Received: by lahd3 with SMTP id d3so2583261lah.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 03:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5C9U8gbOTTaKFpOFhMSEmhXLGrc936AVBgKnGN3Vc7w=;
        b=njtNmLXbUfJsQA2w63YLm64L0ciqWeTDD2fFzh2TZQMEkCZH+k5NxjY5h6eW4Roq/u
         0sTa1mWYLSAam0pmoWvAK8/5X5+n9IXO9gQfCbhpcjMY365lmsIdNIfWhfBVaozDnnU0
         IAJQez5Sum1StLWHwiR49xBfeMNkPnScxJ1+6Rt5wHOE7fpnmnVTJxRo4evOAwt7BAIf
         CNPX+IHWd32zLlh/E5c2djwoTG4g86nMbZzG9ir5KLet9v1P4q0UY8wmAqNtmcTbxmG2
         eKR+I4iwsDgxJHzNJ87m/vkx5kYl2UOEYb1MmCC1EH/Omx1eUGvt5+6jSk9RTrfBJSAB
         LSNw==
Received: by 10.152.125.116 with SMTP id mp20mr16653849lab.19.1339410422454;
 Mon, 11 Jun 2012 03:27:02 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Mon, 11 Jun 2012 03:27:02 -0700 (PDT)
In-Reply-To: <4FD4DBD7.5070204@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199640>

On Sun, Jun 10, 2012 at 7:39 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 06.06.2012 20:17, schrieb Felipe Contreras:
>
>> On Wed, Jun 6, 2012 at 7:58 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>>
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>>> The last remaining sticking point is what to do with the duplicat=
ed
>>>>> shell
>>>>> function.
>>>>
>>>>
>>>> What is the problem with leaving it as it is; having it as a dupli=
cate
>>>> function. It's not a *huge* maintenance burden, and it's a big pro=
blem
>>>> if the functions diverge.
>
>
> In the last sentence you say that there would be a "big problem".
>
>
>>> It is not even funny to see these two conflicting claims made in a
>>> single sentence. =C2=A0Given that you are aware that it will cause =
a huge
>>> problem to the end users if they diverge,
>>
>>
>> What would be that *huge* problem?
>
>
> Here you ask what's so bad about it.
>
> Perhaps you meant to write "it's NOT a big problem" in the first plac=
e?

Yeap, that's what I meant.

--=20
=46elipe Contreras
