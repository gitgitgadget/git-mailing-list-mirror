From: "Marco Costalba" <mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] qgit2.1rc1_win.exe
Date: Thu, 27 Dec 2007 00:23:36 +0100
Message-ID: <e5bfff550712261523g7aab6e76nd37257e7b21d1653@mail.gmail.com>
References: <e5bfff550712240113y4acdaa11y3483705172a5980e@mail.gmail.com> <fkugn8$d2s$1@ger.gmane.org>
Reply-To: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: "Peter Klavins" <klavins-ooduxAEi7gXtt0EhB6fy4g@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Dec 27 00:24:07 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.243])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7fbX-0006Cb-B5
	for gcvm-msysgit@m.gmane.org; Thu, 27 Dec 2007 00:24:03 +0100
Received: by wa-out-0708.google.com with SMTP id n36so1170133wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 26 Dec 2007 15:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=OkmtG38UujurJINQ38zjkelMWvItY6N6YyHo4mixIzc=;
        b=ezKTc+g4GpLdHz62R3ywV8HkzsOw1QQWH45qQOuT0Pd6I5k3lfrQp13jjRZMJz2tMviD9SSDjxCXzA69x4/f3HYpfBdqu+zavKc4vu2AgbqdT5H3nsa37z4iJ8NGRSMEf9L3DzrGpCAcN1aP/l+nUSg+pE207EQ+PpAyrqZg2OA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=dFPDaPu2KOwPnJfnG6X/0QqvT+eipQob6Rye+0YGjQqjp2nGtgejV3mD4JVnFECwKqvLl5Lt98cq/fG31mKSsShZHo+idTj69v4uhHo7USk9SEVolC8l8//QehZArefoz13UIw8z1qM71JLx/CQZ+Sbi86985DujNX8iA6d5shk=
Received: by 10.114.108.15 with SMTP id g15mr244157wac.3.1198711418350;
        Wed, 26 Dec 2007 15:23:38 -0800 (PST)
Received: by 10.107.94.14 with SMTP id w14gr1283prl;
	Wed, 26 Dec 2007 15:23:38 -0800 (PST)
X-Sender: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.131.9 with SMTP id e9mr3882458wad.5.1198711417939; Wed, 26 Dec 2007 15:23:37 -0800 (PST)
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189]) by mx.google.com with ESMTP id k36si10708368waf.0.2007.12.26.15.23.36; Wed, 26 Dec 2007 15:23:37 -0800 (PST)
Received-SPF: pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.189 as permitted sender) client-ip=209.85.198.189;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.189 as permitted sender) smtp.mail=mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by rv-out-0910.google.com with SMTP id k20so2209874rvb.5 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 26 Dec 2007 15:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; bh=CxbF67MdgS6mq3EzPZQoXSATwEDrzXtbuL36YLcLnWY=; b=uHNYqTmVYzWX43G2ccMEUiLFuAfJarbCRXoIhosU/q5zjirwfSrqZN4QebqOABj73KuGpsoNQwqDL0TUCJqdNN1wwG2rGSxN78ngNOQimJx9MSYMPHAIiIMUXA7JI8kmrdmxbq78kjxam7JS5E6FPnPe2GxqFo49cUdzFUCiui4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; b=Cm6lwZ2NOzhXREb4/3mvB+MirQb6FME0xehd81G2ypPqH/7olkWhBI4LeUoScXRSIJdxFTdcSsDrwqsgmqLN9va3nneprPAW7KmWoEWyc9fe+H3vn/g4kWjsk1/wacGQ98IJeiFq9BF/VVDj0Gz0fFdSGvqVqHb+aM9SkVce2i8=
Received: by 10.140.248.17 with SMTP id v17mr3677069rvh.9.1198711416909; Wed, 26 Dec 2007 15:23:36 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Wed, 26 Dec 2007 15:23:36 -0800 (PST)
In-Reply-To: <fkugn8$d2s$1@ger.gmane.org>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69248>


On Dec 26, 2007 10:22 PM, Peter Klavins <klavins-ooduxAEi7gXtt0EhB6fy4g@public.gmane.org> wrote:
>
> 4. configure                 (takes significant time, around 10 minutes from
> memory)

configure -fast -no-qt3support -static -release -no-qmake

Takes much less (about one minute)

> 5. nmake                     (takes over an hour on a Core 2 Duo 2 GHz,
> consumes 2 GByte of disk)
>

2GBytes because default configure is -debug, but giving -release
instead the needed space is much less because debug symbols are not
built.

Also use:

nmake sub-src

30minutes on my Core Duo 1.5Ghz. It just compiles the Qt libraries
under src directory, not Qt tools like designer, assistant and
expecially the Qt examples.

Note: first you need to run nmake to build makefile then, just after
the makefile in main directory is built (few seconds) you can stop it
and run nmake sub-src.

> 16. bin\qgit             (to run qgit to browse qgit4's own repository!)
>

msysgit must be in PATH, both Git\cmd and Git\bin. Or you can use the
launch script start_qgit.bat that just adds msysgit to the PATH for
you before to call qgit.exe



> ------------------------------------------------------------------------
>  Peter Klavins
>

Thanks Peter,

Just a question. How about using the auto-extract zip I advertise in
this thread? With this both Qt and qgit are already compiled and
should be ready to go.


Marco
