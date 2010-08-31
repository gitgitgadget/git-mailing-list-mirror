From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 15/17] po/is.po: add Icelandic translation
Date: Tue, 31 Aug 2010 21:49:34 +0200
Message-ID: <AANLkTi=4U2_ascHbC77Rbrb8FGtT7hiOr0MUqfbeWztS@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-16-git-send-email-avarab@gmail.com> <20100831152959.GH2315@burratino>
 <AANLkTimYETJcHuKBBRKJ0zbkRBR-K2VAXRLizFQxa-pr@mail.gmail.com>
 <AANLkTimGSEVLOjTLt2yntXaDfyUkj=mY46evfRx517MC@mail.gmail.com> <AANLkTin5+Sdx3MRrERpFUD04=CSmNyPoB3zRvNxKLLpj@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:50:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWqZ-0007Wl-UP
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363Ab0HaTt7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 15:49:59 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46725 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab0HaTt6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 15:49:58 -0400
Received: by vws3 with SMTP id 3so5705725vws.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=ZZu0SQq2eIP4ltjw1mSdzfLrftbxPVesyeRx5T9KpHM=;
        b=jY4zrmiKeqCqijP3vuQqeMypFJkqamlMJ+6q5GsTBYQffxrDw8RK+V9N9obxXZDCmA
         jD8Qea0m8O+23iweJeotrHrQwJKDR/I0drwMCKeo3D9IjCk9f5XiVUw/7u2ximKUEW+X
         eFJ8i5tPkl9NauyFYgYObZx75OksXPHk3TxKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=P0uKkio3RJI9OQm3ajyO5m3GMD/AbM/4Cjda9TNiy7p5XVuWUtRZ634Gidgt4/g4Ya
         vQ1cK2lLcABSfBHGjjN9ntoqPQHymFurs+wZmpKlNnL1qt6FHVNGD6JQKvAYsgX/HHZa
         Agpk0mZjNhLg3pqOA0BfrMDPkKxd1lGoweGjE=
Received: by 10.220.60.204 with SMTP id q12mr3598760vch.183.1283284194278;
 Tue, 31 Aug 2010 12:49:54 -0700 (PDT)
Received: by 10.220.180.76 with HTTP; Tue, 31 Aug 2010 12:49:34 -0700 (PDT)
In-Reply-To: <AANLkTin5+Sdx3MRrERpFUD04=CSmNyPoB3zRvNxKLLpj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154978>

On Tue, Aug 31, 2010 at 9:32 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Aug 31, 2010 at 19:14, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> On Tue, Aug 31, 2010 at 7:01 PM, =C6var Arnfj=F6r=F0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> On Tue, Aug 31, 2010 at 15:29, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>>>> =C6var Arnfj=F6r=F0 Bjarmason wrote:
>>>>
>>>>> --- a/po/is.po
>>>>> +++ b/po/is.po
>>>>> @@ -11,35 +11,154 @@ msgstr ""
>>>>> =A0"Content-Type: text/plain; charset=3DUTF-8\n"
>>>>> =A0"Content-Transfer-Encoding: 8bit\n"
>>>>>
>>>>> -#: t/t0200/test.c:4
>>>>> +#: builtin/init-db.c:34
>>>>
>>>> Is there a diff driver that will ignore these --add-location lines=
?
>>>>
>>>> Alternatively, would it be possible to get msgmerge and xgettext t=
o
>>>> provide the filenames without the line numbers? =A0My experience i=
s
>>>> that most translation diffs are very hard to read because about 80=
%
>>>> noise. :(
>>>>
>>>> Aside from that, this looks good and sane (well, the English part
>>>> I can read does).
>>>
>>> Some context, an earlier discussion on this:
>>> http://kerneltrap.org/mailarchive/git/2010/5/30/31415/thread#mid-31=
415
>>>
>>
>> msgmerge and xgettext does seem to have the --no-location flag to
>> avoid these annotations from being generated. The documentation does
>> say "Note that using this option makes it harder for technically
>> skilled translators to understand each message's context. ", though.
>> But perhaps the annotated versions could be generated when needed an=
d
>> never checked-in (similar to what you suggested in that e-mail)? It
>> sounds to me like that would give us the best of all worlds. If it's
>> possible, that is.
>
> It's certainly possible. But each time you worked with these files
> you'd have add the line numbers yourself to generate the context, the=
n
> translate, then remove them again, then submit your patch.
>
> I just think it's overly tedious work for getting smaller diffs.
>

You know, computers are pretty good at automating tedious jobs ;)

I was thinking something along the lines of having po/is.po etc, and
generating po/is.ann.po (or something) from these (+source) so
translators can see the text in the context of the code. That is, they
edit is.po, and generate is.ann.po when they want to see the context.
Then we can put *.ann.po in .gitignore, and it's really just a matter
of editing, doing "make po/is.ann.po", and voila.

But I dunno, I haven't been using these tools much myself.
