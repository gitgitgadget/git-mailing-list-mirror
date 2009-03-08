From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows 1.6.2-preview20090308
Date: Sun, 8 Mar 2009 19:43:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903081940490.6384@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <m363iki1ua.fsf@localhost.localdomain>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 08 19:45:17 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgNzx-0003w4-7C
	for gcvm-msysgit@m.gmane.org; Sun, 08 Mar 2009 19:45:17 +0100
Received: by yx-out-2122.google.com with SMTP id 22so810000yxm.63
        for <gcvm-msysgit@m.gmane.org>; Sun, 08 Mar 2009 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=buOhkNUVddk7MYlW03hR6to/rYM8GsCqEJY0Dydwgbc=;
        b=m0mkCqFLr5cpjfN4Ei6syoygh/2FIOsVVDZmHxdMZPno6Z36ngcVIcKfJ9XqH+uLJU
         uZUi00f4FFAmvbYHm4JVQ1eYlsTWmrL4JMgQxk2GxhlbkXifISY48q+NrAKgg1uVjthn
         kg8duKPFFLI7BuaU04M6Q2X1UWbTIRnsIo+Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=xpt3Svw9Eq5sCDBh3N8Uf73GbfLu8m18Pwa1yM+UE486RAmB21UssyMBTOGmbgZk3P
         nUXf+vV+niZSIGH2z49I3Qw2Jsrel/sgDShTrBSYz/URvOWqJIlSIwvuTj24KKiFoCqy
         WAttA6fBYO7tYrWVEnzkP7OpNzWbT2mK1Ghno=
Received: by 10.90.72.3 with SMTP id u3mr881655aga.21.1236537824243;
        Sun, 08 Mar 2009 11:43:44 -0700 (PDT)
Received: by 10.177.6.2 with SMTP id j2gr3878yqi.0;
	Sun, 08 Mar 2009 11:43:44 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.113.201 with SMTP id b9mr58357faq.24.1236537823533; Sun, 08 Mar 2009 11:43:43 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id e3si148310fga.2.2009.03.08.11.43.43; Sun, 08 Mar 2009 11:43:43 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 08 Mar 2009 18:43:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp066) with SMTP; 08 Mar 2009 19:43:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gLOAXtptgOFc0Rx5f4Ilqx2Ba9+eKfko0AnjyEX yUZi4RNPMufV9k
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <m363iki1ua.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112630>


Hi,

On Sun, 8 Mar 2009, Jakub Narebski wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Known issues
> 
> > - The Logitec QuickCam software can cause spurious crashes. See "Why does 
> >   make often crash creating a sh.exe.stackdump file when I try to compile 
> >   my source code?" in the MinGW FAQs 
> >   (http://www.mingw.org/MinGWiki/index.php/FAQ).
> 
> You meant issue described here?
>   http://www.mingw.org/wiki/Environment_issues

Exactly.

Fixed, committed and pushed.

Thanks,
Dscho
