From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Newbie grief
Date: Fri, 4 May 2012 19:41:09 +0000
Message-ID: <CAMOZ1BvmBP2pfc_TxsyLBRtWGo5=vfiPu9N_cxLkj2x8oWEJ1w@mail.gmail.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>
 <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
 <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
 <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
 <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
 <7v62cf8v2d.fsf@alter.siamese.dyndns.org> <4FA054BA.80601@palm.com>
 <86ipgfmw05.fsf@red.stonehenge.com> <4FA05C66.2060608@palm.com>
 <CAMOZ1BuiznhrzEOHe0N+uu=mLEw5wWTQyDpnwG8PuF1f_aNaXw@mail.gmail.com> <CAMP44s2yv6rfAfFUmGRS5b8=KwFpZ5yLxgL01V9W514PaLUJ9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rich Pixley <rich.pixley@palm.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:41:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQONt-00019e-Dq
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab2EDTll convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 May 2012 15:41:41 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50791 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab2EDTlk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 15:41:40 -0400
Received: by qcro28 with SMTP id o28so870833qcr.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 12:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZDqlB/DWVRv13u/8ylU8tKbP/N+SszzVxv/wfv8+Rqg=;
        b=Ti/XMBdblhdFehsmsFAB9Nnl5tqkfOCQHN3SXgK19+E/sVQmstarfEXjnjQGbOtZ5H
         2krZV35e8mlJmq2FaHQFoM3cPTZCSCG4y8c+otA8jPummcxTTvmmiabNLDpLPjEZY8Is
         NTxAH3uPXw7DcUdyQ9jUm3qlYpVShgFEWjq/gpsP7aJQmJihryq+mmtpAaf/gSdaVEKK
         wr7FDhBKwt9Xuf1gdqTK/8LJUNK1rYD3OKl7H7/kmrosLwvA/PJKd0VKNzYtuTsPqItJ
         pMGm6cXV8w/aEKlk7Nh7otH4ux2XYYNDjfqJlYkIH1qjNsJE+MwhtPJdYYgS1OABs6hS
         dEOQ==
Received: by 10.224.102.7 with SMTP id e7mr11979569qao.15.1336160499910; Fri,
 04 May 2012 12:41:39 -0700 (PDT)
Received: by 10.229.122.13 with HTTP; Fri, 4 May 2012 12:41:09 -0700 (PDT)
In-Reply-To: <CAMP44s2yv6rfAfFUmGRS5b8=KwFpZ5yLxgL01V9W514PaLUJ9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197060>

On Fri, May 4, 2012 at 7:30 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, May 2, 2012 at 12:56 AM, Michael Witten <mfwitten@gmail.com> =
wrote:
>> On Tue, May 1, 2012 at 9:57 PM, Rich Pixley <rich.pixley@palm.com> w=
rote:
>>
>>> In contrast, I was up and using mercurial in about a day and a half=
,
>>> including all of the stuff we've discussed, and all of the things I=
've even
>>> read about in git. =C2=A0Learning mq's only took about 20 minutes.
>>
>> Fortunately, git is based on extremely simple principles.
>> Unfortunately, git grew out of really bright people hacking stuff
>> together in order to get sh!t dun; the result is not approachably or
>> even well documented, the UI is sometimes a bit of a kludge, the API
>> is probably nonexistent, and the terminology is so loosely thrown
>> about that it's easy to forget which way is up in discussions.
>> (Note, though, that Junio has done a laudable job of keeping the
>> whole experiment going strong).
>
> You are a prime example of this experiment called 'life', also based
> on extremely simple principles, mostly through trial and error. Desig=
n
> is overrated :)

There is no process other than trial and error, or more precisely,
variation and selection.

Note, though, that the levels of sophistication involved with variation
and selection differ among manifestations of this process.
