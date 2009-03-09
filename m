From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git for Windows 1.6.2-preview20090308
Date: Mon, 9 Mar 2009 11:37:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903091137330.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <20090309103414.GA5247@wingding.demon.nl>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: git@tux.tmfweb.nl
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 09 11:37:54 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgcrm-0005qB-6V
	for gcvm-msysgit@m.gmane.org; Mon, 09 Mar 2009 11:37:50 +0100
Received: by yw-out-2122.google.com with SMTP id 1so971965ywp.63
        for <gcvm-msysgit@m.gmane.org>; Mon, 09 Mar 2009 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=NFyyKGhLoy57zeqP2gdVoET0U7hflN+TWQkRGEURGIg=;
        b=C6JTETtUEJIb5Rb3upDSr6Csroa7SMkLo9dIwNeIylr1VS9aeAqwQMHlJqyrZoe7ba
         0KBWj0O6UsLbGFcp1HOUZoP1o39DLpcBB6qHk/d2ps8Rj1RpPi2fSLcBPZnWD79Fhnwr
         kd2+0pAgBR6WWdZZxNY/LzUytb3jPPIb2It1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=ZyIIhKexND+hXrgq6e9UQR8DGJtncZDFKtjysvMJt6J9F1imvZPOlEr+m47Y7/88RT
         qKZtRsnkjjRsOznETx67hhUHmVuTykEAeoaBLAZfkFqiKQdfkejv95mhV7RIkh2jvPK0
         UQbQpaAeWI80Zx/fpqP3RDtnt+cx+GRA1Af8M=
Received: by 10.100.131.16 with SMTP id e16mr933441and.10.1236594977424;
        Mon, 09 Mar 2009 03:36:17 -0700 (PDT)
Received: by 10.177.6.2 with SMTP id j2gr3904yqi.0;
	Mon, 09 Mar 2009 03:36:17 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.180.248.9 with SMTP id v9mr144379bkh.17.1236594976834; Mon, 09 Mar 2009 03:36:16 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 13si446060bwz.7.2009.03.09.03.36.16; Mon, 09 Mar 2009 03:36:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 09 Mar 2009 10:36:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp042) with SMTP; 09 Mar 2009 11:36:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mgSkkfyOmYeOtAWbh6B8crVh9F11TPprOQmeLzQ 4IJEPFLm/5oCA8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090309103414.GA5247@wingding.demon.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112686>


Hi,

On Mon, 9 Mar 2009, Rutger Nijlunsing wrote:

> On Sun, Mar 08, 2009 at 02:10:21AM +0100, Johannes Schindelin wrote:
> > 
> > Hi,
> > 
> > I just released a new version of Git for Windows (TAFKA WinGit).  It is 
> > basically Git 1.6.2 plus a few patches.  Please find the installer here:
> > 
> > 	http://msysgit.googlecode.com/
> > 
> [snip]
> > Changes since Git-1.6.1-preview20081225
> > 
> > Bugfixes
> > - Comes with updated msys-1.0.dll (should fix some Vista issues).
> 
> Thanks! This also fixes the 'git hangs 5s without any reason on some
> Windows XP machines'!

Good to know!

Thanks,
Dscho
