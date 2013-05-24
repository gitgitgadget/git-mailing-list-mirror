From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: English/German terminology, git.git's de.po, and pro-git
Date: Fri, 24 May 2013 18:41:45 +0200
Message-ID: <CAN0XMOJn7jW_7FUpEvdSc4X0oop4VWm83vVq6Usu3O5EBJupjw@mail.gmail.com>
References: <87k3n36nvo.fsf@linux-k42r.v.cablecom.net>
	<CAN0XMOJ7hRwTAR+i8_C2z2NmmcycLQkiya0ayfWS0vAw3-zqkg@mail.gmail.com>
	<CAN0XMOKCppZVwwvowzrSDuAKRo-DMeD7GpryjA2deE5mYuSb4Q@mail.gmail.com>
	<7402110.vsgz8zEiin@cs-pc>
	<CAN0XMOK4oniunZz5KpC1x=JrY4yH4HnecxMSCyPF+kEyYRRjTw@mail.gmail.com>
	<20130523181615.GB3270@client.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
	Jan Engelhardt <jengelh@inai.de>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ralph_Hau=C3=9Fmann?= <ralph@scanmyfood.de>,
	Sven Fuchs <svenfuchs@artweb-design.de>,
	git <git@vger.kernel.org>, =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Fri May 24 18:41:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufv3v-00030Z-7X
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071Ab3EXQls convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 May 2013 12:41:48 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:50274 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab3EXQlq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 May 2013 12:41:46 -0400
Received: by mail-ve0-f179.google.com with SMTP id d10so1272720vea.24
        for <git@vger.kernel.org>; Fri, 24 May 2013 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RaUJS4fUYLshJ7v5H8k9rOHeDuV6pYNffVeUu+bHQB4=;
        b=gtlEw8OrglLGSk7gtTX2wgV3lEZV1Vb9ovwJexXSX/Gz6yVF4hvhfnjpr8Boc4bxP3
         3eDK7NyDb4PvTQpJWhJFwYM3xK/TPouDzktAtq88ClIZTQaYO+2o064DiIztV9neQIbc
         L0ZGdPwgtEUD9zvuKXSTATMuXB5xj7lM4WejosPUfq6QogHrJ/eT8GvjTDI7kckc1Krw
         p9/fijTEBkmapl+qC3cTyI4AvRFXtIi1Ir5GYQyEje9e5ohXi2SnbdjOlwMJS7r8H2Zu
         LyAZRjYp4nJ3/0kIG2gXOTQsPv80Yp8zPq9Qd3QopoZv4+WvfOJayUHN4OJ4JDX+CsA6
         eTBg==
X-Received: by 10.52.0.102 with SMTP id 6mr8102346vdd.9.1369413705709; Fri, 24
 May 2013 09:41:45 -0700 (PDT)
Received: by 10.220.106.208 with HTTP; Fri, 24 May 2013 09:41:45 -0700 (PDT)
In-Reply-To: <20130523181615.GB3270@client.brlink.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225378>

2013/5/23 Bernhard R. Link <brl+git@mail.brlink.eu>:
> * Ralf Thielow <ralf.thielow@gmail.com> [130522 17:17]:
>> >>     remote branch          =3D Remote-Branch
>> >>     remote-tracking branch =3D Remote-Tracking-Branch
>> >>     upstream branch        =3D Upstream-Branch
>> >
>> > Yes. What's the main reason for using "Branch" in the German text?=
 Consistency
>> > with the commands, or assumed familiarity of the term within the t=
arget
>> > audience? "Zweig" is available.
>> >
>>
>> I think it's at the same level as "Commit" and a well known SCM-term=
=2E Users
>> (even beginners) who know "Commit" and "Tag" do also know "Branch". =
And
>> I think it sounds better in combination with "Remote-", "Remote-Trac=
king-" and
>> "Upstream-" which are english words.
>
> Additionally "Zweig" might be a bit misleading. A branch is not part =
of
> the "tree"s. It is called branch because in other VCSes the commits
> build a tree and a any commit outside of the main branch of that tree=
 is
> part of exactly one different branch (so the head of that branch and =
the
> branch are synonymns). With git the commits are no longer a tree, so =
a
> git-branch is no branch and does not describe the whole branch of the
> tree of commits but is just a names pointer into the graph of commits=
=2E
> As it lost all meanings of the original word "branch", translating it
> with a translation of the original English word might more confusion
> than helping anyone.
>
>> (same for push). In other messages, the translation is in the same m=
essage
>> as the command itself. I think it's OK when we just use "fetch" and =
"push"
>> when the command is meant (as it's done for "pull", e.g. in error me=
ssages),
>> and the translation when the messages tell what the command is doing=
 (e.g. help
>> messages). So it would depends on the message whether we translate t=
he word
>> or not. This would apply to other terms that are commands, too, like
>> "clean" or "revert".
>
> I'd not call it "OK". It's the only sane possibility. If you speak
> about the magic keyword you have to give the command line, you won't
> translate it, of course[1]. (The obvious interesting case is where th=
e
> English text plays with the command name having a meaning as word
> itself. Here the translation will have to diverge to differentiate
> between both (or sacrifice one of them, where it is not important)).
>
> [1] Unlike you want to introduce a translated command line interface,
> like "Depp anfordere Herkunft Original" instead of "git fetch origin =
master"
>
>> >>     diff               =3D Differenz
>> >>     delta              =3D Differenz (or Delta)
>> >>     patch              =3D Patch
>> >>     apply              =3D anwenden
>> >>     diffstat           =3D (leave it as it is)
>> >>     hunk               =3D Bereich
>> >
>> > IMHO "Kontext" is better if you use a German word. Technically the=
 context is
>> > something else, but in a German text IMHO it fits nicer when expla=
ining to the
>> > user where he/she can select the n-th hunk.
>> >
>>
>> Not sure if German users would know what "hunk" means, in case we
>> leave it untranslated. And I'm not sure if I would understand "Konte=
xt".
>> I tend to leave it untranslated.
>
> Anyone found a German translation of the Patch manpage? Translating t=
he
> English word-play here, I'd suggest "Block" or "Patch-Block".
>
>> >>     paths          =3D Pfade
>> >>
>> >>     symbolic link =3D symbolische Verkn=C3=BCfung
>> >>     path =3D Pfad
>> >>     link =3D Verkn=C3=BCpfung
>
> In the filesystem a "Link" is a "Verweis" in Unix, not a "Verkn=C3=BC=
pfung"
> (that are usually the pseudo-links Windows supports).
>
>         Bernhard R. Link

Thanks.
