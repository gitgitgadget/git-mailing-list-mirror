From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 15/17] po/is.po: add Icelandic translation
Date: Tue, 31 Aug 2010 19:32:05 +0000
Message-ID: <AANLkTin5+Sdx3MRrERpFUD04=CSmNyPoB3zRvNxKLLpj@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<1283203703-26923-16-git-send-email-avarab@gmail.com>
	<20100831152959.GH2315@burratino>
	<AANLkTimYETJcHuKBBRKJ0zbkRBR-K2VAXRLizFQxa-pr@mail.gmail.com>
	<AANLkTimGSEVLOjTLt2yntXaDfyUkj=mY46evfRx517MC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 31 21:32:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWZ3-0003sk-GG
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218Ab0HaTcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 15:32:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36963 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924Ab0HaTcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 15:32:06 -0400
Received: by gxk23 with SMTP id 23so2680679gxk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5yS3ycuFYagfRP159ruNhYeRVq/eQT++k3WnbAcmPLw=;
        b=xNnPaBa12dFTPIq4hWlcLivzNQ0OJR9TcezlehCAJY7oAqkvoYJbuYe5dlA40iajh/
         Ei8twKWMfUxwqX63Y8ElDGOn0da2MbQviJSMQROJdAyZhcdlip/TDwyE1cbUBC+Mx4DS
         AiTThbwV8Z4ERJcHRuEPe0Sl2ggrYkhV4NKzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hr17ScdRsMZEWQltL1yJzUjFN2M/4OfTQL3SyP/ygjtPfjVKLnZU6QOOsrwcCADWx9
         gY3u7u8t5zu7ZuOGwmSFR/vf0mA37P96ygS6y5wyPw5lVo1nHAsqffqJSX1HS5436pDj
         h3JkSvhIm+GeHpJ//qn5pAQZJ1SrxxvPV64+E=
Received: by 10.101.183.33 with SMTP id k33mr7149232anp.16.1283283125434; Tue,
 31 Aug 2010 12:32:05 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 31 Aug 2010 12:32:05 -0700 (PDT)
In-Reply-To: <AANLkTimGSEVLOjTLt2yntXaDfyUkj=mY46evfRx517MC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154973>

On Tue, Aug 31, 2010 at 19:14, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Tue, Aug 31, 2010 at 7:01 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Tue, Aug 31, 2010 at 15:29, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>>> --- a/po/is.po
>>>> +++ b/po/is.po
>>>> @@ -11,35 +11,154 @@ msgstr ""
>>>> =C2=A0"Content-Type: text/plain; charset=3DUTF-8\n"
>>>> =C2=A0"Content-Transfer-Encoding: 8bit\n"
>>>>
>>>> -#: t/t0200/test.c:4
>>>> +#: builtin/init-db.c:34
>>>
>>> Is there a diff driver that will ignore these --add-location lines?
>>>
>>> Alternatively, would it be possible to get msgmerge and xgettext to
>>> provide the filenames without the line numbers? =C2=A0My experience=
 is
>>> that most translation diffs are very hard to read because about 80%
>>> noise. :(
>>>
>>> Aside from that, this looks good and sane (well, the English part
>>> I can read does).
>>
>> Some context, an earlier discussion on this:
>> http://kerneltrap.org/mailarchive/git/2010/5/30/31415/thread#mid-314=
15
>>
>
> msgmerge and xgettext does seem to have the --no-location flag to
> avoid these annotations from being generated. The documentation does
> say "Note that using this option makes it harder for technically
> skilled translators to understand each message's context. ", though.
> But perhaps the annotated versions could be generated when needed and
> never checked-in (similar to what you suggested in that e-mail)? It
> sounds to me like that would give us the best of all worlds. If it's
> possible, that is.

It's certainly possible. But each time you worked with these files
you'd have add the line numbers yourself to generate the context, then
translate, then remove them again, then submit your patch.

I just think it's overly tedious work for getting smaller diffs.
