From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Failed to clone http://repo.or.cz/w/msysgit.git
Date: Mon, 17 Dec 2007 17:06:13 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171702360.9446@racer.site>
References: <fk5sde$crq$1@ger.gmane.org> <Pine.LNX.4.64.0712171330540.9446@racer.site> <fk5u4d$j9b$1@ger.gmane.org>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Dec 17 18:09:55 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.243])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4JQY-00062R-Re
	for gcvm-msysgit@m.gmane.org; Mon, 17 Dec 2007 18:06:51 +0100
Received: by wa-out-0708.google.com with SMTP id n36so2099234wag.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 17 Dec 2007 09:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=oi9xzXp/TdQyzVwFKBnVJvs86TZnVpDYZ4BA4fId4Z4=;
        b=Ow3YbImk1EoSQ+PcKxPzJBfGCBkwtxYOHM4+IbsVbL9COURs/U5YrvfJNTJnn2dI/31D7QkvNreHaWKFPWWQDz/yERV8fxQz8XahRTNx7Gj+xDrbpI6/Oe8lYwXZDcz2oRhZgRPVWN0snnCIOMaFV8P8UCoZaGdi9VbvRQ/YzuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=ZX1UY779STmc3+dR9VobkocZPUccSR6kh/ZfGmbKS5k4LHSFnrzMnlaJiUsJ8uSfHwKYL+xLr8pXEpms/CeTwtzstpZlCY5LBtsBNUD0cnfKaZLe4cGg4gdktwMr2tgmaxYi6omLSoT6WWfuetGi8b0q3Uzkm7cOQkS/6n5I4Y8=
Received: by 10.114.204.7 with SMTP id b7mr192042wag.16.1197911187457;
        Mon, 17 Dec 2007 09:06:27 -0800 (PST)
Received: by 10.107.100.4 with SMTP id c4gr1255prm;
	Mon, 17 Dec 2007 09:06:27 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.140.82.35 with SMTP id f35mr1869309rvb.17.1197911186618; Mon, 17 Dec 2007 09:06:26 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 20si19371234nzu.2007.12.17.09.06.26; Mon, 17 Dec 2007 09:06:26 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 17 Dec 2007 17:06:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net (mp004) with SMTP; 17 Dec 2007 18:06:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jKBoHZKYjTKiPoJxJo9Ba+JBumjOuEqRHPoFn8A 5qWqtMKjqUSl4p
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <fk5u4d$j9b$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68581>


Hi,

[please do not cull me from the Cc: list when you reply to me.  This is 
 like replying to me, but talking away from me (to the public).]

On Mon, 17 Dec 2007, Abdelrazak Younes wrote:

> Johannes Schindelin wrote:
> > 
> > On Mon, 17 Dec 2007, Abdelrazak Younes wrote:
> > 
> > > I am trying to clone the msysgit repository but I get this error:
> > > 
> > > $ git clone http://repo.or.cz/w/msysgit.git
> > > Initialized empty Git repository in d:/devel/git/msysgit/.git/
> > > D:/program/Git/bin/git-clone: line 144: /bin/git-http-fetch: Bad file
> > > number

Okay, I get the same error here.  Fishy.  But then, this is not the 
correct URL either (so I think Peff's patch probably fixes it).

What you tried is the gitweb URL, which explicitely says

	Mirror URL	git://repo.or.cz/msysgit.git

			http://repo.or.cz/r/msysgit.git

IOW replace your "/w/" by "/r/" and have fun,
Dscho
