From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Sat, 19 Apr 2014 20:58:32 +0400
Message-ID: <20140419165832.GA23227@seldon>
References: <20140403131850.GA24449@seldon>
 <20140419063133.GA3617@book-mint>
 <alpine.DEB.1.00.1404191719280.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCE7TAPITACRBO6WZKNAKGQETCTA76Q@googlegroups.com Sat Apr 19 18:58:36 2014
Return-path: <msysgit+bncBCE7TAPITACRBO6WZKNAKGQETCTA76Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f183.google.com ([74.125.82.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBO6WZKNAKGQETCTA76Q@googlegroups.com>)
	id 1WbYb6-0003Bl-Gi
	for gcvm-msysgit@m.gmane.org; Sat, 19 Apr 2014 18:58:36 +0200
Received: by mail-we0-f183.google.com with SMTP id w61sf234283wes.10
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Apr 2014 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=Cw4ARRAhTr8nY+Kfax03G+DC/p5OOAu4AUzneczqxp0=;
        b=IIr/Ts8AH2lkIQXHLU5EWfbPRaJ5bOr/sPImvaQEmNmCQuw33wPd2DO3ae3hOfplpm
         ENc0yWalsQtHVEosebEZwzZKV8vM3dDhB9kuqLeCCnR3C4z9yOjRYgv9KuPtKEyF4fLb
         Eyqe6BWq2+6Iqr5uURy/IkXHTNVKvFXmG9zhmRyh6pKLzlDqYNllQvvI/1/HtZJMTNWG
         xXxFog8HLAzM9xxXtQtSyGoPnVbaDdy+kAiwUAYDvZvH164YnS4SclNCvLuW+/VrkbrP
         bWvBRwVPN21VGBP4ldF1hGQzA3m5QjTuddASkcsS+UkakUd04gKKQH853SCZhkh/I4BP
         VVMw==
X-Received: by 10.152.8.201 with SMTP id t9mr5710laa.12.1397926716124;
        Sat, 19 Apr 2014 09:58:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.10.67 with SMTP id g3ls334841lab.104.gmail; Sat, 19 Apr
 2014 09:58:35 -0700 (PDT)
X-Received: by 10.113.10.34 with SMTP id dx2mr2001708lbd.4.1397926715288;
        Sat, 19 Apr 2014 09:58:35 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id bz11si89922wib.3.2014.04.19.09.58.34
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Apr 2014 09:58:34 -0700 (PDT)
Received-SPF: neutral (google.com: 94.242.204.247 is neither permitted nor denied by best guess record for domain of marat@slonopotamus.org) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WbYb2-00063u-M2; Sat, 19 Apr 2014 20:58:32 +0400
In-Reply-To: <alpine.DEB.1.00.1404191719280.14982@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 94.242.204.247 is neither permitted nor denied by best guess
 record for domain of marat@slonopotamus.org) smtp.mail=marat@slonopotamus.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246518>

On Sat, Apr 19, 2014 at 05:24:33PM +0200, Johannes Schindelin wrote:
> Marat, please do not add to the confusion. "msysGit" is the name of the
> *development environment* for developing Git for Windows.

This confusion comes from the fact that major part of msysGit is packaged
with Git for Windows to be used at runtime.

If you insist on msysGit-is-a-development-environment, you have to admit
that msysGit is technically a fork of msys.

My approach undoes this fork step and uses upstream runtime environment
as-is, be it msys, msys2, Cygwin or even SUA [1]. I could even make it a
noop and say "dear user, I don't care how, but please put sh/awk/find/etc
on PATH to make Git work, like things normally happen in *nix world".

Actually, even if Git was pure C, things like `git filter-branch` would
be almost useless without coreutils & friends.

> After all, there is no reason for yet another fork.

If there wasn't, mingwGitDevEnv would not be started.

I'd say I am doing a 'rebase' instead of 'fork' by using codebase of
Git for Windows (upstream Git sources with Windows-specific patches)
but replacing msysGit-provided runtime environment with another one.

[1]: http://en.wikipedia.org/wiki/Windows_Services_for_UNIX

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
