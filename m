From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Wed, 25 Feb 2015 09:44:04 +0100
Organization: gmx
Message-ID: <3e3da365d9b6021c9b6d8547ad8df788@www.dscho.org>
References: <20150218191417.GA7767@peff.net>
 <20150218193234.GA8298@peff.net>
 <5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
 <vpqioerz03s.fsf@anie.imag.fr>
 <CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>
 <c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org>
 <vpqh9uavp6q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Git
 Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: msysgit+bncBCZPH74Q5YNRBYUWW2TQKGQEJIMQFEA@googlegroups.com Wed Feb 25 09:44:20 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBYUWW2TQKGQEJIMQFEA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f188.google.com ([209.85.212.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBYUWW2TQKGQEJIMQFEA@googlegroups.com>)
	id 1YQXZr-0004LS-4U
	for gcvm-msysgit@m.gmane.org; Wed, 25 Feb 2015 09:44:19 +0100
Received: by mail-wi0-f188.google.com with SMTP id hm9sf936657wib.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Feb 2015 00:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=2zSBbm9Yi3duOVXMW2D8LENfop/1lEnKYw0eSsr7HGg=;
        b=ud5Can7jZ1GNTzJVxTyVGUsjQDna8j6r7v3T6w9hQhET+krQICHUZs3dyIvlj5zPSA
         MFd9FJrbPsc3sBPbn/l6lyhpCeo74ZCiISgqq54R0/1RkKFsR33plkjkp8yBtk3GMJ+b
         MuhHATfpn0ITlFIIFyo06y6oZqtyfgvepOdz8d3MruCzEFBXbFh1EZfOq93r8RfphD7a
         ApNjnbBCXklXlk6RrpEdDSn7aICVwCn6avivyCkZb+TXJsJxLGZRSbsTSqeFeXcU7LtO
         ZrcFnxnkXZaVvauRnN/tPpZjn76+ABTT9f/29hgsthjMHB1bHfpRdJJRxQflCmnuwCfR
         n21Q==
X-Received: by 10.152.170.202 with SMTP id ao10mr24346lac.23.1424853858792;
        Wed, 25 Feb 2015 00:44:18 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.203.133 with SMTP id kq5ls846776lac.32.gmail; Wed, 25 Feb
 2015 00:44:17 -0800 (PST)
X-Received: by 10.112.9.65 with SMTP id x1mr287284lba.16.1424853857603;
        Wed, 25 Feb 2015 00:44:17 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id by11si1311970wib.1.2015.02.25.00.44.17
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 00:44:17 -0800 (PST)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MbPPQ-1Y7ul71MGK-00Im0E; Wed, 25 Feb 2015 09:44:05
 +0100
In-Reply-To: <vpqh9uavp6q.fsf@anie.imag.fr>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:HKJktxBOSdVnGDTE1klLNivJ1WqH0hAipy0r6nHJMItnUtWxQ9C
 fAYrmd/w+OHlj61Sk31FAuACv3fnjC4efK6cp4Nj0gL1nebQwOUIt7JjRmym740cMLMIObg
 pYKmifguO9pl3XBbwOfW43IFrvORMgwnboobWrHlBpRqGzzEL38RpY+zcM1Z1x96K1n2sMr
 MCvh4GVh0lfxgtrqGtuQw==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264370>

Hi Matthieu,

On 2015-02-25 00:56, Matthieu Moy wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> On 2015-02-24 19:25, Junio C Hamano wrote:
>>> On Tue, Feb 24, 2015 at 9:32 AM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>> About the proposal:
>>>>
>>>>   The idea of this project is to dive into the Git source code and
>>>>   convert, say, git-add--interactive.perl and/or git stash into proper C
>>>>   code, making it a so-called "built-in".
>>>>
>>>> My advice would be to try converting several small scripts, and avoid
>>>> targetting a big one....
>>>> add--interactive and stash are relatively complex beasts, perhaps
>>>> git-pull.sh would be easier to start with.
>>>
>>> Yeah, I think that is a very good suggestion.
>>
>> Well, git-pull.sh is really small. I did not want to give the impression that the Git project is giving out freebies. But I have no objection to change it if you open that PR.
> 
> To get an idea, I counted the lines of code written by the student I
> mentored last year:
> 
> $ git log --author tanayabh@gmail.com -p | diffstat -s   
>  43 files changed, 1225 insertions(+), 367 deletions(-)
> 
> I would consider this GSoC as "average" (i.e. not exceptionnally good,
> but certainly not a bad one either), so you may hope for more, but you
> should not _expect_ much more IMHO.
> 
> In comparison:
> 
> $ wc -l git-add--interactive.perl
> 1654 git-add--interactive.perl
> $ wc -l git-stash.sh
> 617 git-stash.sh
> 
> I'd expect a rewrite in C to at least double the number of lines of
> code, so rewriting git-stash would mean writting at least as many lines
> of code as the GSoC above. git-add--interactive.perl would be rather far
> above.

Sure. You're right, I was thinking too big.

> But my point was not to convert _only_ git-pull.sh, but to have a GSoC
> starting with this one and plan more. Then, depending on how it goes,
> you can adjust the target.

That's excellent advice.

> This all depends on what you intend to do if the student does not finish
> the job. If you're going to do the rewrite yourself anyway, then having
> the student do even half of it is good already. If you're not going to
> finish the job by yourself, then a 95%-done-rewrite means a piece of
> code posted on the mailing list and never merged (and a lot of time
> wasted).

Well, all of this is academic at this point. Let's see whether we get accepted, and then, if a student finds this project compelling enough.

If both things happen, I will definitely heed your advice and encourage the student to start with some script that is easily converted, to "get her feet wet".

Ciao,
Dscho

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
