From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [RFC] Questions for "Git User's Survey 2011"
Date: Tue, 25 Sep 2012 08:57:48 +0200
Message-ID: <CANQwDwcejFKoNoDOSAhyLZTZoYLGsUwH29JiAGGzna2cRwNuPw@mail.gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <201109031738.11678.jnareb@gmail.com>
 <CAMP44s2ZSKx3jDZOSX7EM2bYtuUvvEctZYw6R3wNWQEbCeX4Rw@mail.gmail.com>
 <201109141939.14070.jnareb@gmail.com> <CAMP44s31xx5qfF4-f3kGsa1uEe7TMVmqSDvB9zL=prR12xwM6g@mail.gmail.com>
 <CANQwDwfVM+besf2if-z6UT6K1QYfj7A7jXsEgfyfxJ1Ww9oBdA@mail.gmail.com>
 <vpqobkvxwhq.fsf@grenoble-inp.fr> <CANQwDwe1H3Va5T7uy6zUJ0oz_mk0=fW8hK_buky4x4hMThY9UQ@mail.gmail.com>
 <vpqobkvwg1r.fsf@grenoble-inp.fr> <CANQwDwew-PGq03q4VyjbzqPJxM+cB2O4J810ft67Cqn0xVwFKQ@mail.gmail.com>
 <vpqhaqnw6xc.fsf@grenoble-inp.fr> <CANQwDweRf1_UzRozSeRoF4p-Qh-tJq+mLYJq0GSL7dW8_umpSg@mail.gmail.com>
 <vpq8vbywrro.fsf@grenoble-inp.fr> <CANQwDweD-OSDKkA9P1FPr4jhvv2su5W86J+P8BRV8MmEBgC8BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 08:58:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGP63-0000Vz-RL
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 08:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab2IYG6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 02:58:10 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58342 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab2IYG6J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Sep 2012 02:58:09 -0400
Received: by obbuo13 with SMTP id uo13so5522312obb.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=WN4z1P8d+ilPjCYN741geisvPKw2Rq5uN3ii0iungY0=;
        b=ABapq17ulO3pYutpEqjECN8UKQKGEW1dZ2jo0msJdHQ312ofu4uFeO0LUxdvbWUuBT
         2lIAxlOVFVxonLO77vv1DK7uQi6QKPkqWZzj40GN5xcK/p7fLIY0tUutNsGBO0oogdX6
         1M0c7pm5e0+o9KFDasB09bBZIRksZxFJops8OZ2aVmXagfr4YvVOtBrPXjU/r/PztYW8
         crGdfRLazfjdaia+t/U9Fwbrv7InWFW2dziaZtiI33mO5FN0WlCM4KLrEjHe2fFe6its
         vw2YzbNnRMNDyKEJ94R9R6ISKcFJe6v5ntC2h5Wa06iQFeBOD5dFaEyLeQfDuQxdsvH/
         B8+A==
Received: by 10.182.111.74 with SMTP id ig10mr12043455obb.14.1348556288264;
 Mon, 24 Sep 2012 23:58:08 -0700 (PDT)
Received: by 10.76.163.98 with HTTP; Mon, 24 Sep 2012 23:57:48 -0700 (PDT)
In-Reply-To: <CANQwDweD-OSDKkA9P1FPr4jhvv2su5W86J+P8BRV8MmEBgC8BA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206349>

[I'm sorry for breaking the chain, but I have accidentally hit Reply,
instead of Reply To All, and missed sending reply to git mailing list]

On Tue, Sep 25, 2012 at 8:17 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jakub Nar=EAbski <jnareb@gmail.com> writes:
>
>> Second, the situation is more complicated: one can be actively invol=
ved
>> in 1 distributed project with 200+ contributors via Gerrit, often co=
ntribute
>> to 1 centralized project with 15-25 contributors, and rarely interac=
t with
>> distributed project using "blessed" repository workflow where number
>> of contributors range from few to few hundred.
>
> We're doing a user survey, so if a project has 200 contributors, it w=
ill
> statistically have 10 times more survey participants than a 20
> contributors project. Sure, statistics don't always work, but if we
> don't trust statistics, we shouldn't do a survey.

I always worry if the set of survey participants is representative...

>> Third, no other in matrix form.
>
> Well, forcing the user to chose between existing options is not
> necessarily bad IMHO. It at least avoids free-form answers like "I'm
> doing almost exactly option b) but I don't call it this way so I didn=
't
> tick b)".

There is another issue: there are many, many questions which
are currently in multiple answers form (e.g. transports, or tools),
some of them with "other, please specify", which are in the same
boat wrt. precision / accuracy as discussed "workflow" question.

So, NAK for this year survey, we can think about and discuss it
for the next one (if there would be interest in having one).
--
Jakub Narebski


--=20
Jakub Narebski
