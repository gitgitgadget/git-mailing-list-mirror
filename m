From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows 1.6.2-preview20090308
Date: Sun, 8 Mar 2009 12:54:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903081253510.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <200903081413.28354.angavrilov@gmail.com>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org,  Junio C Hamano <gitster@pobox.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 08 12:54:58 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wf-out-1516.google.com ([209.85.200.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgHar-0001nc-Gc
	for gcvm-msysgit@m.gmane.org; Sun, 08 Mar 2009 12:54:57 +0100
Received: by wf-out-1516.google.com with SMTP id r34so344350wfc.33
        for <gcvm-msysgit@m.gmane.org>; Sun, 08 Mar 2009 04:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=aY9AVGVg5LgedjEm/eoUOUqtwvkcO40zaa1vsjSyAOs=;
        b=YQYPriebVAnqIU62DUDdc2v+AisXEIJPQhhRI9gHmV6XpmZ7MG5OLS2UWmrif78TvX
         2S0mXeNQzLzVyRD0Dv80LQ47XKC1go/VpJXN18U4q3BxmEOFgahW4qiLCLTww7diA+eO
         eMEsXOjzHXr4z1eeXu7t5vQJlDd4W3PpoLNgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=aJu9hULaaD3SG1ibuMAKlWykIcfD1p3LEavDrfQaii8qDfuZkUoUVbCKU+GkC4+xZX
         hjaK21M6lx6BCk9mZ/8bOgX/P/X8+X6dvs8597CrO/eq0EDPF3tXshabsZIR2vTKhmcy
         t/xNUKySBnkOudmqmfADd9pGpJssYOyzehg34=
Received: by 10.142.230.9 with SMTP id c9mr333959wfh.17.1236513203770;
        Sun, 08 Mar 2009 04:53:23 -0700 (PDT)
Received: by 10.177.6.2 with SMTP id j2gr3855yqi.0;
	Sun, 08 Mar 2009 04:53:23 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.180.248.9 with SMTP id v9mr116632bkh.17.1236513203148; Sun, 08 Mar 2009 04:53:23 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 15si250087bwz.6.2009.03.08.04.53.23; Sun, 08 Mar 2009 04:53:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 08 Mar 2009 11:53:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp005) with SMTP; 08 Mar 2009 12:53:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195ZTg1uYJ5fSYnAHUCPgOzvNGgzV9+9sMTo1M2Nk FZXarXCoAMLswz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200903081413.28354.angavrilov@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112617>


Hi,

On Sun, 8 Mar 2009, Alexander Gavrilov wrote:

> On Sunday 08 March 2009 04:10:21 Johannes Schindelin wrote:
> > I just released a new version of Git for Windows (TAFKA WinGit).  It is 
> > basically Git 1.6.2 plus a few patches.  Please find the installer here:
> > 
> > 	http://msysgit.googlecode.com/
> > 
> > Disclaimer: Git for Windows is still in a state where I do _not_ recommend 
> > using it unless you have the means to fix issues.  Unlike git.git 
> > developer community, the msysGit team is heavily undermanned.
> > 
> > Known issues
> 
> I've just noticed that the following git-gui fixes haven't been merged in 1.6.2:
> 
>   git-gui: Support more git version notations.
>   git-gui: Avoid an infinite rescan loop in handle_empty_diff.
>   git-gui: Fix post-commit status with subject in non-locale encoding
> 
> The second one is a fix for a rather important problem reported on the msysgit list.
> The last one is msysgit bug #181.

Thanks for keeping an eye on things.  Would you agree that we can wait a 
few days, maybe this whole week, to collect issues like these, and then 
release another installer with the issues fixed?

Ciao,
Dscho
