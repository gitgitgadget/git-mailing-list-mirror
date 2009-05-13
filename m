From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: The 9th production of the msysGit Herald
Date: Wed, 13 May 2009 12:33:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905131231080.5046@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0905130225330.27348@pacific.mpi-cbg.de> <4A0A797B.7080400@op5.se>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed May 13 12:33:17 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-1516.google.com ([209.85.146.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Bm0-0003qx-BL
	for gcvm-msysgit@m.gmane.org; Wed, 13 May 2009 12:33:16 +0200
Received: by wa-out-1516.google.com with SMTP id k39so321247waf.53
        for <gcvm-msysgit@m.gmane.org>; Wed, 13 May 2009 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=z4Xn12PlNoRzztEtXTE6NIO0fiZ9hoz1Q5t1Dpqv+n0=;
        b=nbFk//KZ/wF+HZ2vwCXuzNSNM22ovrCPYi18MNiCRpOMCsVtryDhlZwhJk5XxF2Snq
         2SNB/cuQbFJcyA/T3OdTVlq25FHimaPOEpepFOEwyNU/yy4M8KvKC6sJhjw6+a65wcCY
         7kOc87TIGu8veScjBCX2HmdBkHzg3/6UuTC0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=K53YSXfTgSLClh2/EV+YidB82/oxPJkBS6Bl8g3Kb09UljiPjLZ1X5KvVSoHFTjHs0
         xiWa+MKd3jyX4JkGCCBBmLVyOlxu/+Lm2BHsaRqg7MuyzFQNbp92SfUur2OLehH3OqCV
         HRaCJnRpDAQwV0Elz3GT8cg98wQEohNaE88X0=
Received: by 10.114.81.1 with SMTP id e1mr138252wab.24.1242210786324;
        Wed, 13 May 2009 03:33:06 -0700 (PDT)
Received: by 10.106.168.10 with SMTP id q10gr5222pre.0;
	Wed, 13 May 2009 03:33:06 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.113.200 with SMTP id b8mr8989faq.23.1242210785916; Wed, 13 May 2009 03:33:05 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 14si63617fxm.7.2009.05.13.03.33.05; Wed, 13 May 2009 03:33:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 13 May 2009 10:33:04 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5] by mail.gmx.net (mp055) with SMTP; 13 May 2009 12:33:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JZZ1xPxvJ2WHjOxQUqonLW/oB1GHU9PbDb3qGx/ 4tbpW4PxLuJ8e2
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A0A797B.7080400@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119028>


Hi,

On Wed, 13 May 2009, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > The "netinstall" and "fullinstall" packages should work again 
> > (fullinstall is stuck at 1.6.1 for the moment, basically because I am 
> > too lazy, and do not want to waste much of our Google Code quota for a 
> > new fullinstall package).
> 
> I should think we could host legacy install-packages at $dayjob if you 
> need the diskspace. Let me know if you're interested and I'll poke our 
> sysadmin and ask him to set something up.

Thanks for your offer!

Actually, I think I should just use the space Google offers us, we have a 
quota of 2GB (they granted more than we requested), of which we use less 
than 500MB.

And if the 2GB are full, we always can go back and ask for more ;-)

Ciao,
Dscho
