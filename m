From: Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org>
Subject: Re: Windows binaries for qgit 2.0
Date: Mon, 17 Dec 2007 22:40:30 +0100
Message-ID: <4766ECCE.8010404@free.fr>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>	 <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>	 <fk2p0f$961$1@ger.gmane.org>	 <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>	 <fk2q1f$bbh$1@ger.gmane.org>	 <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com>	 <fk3153$rtb$1@ger.gmane.org>	 <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com>	 <fk5grp$7il$2@ger.gmane.org>	 <Pine.LNX.4.64.0712171042520.9446@racer.site> <e5bfff550712171114i40a59b11md87038a3fc13d29c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>,  msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marco Costalba <mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Dec 17 22:40:59 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Nhq-0006RQ-R9
	for gcvm-msysgit@m.gmane.org; Mon, 17 Dec 2007 22:40:59 +0100
Received: by ag-out-0910.google.com with SMTP id 37so954967agc.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Dec 2007 13:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=dooJan5PvfF1dIBkeeh0dIMEte+fW2laxBhl+72cPVo=;
        b=kayj7UtXsW0Fs0DhVDLO79kI0/Lb+EmcKAdjNGdcHekvLHFmkYD8dzc1tvoa6AnT7IM8tLKytbz91k23GNOL9mV6d4gXJxJkG4yuPWLUvMI5tDSN39IAZWsdQx4YU1/K5IFq5CgI1WuNmrdFtbUQhLk+pdbP/gEJjUzp/0suPjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=U1wIbXOC9vKC8mfcZbCCKiVohhJw6zR52k4olnwwBf1B9hG0WL54Q04cRRiDF+eku22pQNbhHTys55LQ43nD4Sn3GI3Ar2zOQYIfL4/A55fb1L4XNOu3SXidkESZgdnowPah3tog9WQtzBHih8QCTkc+nyWFaVSA3QMKg7mbcfI=
Received: by 10.100.154.9 with SMTP id b9mr197132ane.7.1197927635735;
        Mon, 17 Dec 2007 13:40:35 -0800 (PST)
Received: by 10.107.100.4 with SMTP id c4gr1263prm;
	Mon, 17 Dec 2007 13:40:35 -0800 (PST)
X-Sender: younes.a-GANU6spQydw@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.157.1 with SMTP id f1mr1782388wae.16.1197927634422; Mon, 17 Dec 2007 13:40:34 -0800 (PST)
Received: from smtp1-g19.free.fr (smtp1-g19.free.fr [212.27.42.27]) by mx.google.com with ESMTP id h71si3827nzf.3.2007.12.17.13.40.33; Mon, 17 Dec 2007 13:40:34 -0800 (PST)
Received-SPF: pass (google.com: domain of younes.a-GANU6spQydw@public.gmane.org designates 212.27.42.27 as permitted sender) client-ip=212.27.42.27;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of younes.a-GANU6spQydw@public.gmane.org designates 212.27.42.27 as permitted sender) smtp.mail=younes.a-GANU6spQydw@public.gmane.org
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1]) by smtp1-g19.free.fr (Postfix) with ESMTP id 0094D1AB302; Mon, 17 Dec 2007 22:40:32 +0100 (CET)
Received: from [192.168.0.1] (gre92-5-82-237-199-162.fbx.proxad.net [82.237.199.162]) by smtp1-g19.free.fr (Postfix) with ESMTP id A49061AB2BC; Mon, 17 Dec 2007 22:40:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550712171114i40a59b11md87038a3fc13d29c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68630>


Marco Costalba wrote:
> On Dec 17, 2007 11:44 AM, Johannes Schindelin
> <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> wrote:
>   
>> Why would anything that has to do with MSVC2005 be interesting to msysGit?
>> Note the "msys" part of "msysGit".
>>
>> FWIW a member of our team works on compiling/including qgit into msysGit.
>> But definitely not using closed-source compilers.  I would violently
>> oppose that.
>>
>>     
>
> I would (violently) agree with you, but I also violently oppose to
> waste a week end fighting with Qt4 + mingw compilation. MSVC2005 is
> needed as a kind of "debug tool" to better understand if the problem
> is with Qt4 or with mingw (as I suspect).
>
> Abdel is very kind to try to help in caming out with a qgit.exe more
> or less ready to be packaged. I'm not opposed, in this phase, to
> follow different _technically_ sound paths. Then when the dust settles
> down we could do our consideration regarding open source, in which I
> belive very firmly, so firmly that I'm not scared to _test_ different
> ways if this can be useful to shed some light on this issue.
>   
If you allow me to share my experience in the LyX project WRT mingw/msys 
versus MSVC: We tried very hard to use it, but at the end we faced many 
issues, so many issues that MSVC was the only pragmatic choice:
- autotools hell with msys: the automake version was simply too old and 
we had to mix cygwin and msys environment to get something done.
- linker hell: more than 500 megs of RAM was needed to link LyX with 
Qt3, the situation was better with Qt4 but still.
- compilation slowness. Mingw is just not good with C++.
- binary slowness: this is less of a problem with Qt4 but still, the 
MSVC compiled LyX is much faster.

In conclusion, I guess C-compilation is fine with Mingw and you should 
definitly stay with it for git, but for a heavy GUI oriented C++ program 
I strongly recommend MSVC.

Abdel.
