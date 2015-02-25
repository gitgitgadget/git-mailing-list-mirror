From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Wed, 25 Feb 2015 13:10:53 +0100
Organization: gmx
Message-ID: <f509e16aee45d64227879cdafdc106a3@www.dscho.org>
References: <20150218191417.GA7767@peff.net>
 <20150218193234.GA8298@peff.net>
 <5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
 <vpqioerz03s.fsf@anie.imag.fr>
 <CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>
 <c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org>
 <vpqh9uavp6q.fsf@anie.imag.fr>
 <CACsJy8CU5N+3rMh1Png=8YQNMb5s8JT9Py9FdLekae6Dkds3BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, Junio C Hamano
 <gitster@pobox.com>, Jeff King <peff@peff.net>, Git Mailing List
 <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBZHXW2TQKGQEUG65RKI@googlegroups.com Wed Feb 25 13:11:17 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBZHXW2TQKGQEUG65RKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f184.google.com ([209.85.214.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBZHXW2TQKGQEUG65RKI@googlegroups.com>)
	id 1YQao9-0004Ql-Ad
	for gcvm-msysgit@m.gmane.org; Wed, 25 Feb 2015 13:11:17 +0100
Received: by mail-ob0-f184.google.com with SMTP id va2sf871596obc.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Feb 2015 04:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=3ZMxKzbVFDPX3IydvrzPxb0o5Agu7DcdPPZlY6FTcts=;
        b=AQWsqDFqGytvBkQeJ1DS7gbtptACqVIqB7K2Mu6C+CCK8stIKo+Nd7VDxSjWNM9cFN
         Dh7hmXvYscPPvGxUsS+hDhf/pTY+4NRsvpWU2FrkuXnv13eX0rxJeJktOnkZA8qaYso1
         jfA0PzGcJiPKZWMJ39ky8CYtfr5AqsH1dlfMKzB2aeRNvnIUhIoziz9/jwT9goBh+OOq
         5WsjwWHSWnwEw14zAA15hG9ImbSqNS9xHRhs43CHUjizMAiROToJi8Yj2Vt8pBxK4JfD
         Zo3402yVm5BqkQFNZYxFUco21s+nEzrSsoiJN/0TCmXQbwCCLG7nOQ39BBCjB8QD1tDp
         BoXQ==
X-Received: by 10.140.101.148 with SMTP id u20mr33396qge.5.1424866276590;
        Wed, 25 Feb 2015 04:11:16 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.30.180 with SMTP id d49ls3468308qgd.97.gmail; Wed, 25 Feb
 2015 04:11:16 -0800 (PST)
X-Received: by 10.236.110.38 with SMTP id t26mr2549342yhg.1.1424866276203;
        Wed, 25 Feb 2015 04:11:16 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id kt5si7205850qcb.3.2015.02.25.04.11.15
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 04:11:16 -0800 (PST)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MWQSM-1Y2wzM2kig-00XgFZ; Wed, 25 Feb 2015 13:10:54
 +0100
In-Reply-To: <CACsJy8CU5N+3rMh1Png=8YQNMb5s8JT9Py9FdLekae6Dkds3BQ@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:zVDvI4gCUK/rDSK3xPi4wT5N7tkbdf+b8TYuA5hdzcvUiQ/Gag4
 IM7r1VFEVJm28qpLvH0TCTgn031l2pTC8PG5KTSauhcaj3FhDu8sAXHAoHPAGfgLR+oSPId
 7WtcglcU0pU+FtiSyktjd6kI3+P5u8Rp4xrpSR392IDqnbSsNil+0NT8WSf/4Qpdz0Oi5RA
 PXjPzSe4P7brgO1nB1vAQ==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264387>

Hi Duy,

On 2015-02-25 11:02, Duy Nguyen wrote:
> On Wed, Feb 25, 2015 at 6:56 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> To get an idea, I counted the lines of code written by the student I
>> mentored last year:
>>
>> $ git log --author tanayabh@gmail.com -p | diffstat -s
>>  43 files changed, 1225 insertions(+), 367 deletions(-)
>>
>> I would consider this GSoC as "average" (i.e. not exceptionnally good,
>> but certainly not a bad one either), so you may hope for more, but you
>> should not _expect_ much more IMHO.
>>
>> In comparison:
>>
>> $ wc -l git-add--interactive.perl
>> 1654 git-add--interactive.perl
>> $ wc -l git-stash.sh
>> 617 git-stash.sh
>>
>> I'd expect a rewrite in C to at least double the number of lines of
>> code, so rewriting git-stash would mean writting at least as many lines
>> of code as the GSoC above. git-add--interactive.perl would be rather far
>> above.
>>
>> But my point was not to convert _only_ git-pull.sh, but to have a GSoC
>> starting with this one and plan more. Then, depending on how it goes,
>> you can adjust the target.
> 
> Some data point as I have a half-baked builtin/pull.c in my
> (forgotten) private branch for 3 years. pull.c has 389 lines (with 24
> shell lines left in "#if 0"). git-pull.sh has 340 lines. Let's add 100
> C lines  to pull.c when it's complete, that's 50% more lines. But in
> the git-pull case the student could get a good head start by reusing
> my code, maybe.

Thanks for the pointer, I will keep that in mind!

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
