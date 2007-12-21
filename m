From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: msysgit Git-1.5.4-rc1 available
Date: Fri, 21 Dec 2007 20:25:12 +0100
Message-ID: <942A66A8-7E8F-483C-ACCB-6EDD3BBA034A@zib.de>
References: <0F6939E0-686C-4526-85D1-447C080230A5@zib.de>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Dec 21 20:24:48 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.249])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5nU6-0005hA-Fq
	for gcvm-msysgit@m.gmane.org; Fri, 21 Dec 2007 20:24:39 +0100
Received: by wr-out-0708.google.com with SMTP id 56so2991851wra.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Dec 2007 11:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=GLA4fNscQri2AFWiu5iMEjg9GhFuQuyvLUfr82HcrbE=;
        b=ytY9lBftIiACO70ZM2gSykdB0MFgmeCAHq3sV/DzDKipxpvmLtnrRQJlcuXERRUn6sC/qDedjsl3uzeFrWrn02i2cqkr5XEQgYT1Nn/PPcPALXRfOVQ/dFSZJ7wB80LMM+y1fZSxHecudUIfw73zt1DwkU4pe0hs1mlz50ah3eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=2xWYwAG7gchhSbsVXyYpDcNBlF2QTAaZmCySR5z+88dunTPi1au50IRyqt3yEdonDMbew1XdbU8WbausuessyMDUPbJf3mXm8mKSvCzbB8pswvYqr/JOcutWT+GzfZ9uWozWferWDmuioEBH612epkmRZ3Q3650GxyZ0Ge4uKiE=
Received: by 10.100.168.18 with SMTP id q18mr21187ane.9.1198265049461;
        Fri, 21 Dec 2007 11:24:09 -0800 (PST)
Received: by 10.107.65.8 with SMTP id s8gr1274prk;
	Fri, 21 Dec 2007 11:24:09 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.106.1 with SMTP id e1mr439929wac.28.1198265049267; Fri, 21 Dec 2007 11:24:09 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id v28si5126313nzb.4.2007.12.21.11.24.08; Fri, 21 Dec 2007 11:24:09 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lBLJO7QC000426; Fri, 21 Dec 2007 20:24:07 +0100 (CET)
Received: from [192.168.178.21] (brln-4db82207.pool.einsundeins.de [77.184.34.7]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lBLJO6lx027404 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Fri, 21 Dec 2007 20:24:06 +0100 (MET)
In-Reply-To: <0F6939E0-686C-4526-85D1-447C080230A5-wjoc1KHpMeg@public.gmane.org>
X-Mailer: Apple Mail (2.752.3)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69086>



On Dec 21, 2007, at 11:05 AM, Steffen Prohaska wrote:

> for download from
>
> http://msysgit.googlecode.com/files/Git-1.5.4-rc1-preview20071221.exe

I recognized that this installer does not contain
all new binaries.

I uploaded a corrected version

    Git-1.5.4-rc1-preview20071221-corrected.exe

which is available from

    http://code.google.com/p/msysgit/downloads

Sorry for the confusion.

	Steffen
