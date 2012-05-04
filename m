From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 21:30:38 +0200
Message-ID: <CAMP44s2yv6rfAfFUmGRS5b8=KwFpZ5yLxgL01V9W514PaLUJ9A@mail.gmail.com>
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
	<7v62cf8v2d.fsf@alter.siamese.dyndns.org>
	<4FA054BA.80601@palm.com>
	<86ipgfmw05.fsf@red.stonehenge.com>
	<4FA05C66.2060608@palm.com>
	<CAMOZ1BuiznhrzEOHe0N+uu=mLEw5wWTQyDpnwG8PuF1f_aNaXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rich Pixley <rich.pixley@palm.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:30:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQODF-0000Rw-6f
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287Ab2EDTal convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 15:30:41 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40363 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab2EDTak convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 15:30:40 -0400
Received: by werb10 with SMTP id b10so129059wer.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Irazn4OGwm+IwjKC5TKjbdp0WxxND76ZmHzDFrGm9E8=;
        b=suT7NaYgeuF6mHZTIDcgWj5huQ0sII8i4Ca/BICmAjzqsBzS5bRXJ9Uu9mR774oNaU
         LR7G0aRGfVRsm+HfQ2w6UGGwN6G4EDqxTAXUBNnrgQV3NveOChSJ9R6DrXbxjmzYV1QB
         KXph5IJ36ZvUjBWw5Z+K4kOTN3V7iX7mXptxxzVcsJDCQGUUpTawQau4Vb0DvR5IKE+L
         V1IGvNpWi5ygveboLRKgv5ng1l+N7mYrcfIzrjfPFsu0uYPAGT2FsQ4F+mHG/cmnteUR
         gOjcomw00wz1iy/iqMxZKHOP5tfeCiDZsRo7btdwuwa7a34VRyBllDxDN0tDaTCENYZQ
         7MOw==
Received: by 10.216.225.12 with SMTP id y12mr4514916wep.39.1336159839242; Fri,
 04 May 2012 12:30:39 -0700 (PDT)
Received: by 10.216.124.197 with HTTP; Fri, 4 May 2012 12:30:38 -0700 (PDT)
In-Reply-To: <CAMOZ1BuiznhrzEOHe0N+uu=mLEw5wWTQyDpnwG8PuF1f_aNaXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197058>

On Wed, May 2, 2012 at 12:56 AM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> On Tue, May 1, 2012 at 9:57 PM, Rich Pixley <rich.pixley@palm.com> wr=
ote:
>
>> In contrast, I was up and using mercurial in about a day and a half,
>> including all of the stuff we've discussed, and all of the things I'=
ve even
>> read about in git. =C2=A0Learning mq's only took about 20 minutes.
>
> Fortunately, git is based on extremely simple principles.
> Unfortunately, git grew out of really bright people hacking stuff
> together in order to get sh!t dun; the result is not approachably or
> even well documented, the UI is sometimes a bit of a kludge, the API
> is probably nonexistent, and the terminology is so loosely thrown
> about that it's easy to forget which way is up in discussions.
> (Note, though, that Junio has done a laudable job of keeping the
> whole experiment going strong).

You are a prime example of this experiment called 'life', also based
on extremely simple principles, mostly through trial and error. Design
is overrated :)

--=20
=46elipe Contreras
