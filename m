From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Alles wurde Git
Date: Thu, 8 Oct 2009 00:15:13 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910080014060.4985@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0910041310520.4985@pacific.mpi-cbg.de> <4ACD076B.3000902@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Phil Lawrence <prlawrence@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Oct 08 00:12:58 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f141.google.com ([209.85.210.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvekj-0008Kf-82
	for gcvm-msysgit@m.gmane.org; Thu, 08 Oct 2009 00:12:57 +0200
Received: by mail-yx0-f141.google.com with SMTP id 5so6233140yxe.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 07 Oct 2009 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:received
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=MImIWv2h5G4+HGTv1nYN8T56H/2Z/5A4M2Pq/sGpaPg=;
        b=nqwawZH1YRoTMUmH0hbjXV0hzQ3S8+rRvRJCd6Qz9v5/HyumNKwSygvY/Ata7oEhn4
         KKj7QUziwkNiBPIEGunKbc0iNQQphv9HCwinSN/e9azvgKcSxXrxFZthsBLg7rGZUdIF
         nGk3YbsrxnTX1NWKtFa+FrUvcyrmJpfku0MEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=trz61Ct1VVmpV0aPskzUdd0BmiaHFSw/aXFFixDebmdI4Yz9IEd4sWxFRc6kt0cxCp
         TfZz4/NbCcqn0jl/9uEpyUO5N3SHjNiK76S7JanXjR2KycwWQXAecsjMPvg9Y5z72CGW
         U9E7sJqf7Y2aBuExUjPmmsEJGUKiw5N+Sdwc8=
Received: by 10.100.199.19 with SMTP id w19mr40675anf.13.1254953570714;
        Wed, 07 Oct 2009 15:12:50 -0700 (PDT)
Received: by 10.177.108.35 with SMTP id k35gr7342yqm.0;
	Wed, 07 Oct 2009 15:12:47 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.1.141 with SMTP id 13mr9194bkf.29.1254953566208; Wed, 07 Oct 2009 15:12:46 -0700 (PDT)
Received: by 10.204.1.141 with SMTP id 13mr9193bkf.29.1254953566172; Wed, 07 Oct 2009 15:12:46 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id 14si1081539fxm.3.2009.10.07.15.12.46; Wed, 07 Oct 2009 15:12:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 07 Oct 2009 22:12:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp011) with SMTP; 08 Oct 2009 00:12:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nen9doG/nmjOR89cZbga3hmoF2KixexPtfcE/fo WNcgZxOoP7c2VP
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4ACD076B.3000902@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129661>


Hi,

On Wed, 7 Oct 2009, Phil Lawrence wrote:

> On 10/04/2009 07:09 AM, Johannes Schindelin wrote:
> >
> > ...Steffen also described some of the issues with working on a large 
> > number of topic branches that need to be integrated/cleaned 
> > up/rebased:  Git lacks good tools for working collaboratively with 
> > topic branches that need to be rebased frequently. He also showed a 
> > rather complicated script that is necessary to coordinate work between 
> > 3 different maintainers (at 3 different locations). ...
> 
> Steffen, any chance you would share that script with the list?  It 
> sounds very interesting.

I fear that the script is rather specific to the company's environment, 
and I fear further that Steffen might not be allowed to share it due to IP 
issues.

Ciao,
Dscho
