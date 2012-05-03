From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: Newbie grief
Date: Thu, 3 May 2012 12:09:22 -0700
Message-ID: <CA+7g9JzZ36RgsniT4UN0Zk+z1ohZYW5u+0AoGMjJZqsoBjqvqA@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F3919.6060805@palm.com>
	<CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
	<20120501111415.GD5769@thunk.org>
	<CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
	<4FA02830.3040407@palm.com>
	<86havzoi8h.fsf@red.stonehenge.com>
	<4FA04D02.6090702@palm.com>
	<86mx5rmx32.fsf@red.stonehenge.com>
	<4FA055D0.7040102@palm.com>
	<86aa1rmvhb.fsf@red.stonehenge.com>
	<4FA05E9F.9090709@palm.com>
	<CAJsNXTmo1B86nSm7u923jJuGX0zajz3iqVu-onANMN-5BE5DfQ@mail.gmail.com>
	<4FA2D1D7.3020807@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Weisberg <pj@irregularexpressions.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Thu May 03 21:09:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ1P7-0005qM-3U
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 21:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824Ab2ECTJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 15:09:24 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62553 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab2ECTJX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 15:09:23 -0400
Received: by bkcji2 with SMTP id ji2so1657785bkc.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 12:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=mUuLkCSd1+zWqAzvHWWHWAmhVj710U7X677VJ2Fs5UA=;
        b=BN/xEDdRZ/40NZMejNVMT+c2rFupYpc5AB6oN1LCUud4AAcU3Vlj4xsA/h6pY27RM3
         LsTAfv575d+aV0uWTqQd5VSK1cRty38kVU6akD4vMc8S6dholNrJ0pTUzIkutrzz3fzo
         StHVGCETL2LkZi80FwyNhrxsDh35QbHGLTdayJPenkUMz1buJsbRXQA44jF1r92krPSg
         uKNZIPuwSAkR3N1ptLGuvjbDy7EU9oqV+nfTUqPzirHBTTvxyCJTxMTc8nQwJugd5YoV
         JS81g457xnpM4jTfRyyp4ERdh0VZqDnBh//gc2w+p4/zXwkf63fpWLr39VtK7xDi3Pki
         vKBA==
Received: by 10.204.153.15 with SMTP id i15mr1154169bkw.74.1336072162112; Thu,
 03 May 2012 12:09:22 -0700 (PDT)
Received: by 10.205.42.6 with HTTP; Thu, 3 May 2012 12:09:22 -0700 (PDT)
X-Originating-IP: [184.182.186.242]
In-Reply-To: <4FA2D1D7.3020807@palm.com>
X-Gm-Message-State: ALoCoQl7B9a/X647s6FG/l1EhIjjsGu9zxvW4PXqM24tSb+1tT8f/sVi3LB0ITZoYslRSOm4fCZq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196943>

On Thu, May 3, 2012 at 11:43 AM, Rich Pixley <rich.pixley@palm.com> wro=
te:
>
> In hg, I don't have to think about how many other branches or reposit=
ories
> there might be. =A0I don't have to track where the changes are. =A0An=
d I don't
> have to do anything to add another repository to the mix or to remove=
 one.
> =A0Trivial merges are trivial. =A0The view from any repository is ide=
ntical, not
> just symmetric. =A0The things I want to do are all simple commands. =A0=
Pull from
> the cache, merge if necessary, do some work, push to the cache. =A0Re=
peat as
> necessary since there will be numerous collisions and merges since I'=
m
> working on multiple machines concurrently. =A0And eventually, push to=
 central
> server.

Wow, this hg sounds great!  You should use that!

All kidding aside, what you're talking about are design decisions
based on preferred workflows.  The workflow you're describing may seem
obvious and fantastic to you, but it sounds absurdly complicated to
me.  You hate the way git handles remote branches.  I think it's
incredibly sensible for a *truly* distributed VCS to enforce
location-based namespacing.  Basically, we have differences of
opinion.  Since your opinion seems to be that hg has done everything
right and git has done everything wrong, why are you using git?

Cheers,
-n8

--=20
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
