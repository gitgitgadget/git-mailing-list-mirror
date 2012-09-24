From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Mon, 24 Sep 2012 21:43:05 +0200
Message-ID: <CANQwDweRf1_UzRozSeRoF4p-Qh-tJq+mLYJq0GSL7dW8_umpSg@mail.gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <201109031738.11678.jnareb@gmail.com>
 <CAMP44s2ZSKx3jDZOSX7EM2bYtuUvvEctZYw6R3wNWQEbCeX4Rw@mail.gmail.com>
 <201109141939.14070.jnareb@gmail.com> <CAMP44s31xx5qfF4-f3kGsa1uEe7TMVmqSDvB9zL=prR12xwM6g@mail.gmail.com>
 <CANQwDwfVM+besf2if-z6UT6K1QYfj7A7jXsEgfyfxJ1Ww9oBdA@mail.gmail.com>
 <vpqobkvxwhq.fsf@grenoble-inp.fr> <CANQwDwe1H3Va5T7uy6zUJ0oz_mk0=fW8hK_buky4x4hMThY9UQ@mail.gmail.com>
 <vpqobkvwg1r.fsf@grenoble-inp.fr> <CANQwDwew-PGq03q4VyjbzqPJxM+cB2O4J810ft67Cqn0xVwFKQ@mail.gmail.com>
 <vpqhaqnw6xc.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 24 21:43:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGEZ5-0005ac-C4
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 21:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906Ab2IXTn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2012 15:43:26 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38351 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757869Ab2IXTn0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 15:43:26 -0400
Received: by obbuo13 with SMTP id uo13so5066637obb.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XjyD4GlebGo9u3jOPmeMruJiQOsP5V1XluHN329/OM4=;
        b=ScreI72yjcNhQ98E1oHanCcu3n9B5kgel6aqe2bOp0dePSpSInbCMOqa0JoKlov6Tn
         JC4pecqDuJPrQ6oCXOvpxqiXlZMm2DWO2E7rscG37Tm4OD7E8D7Jp6DAQrIZGDlpIbD9
         VXLQnRWWhyHTIMbnL6hyXKCABFClDTuIQkbGmJV09t21Qyd5xbnneSPYlnzknt6goR/v
         iQGSVZB1DeDy1AmCcHWKSvKlGIInDJi3lt+ttinDkylaZIfoDxol4jTph4ycI4p6QSz0
         pdWZIYnYejMfLVhVPmLf7AS8aA+xwgwFIQXQOzIsbxMKBC4dRuxKvC0aa9d0aT8wi7Fj
         855w==
Received: by 10.182.76.164 with SMTP id l4mr10902011obw.65.1348515805359; Mon,
 24 Sep 2012 12:43:25 -0700 (PDT)
Received: by 10.76.163.98 with HTTP; Mon, 24 Sep 2012 12:43:05 -0700 (PDT)
In-Reply-To: <vpqhaqnw6xc.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206320>

On Mon, Sep 24, 2012 at 9:35 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jakub Nar=EAbski <jnareb@gmail.com> writes:
>
>> On Mon, Sep 24, 2012 at 6:18 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Jakub Nar=EAbski <jnareb@gmail.com> writes:
>>>
>>>> I have therefore added the following multiple-choice question:
>>>>
>>>> #19. What git workflow(s) is used by projects in which development=
 you
>>>> participate?
>>>
>>> If we want to have an idea of which workflows are the most commonly
>>> used, just a binary answer may be insufficient. We can't distinguis=
h
>>> between "X% people use workflow W all the time", and "X% people use
>>> workflow W from time to time".
>>
>> The problem is that those workflows are used by _projects_ not _peop=
le_,
>
> Yes, but people are usually involved in multiple projects. Someone
> involved in 10 different distributed projects and sometimes contribut=
ing
> to 1 centralized would count 1 for each.
,
True.  So responses wouldn't tell us the full story.

But first, never/rarely/sometimes/often/always doesn't fit IMHO here.

Second, the situation is more complicated: one can be actively involved
in 1 distributed project with 200+ contributors via Gerrit, often contr=
ibute
to 1 centralized project with 15-25 contributors, and rarely interact w=
ith
distributed project using "blessed" repository workflow where number
of contributors range from few to few hundred.  Too complicated for
survey IMHO.

Third, no other in matrix form.
--=20
Jakub Narebski
