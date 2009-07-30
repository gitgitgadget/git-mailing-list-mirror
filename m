From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Git for Windows 1.6.4
Date: Thu, 30 Jul 2009 02:13:08 +0200
Message-ID: <40aa078e0907291713x3c672fdsf013465b373ae57b@mail.gmail.com>
References: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de> <40aa078e0907291705r65feae3au1dfc5b6400f4e434@mail.gmail.com> <40aa078e0907291710j23695160q34541e4dc5943f3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Jul 30 02:13:24 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f162.google.com ([209.85.210.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWJGt-0004E0-W8
	for gcvm-msysgit@m.gmane.org; Thu, 30 Jul 2009 02:13:24 +0200
Received: by yxe34 with SMTP id 34so1552924yxe.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 29 Jul 2009 17:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:mime-version:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=551NDaUXIJf2BcasH4SHtr41nDBPL7RIICnJE8EcJuM=;
        b=nzbKrZ33TvgFm/CwmoKgiO+ah3xGEPy4peBBzp4yPxf0JIMpW2BfDXTAcSVUSWu2pv
         m6KQMWA2gKisIE9MMMcnqC9i2H6UxOFdTD5V/fY72lRwhz4sSTkauiiFhTBzCmuMyuT1
         pzk2B7ywAU8o1MfbF+CFe0NKquvjfBojDEsuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=ymK5YUhQTCmc0KI3NXV8f3ow1+pTZ42rs2ps2Hl3N5mU6QGSBUfLR+Oj9NSsvU37iz
         FaF1A+pc8EsGOGKQwQvyQZ6HAZerwlCVo/QCc57DAz6x6wUwPPOssarNj5GfVyQfrJKb
         BccKKe1aIcn/tqhFg55UHMEhY0q0wRSbCD9l4=
Received: by 10.151.112.4 with SMTP id p4mr110413ybm.19.1248912792506;
        Wed, 29 Jul 2009 17:13:12 -0700 (PDT)
Received: by 10.176.56.38 with SMTP id e38gr5994yqa.0;
	Wed, 29 Jul 2009 17:13:10 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.59.197 with SMTP id m5mr11209bkh.19.1248912790273; Wed, 29 Jul 2009 17:13:10 -0700 (PDT)
Received: from mail-fx0-f215.google.com (mail-fx0-f215.google.com [209.85.220.215]) by gmr-mx.google.com with ESMTP id 14si249039bwz.1.2009.07.29.17.13.09; Wed, 29 Jul 2009 17:13:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.215 as permitted sender) client-ip=209.85.220.215;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.215 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by fxm11 with SMTP id 11so352160fxm.15 for <msysgit@googlegroups.com>; Wed, 29 Jul 2009 17:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=aP3pgLvs+Wgyj35kkcwDG/7wRDgqS1jBLE9vh+bHhPs=; b=lAoDyU5E2/2aXZEz8/ID3j93HpgueBSXSIZWdiQGm8+mhVjdDWmILNnb5r7KhU7jTf Ff2YC1UHlYXK9EU8geiegYWKgspfD5kzD/vwkWS6uGl2+j+eTchDmo4AfVAGBcY6WHeQ +t0VFHbYECeR5AKYMrF12vXS14PzJwbO7SJak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=AWQqr2UypUiMjvXh1D2UOtuDP8SX//v4nyR42vXR6jzJLs/J8a8PqfyUrTGBCTyjRe dfq4bsRTy4OeoYzsxwig8hXWbW/0139KTRoWU4clj2D1hPsdiRE/Th6zSuI2uXBKfF9m BGZ/sJKFnBWnl3kqDiALDAUdU1r+upre9j58s=
Received: by 10.204.61.204 with SMTP id u12mr409844bkh.149.1248912788809; Wed,  29 Jul 2009 17:13:08 -0700 (PDT)
In-Reply-To: <40aa078e0907291710j23695160q34541e4dc5943f3d@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124418>


On Thu, Jul 30, 2009 at 2:10 AM, Erik Faye-Lund<kusmabite@googlemail.com> wrote:
> Checking in c:\msysgit\bin I find most needed stuff, but not

Uhm, that should have been c:\msysgit\installer-tmp\bin...

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
