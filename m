From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: The 8th airing of the msysGit herald
Date: Thu, 6 Mar 2008 03:29:47 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803060327050.15786@racer.site>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site>  <200803030210.02223.jnareb@gmail.com> <47CBE85B.6060702@imap.cc>  <7vablfiv42.fsf@gitster.siamese.dyndns.org> <47CC432B.8060502@imap.cc>  <7v1w6rh1ru.fsf@gitster.siamese.dyndns.org>  <46a038f90803031458t2b404212t10f6e9ae710dc408@mail.gmail.com>  <47CF2F61.5060208@imap.cc>  <alpine.LSU.1.00.0803060121360.15786@racer.site>  <7vskz4heeg.fsf@gitster.siamese.dyndns.org> <5fc54b450803051803t4dda4341ue3ac403c742f1903@mail.gmail.com>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Tilman Schmidt <tilman@imap.cc>,  Martin Langhoff <martin.langhoff@gmail.com>,  Jakub Narebski <jnareb@gmail.com>, msysgit@googlegroups.com,  git@vger.kernel.org
To: Jim Raden <james.raden@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Mar 06 03:30:33 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.175])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX5sI-00022c-2N
	for gcvm-msysgit@m.gmane.org; Thu, 06 Mar 2008 03:30:26 +0100
Received: by py-out-1314.google.com with SMTP id p69so6397374pyb.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Mar 2008 18:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=8VFXB73eORGFMGoNbN2CVwfA41o5jaObyGsX6p92gCk=;
        b=HhcKwvJyVT9iYcSi9oSYM2uekuaCVUjZ6gKMklTPtXnu8N1rsd5Mh4JfGsjrjZsSTvsQo8+KBKv/3zXfrp621/jcMgkB/g4uvQrmNP7Jm1Jdmcr5FksiCrbPwm2kfkKYR7/46Rfv+kn5hGv6yp+uhZfNa8khCy5IxAL0La0x1Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=bcgGgMKnazgpH6MIFLVbDDPxAVHnhFhgdPiHMZTkfR6ZuR4F93qLFvhAq8KTcgzZJos5Un8RwMfG0j1T25z24d3y6hajnZo8s0jXSGxV13LQp0FtpWI9tKbKXVO9+elsamt/kQu5IikmJ+SANPPYdxIaHJjnEqxwR8GUUD7w5aQ=
Received: by 10.140.82.38 with SMTP id f38mr130228rvb.5.1204770587971;
        Wed, 05 Mar 2008 18:29:47 -0800 (PST)
Received: by 10.106.227.37 with SMTP id z37gr1920prg.0;
	Wed, 05 Mar 2008 18:29:47 -0800 (PST)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.60.19 with SMTP id i19mr1670912waa.10.1204770586866; Wed, 05 Mar 2008 18:29:46 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id k36si4989212waf.1.2008.03.05.18.29.46; Wed, 05 Mar 2008 18:29:46 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 06 Mar 2008 02:29:45 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40] by mail.gmx.net (mp022) with SMTP; 06 Mar 2008 03:29:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Id3hijBjItyw1AgbcnTqzkf5gMEg7xKoizuCMJq AFjkGVTBHDoEHG
X-X-Sender: gene099@racer.site
In-Reply-To: <5fc54b450803051803t4dda4341ue3ac403c742f1903@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76311>


Hi,

On Wed, 5 Mar 2008, Jim Raden wrote:

> Perhaps adopting a convention for the subject line, like "Usage 
> question: xxxxxxxxxxxxxxxxxxxxx"? We're still a small list, so it 
> wouldn't be horribly cumbersome.

I fail to see how that would accomplish something different from two 
mailing list, except the very likely chance that people are unaware of 
that convention.

> If the list grew beyond 150 or so 
> <http://en.wikipedia.org/wiki/Dunbar%27s_number> active users, or if the 
> signal:noise ratio grew too low, perhaps then that would be a good time 
> to readdress the issue.

Recently Shawn mentioned that there are 853 members.

> I confess that I haven't had to deal with such things before, so I'm not 
> familiar with the practices that may work in other groups faced with a 
> similar issue.

<tongue-in-cheek>It is pretty easy to tell that somebody top-posting is 
not a regular on this list</tongue-in-cheek>

Don't get me wrong, I'd _love_ to see a proper solution to the problem, 
alas, I do not see one yet.

Ciao,
Dscho
