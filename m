From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Re: Windows Bluescreen
Date: Fri, 13 Feb 2015 22:09:50 +0100
Message-ID: <54DE681E.6080705@virtuell-zuhause.de>
References: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net>	<CAFOYHZADerTE88KudrH7LTi3yX4Sg1vJe3Xj0vJH+DNeO6NOEw@mail.gmail.com>	<CAEuupitA4PHBByLLcqc5pVbn1C+ZyQ6Vzbk-LsOjseOEHhkENw@mail.gmail.com>	<CAFOYHZAMv5BEmDXGSoo53iSwCYLdhOcM7dHwCMidZBaJh0xmUQ@mail.gmail.com>	<CAEuupiuv=gRnnZm1C75dx35nC=sXR1Hb_PzLXzAKHwaD7kYsXA@mail.gmail.com>	<1423744959.10453.3.camel@thomas-debian-x64> <CAEuupivCDfpJrT+T921CpMg-+tCnMBZ8x=1uNgKJbcJyX0vGWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>, 
 msysgit@googlegroups.com
To: Erik Friesen <erik@aercon.net>
X-From: msysgit+bncBCL7JHHTPAIKBUHZUYCRUBC3S7CBW@googlegroups.com Fri Feb 13 22:09:54 2015
Return-path: <msysgit+bncBCL7JHHTPAIKBUHZUYCRUBC3S7CBW@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIKBUHZUYCRUBC3S7CBW@googlegroups.com>)
	id 1YMNUn-0008Eo-KJ
	for gcvm-msysgit@m.gmane.org; Fri, 13 Feb 2015 22:09:53 +0100
Received: by mail-lb0-f192.google.com with SMTP id b6sf4554040lbj.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 13 Feb 2015 13:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=CUgSClcEFjg9g9Yq1luR/CosTIx2pK4DUXPn4LizZt4=;
        b=xMSbqJuKSoAE2l6lm+kSuouQ4QPB6xHBUPIxXWUzCDEWXJvXf27N4skon6NpRs6gLa
         wkQqt4SwDZWKY38F00XAJxtWazvXGwogHGnifwCPxkRKbZQ9RtACLHj+8ynR4BQZnOFp
         BaXL2Hpvp1FxITh40oO11JI0B6pSbVEoQr1vtHCQdqV+uj8TNV8u2oiI+Tqyqiup9q2i
         PR6npwG450hHzrQAt6fHFU8YgXEwarrQOVcbinjv8xgrYLIl8/9JbNX6uKFnLuwBjaDD
         Qpf77uKGLvDp2KK/TyxtaADSMnp2lzYouLAZrSUr62PAXYPz/e24X7LgJ0O89ZoHmlNd
         m/Pw==
X-Received: by 10.180.209.101 with SMTP id ml5mr98632wic.19.1423861793334;
        Fri, 13 Feb 2015 13:09:53 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.103.166 with SMTP id fx6ls417653wib.20.canary; Fri, 13 Feb
 2015 13:09:52 -0800 (PST)
X-Received: by 10.180.99.3 with SMTP id em3mr1558022wib.7.1423861792586;
        Fri, 13 Feb 2015 13:09:52 -0800 (PST)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [80.237.132.163])
        by gmr-mx.google.com with ESMTPS id i7si3261251wif.0.2015.02.13.13.09.52
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 13 Feb 2015 13:09:52 -0800 (PST)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=80.237.132.163;
Received: from p5ddc0ce0.dip0.t-ipconnect.de ([93.220.12.224] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1YMNUl-0007C7-IQ; Fri, 13 Feb 2015 22:09:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAEuupivCDfpJrT+T921CpMg-+tCnMBZ8x=1uNgKJbcJyX0vGWw@mail.gmail.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1423861792;c90a3e7d;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263834>

Am 12.02.2015 um 14:21 schrieb Erik Friesen:
> Sorry, I don't know what this TOP posting problem is, and hitting
> reply only replies to the last sender.   If you prefer, and you have
> some regular bugtracker, I could use that instead of email posting.
> 
> To repro-
> Set up git user on local linux repo, in my case 192.168.0.100
> 
> On a windows 7 64bit machine-
> $ cd myproject
> $ git init
> $ git add .
> $ git commit -m 'initial commit'
> $ git remote add origin git@192.168.0.100:/opt/git/project.git
> $ git push origin master
> (Shamelessly copied from git page)
> 
> Problem happens after entering password, it may or may not get started.
> 
> The nature of a bluescreen doesn't make debugging and reproduction
> real easy.  If it helps, I can get the dumps from those crashes.  To
> move on, I moved back to local http pushes.

I'm doing pushes over ssh on a daily basis against my linux server.
And I'm using a Win7 64bit machine as well.

Can you try if it makes any difference if you use ssh login with public
keys instead of passwords?

You can also try to add "LogLevel Debug" to ~/.ssh/config in order to
get more verbose ssh output.


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
