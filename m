From: Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org>
Subject: Re: Windows binaries for qgit 2.0
Date: Mon, 17 Dec 2007 10:51:52 +0100
Message-ID: <fk5grp$7il$2@ger.gmane.org>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>	 <fk2juf$t25$1@ger.gmane.org>	 <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>	 <fk2p0f$961$1@ger.gmane.org>	 <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>	 <fk2q1f$bbh$1@ger.gmane.org>	 <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com>	 <fk3153$rtb$1@ger.gmane.org> <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Dec 17 10:55:37 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.170])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ChD-0002OO-Ne
	for gcvm-msysgit@m.gmane.org; Mon, 17 Dec 2007 10:55:36 +0100
Received: by py-out-1314.google.com with SMTP id p69so593334pyb.5
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Dec 2007 01:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:user-agent:in-reply-to:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=7gvO4/QGrOY+njCPQ1gHA0beQhoIeHdz+qM0Yoasefo=;
        b=tcucPjPRy83DX4tqM6/ffBAvdxrMyFyi/gcOAV/ukb5aHv7BgjvsAJ75QtRSh1z2c0Iy/2V7jqpOJXM1xA0A9XVy4UxkizCWVzVFvXFQy61PeJ3FulVp9P57yFDHknLXk2S9Ca2bzzNa0N6gFEOcU97+cf26i6vg5LyBPtuSbm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:user-agent:in-reply-to:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=yD6vzZ0bgUT6DumL5mgGjo9NGS7tqp4AXXqJdXw/MciB2TXELc3yC4n/HaL+dDcdB8qG+Y0ggzYOQWrgVck37WLZA/NH4AnzPVJ4e/ega11zvhsJ45A0J21rueWA2qtu6DTcqyi8tTTxyxcuu5C3RUnTBdWBgB16rvwEr8Cu9fk=
Received: by 10.35.64.7 with SMTP id r7mr292573pyk.2.1197885309611;
        Mon, 17 Dec 2007 01:55:09 -0800 (PST)
Received: by 10.107.100.4 with SMTP id c4gr1248prm;
	Mon, 17 Dec 2007 01:55:09 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.37.18 with SMTP id p18mr11698530pyj.6.1197885309268; Mon, 17 Dec 2007 01:55:09 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id y6si18947057nzg.2007.12.17.01.55.08; Mon, 17 Dec 2007 01:55:09 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from root by ciao.gmane.org with local (Exim 4.43) id 1J4Cgh-0006Oi-2k for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Mon, 17 Dec 2007 09:55:03 +0000
Received: from matrix-eth-s4p3c0.eurocontrol.fr ([192.93.23.254]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Mon, 17 Dec 2007 09:55:03 +0000
Received: from younes.a by matrix-eth-s4p3c0.eurocontrol.fr with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Mon, 17 Dec 2007 09:55:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: matrix-eth-s4p3c0.eurocontrol.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550712161426y101c77efl4f5321d3440fed3f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68531>


Marco Costalba wrote:
> On Dec 16, 2007 12:11 PM, Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org> wrote:
>> Actually you might prefer to just use the LyX dependencies package that
>> we provide for Windows developers, it contains Qt. I paste here the
>> relevant part of our 'INSTALL.Win32':
>>
> 
> Thanks, I've tried it but without success because I need MSVC 2005
> installed, and currently is not.

Right.

> 
> Anyhow for now I have produced a version with mingw that seems more or
> less to work, when I have a bit of time I will install MSVC 2005 and
> try if with that compiler is better...

I would like to help you with that but I can't retrieve the repository:

$ git clone git://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
git.kernel.org[0: 130.239.17.7]: errno=Invalid argument
git.kernel.org[1: 199.6.1.166]: errno=Bad file descriptor
git.kernel.org[2: 204.152.191.8]: errno=Bad file descriptor
git.kernel.org[3: 204.152.191.40]: errno=Bad file descriptor
fatal: unable to connect a socket (Bad file descriptor)
fetch-pack from 'git://git.kernel.org/pub/scm/qgit/qgit4.git' failed.

$ git clone http://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

$ git --version
git version 1.5.3.6.1791.gfd264

'git clone ssh://...' seems to work but I guess I need a login and password?

Maybe I am doing something wrong here? Sorry, my first time ever with git...

Abdel.

PS: Sorry for the cross posting but I guess this issue is maybe of
interest to msysgit people.
