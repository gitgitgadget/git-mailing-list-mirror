From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The 8th airing of the msysGit herald
Date: Mon, 3 Mar 2008 02:10:01 +0100
Message-ID: <200803030210.02223.jnareb@gmail.com>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site> <m34pbok54h.fsf@localhost.localdomain> <alpine.LSU.1.00.0803030052450.22527@racer.site>
Reply-To: jnareb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 03 02:11:06 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVzCd-0001JW-G4
	for gcvm-msysgit@m.gmane.org; Mon, 03 Mar 2008 02:10:55 +0100
Received: by ug-out-1516.google.com with SMTP id 1so3001750uga.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 02 Mar 2008 17:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=IWrH6ZYtEei1LFUlUlscEnsT3rk2FEfT2o9cC6wzVdg=;
        b=336qtxTmhx5hRYbWU+17XQsdsiaveOqr0bYlW8dgrZ3hIs0VBJViihfvirdkV/KCE6ccse0TzCHd5Vy26azglF+kQJx/oEBD3nnndFjzQo8aIFFZGuDNDt9kpQxoZQBjYJTYTKgoBlXS0jsG02+eFSLc7SoGMghRmPwdnTvF/7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=1nDKHO3p9sNVGQMnw9+8VkaTSMvzcAd7pfs0o4yBzbm+4731ulymEujttXN40vLZJTMcornw7BaVMOfIRx54wnl+Lyqf1JHAXhzXaQrX8L2M1oBTP2al6Xd0j6sNzlerx7PgJKvwTNnLg8B+AWThD169XPPIGV+syMk/jqgB9cc=
Received: by 10.140.187.10 with SMTP id k10mr976570rvf.6.1204506601087;
        Sun, 02 Mar 2008 17:10:01 -0800 (PST)
Received: by 10.106.227.37 with SMTP id z37gr1879prg.0;
	Sun, 02 Mar 2008 17:10:01 -0800 (PST)
X-Sender: jnareb@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.115.91.2 with SMTP id t2mr8770943wal.20.1204506600653; Sun, 02 Mar 2008 17:10:00 -0800 (PST)
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.190]) by mx.google.com with ESMTP id k36si9401waf.1.2008.03.02.17.09.59; Sun, 02 Mar 2008 17:10:00 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 209.85.134.190 as permitted sender) client-ip=209.85.134.190;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 209.85.134.190 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mu-out-0910.google.com with SMTP id i10so8980770mue.5 for <msysgit@googlegroups.com>; Sun, 02 Mar 2008 17:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id; bh=PXExFYPqkkY5Pxu36q+P9TnVVc/1XMRq5Ft1i+rXOWs=; b=DhYdFrI30IBDyCfM9B1NaL+1vX6MrfrKnHkybM/O+O+psRE8l/Y6qfMHtLMia/xzjpLlB5L0gidcjLlC4E/xYzxdkXDz4N84bQb+c78fiEiIdiBW5UupakqvSmB3YhGp8MZKDUKkBDqWHref9dWmPFBGSx1fDijEbIy1+4dWUN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id; b=sppyYjvH7RxmXee0jpTfejg9w8AkISVdHh/g53SngfcMH3bMBvHaI6cG6Aq0CbR5eFhrusA5yBvy+VXrS8dnY6n8+Y1B2lXQmtsNpsj9pfI2KM1KFKE1gnKRSXb1pJ9/FkgX3uw9ModWz74iKw7aoDx4heLmC6hbT8zOn3X8ecI=
Received: by 10.82.158.12 with SMTP id g12mr502164bue.2.1204506596937; Sun, 02 Mar 2008 17:09:56 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.212.124]) by mx.google.com with ESMTPS id b33sm21374261ika.5.2008.03.02.17.09.54 (version=SSLv3 cipher=OTHER); Sun, 02 Mar 2008 17:09:55 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0803030052450.22527@racer.site>
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75863>


Johannes Schindelin wrote:
> On Sun, 2 Mar 2008, Jakub Narebski wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>>> 6) What was the most frustrating moment when working with Git? 
>>> 
>>> Finding that "git pull" will create many more merge commits than I 
>>> wanted, and that there doesn't seem to be an easy way of running "git 
>>> fetch; git rebase" in one command.
>> 
>> "git pull --rebase", but it is quite new feature.
> 
> Yes, it is.  And it is not that easy for our users to find out about what 
> new features got into Git, since there are _so many_ new features.

There are always RelNotes ;-))))

For me the sign how incredibly fast the git development is is the fact
that git version from a year ago is considered "ancient".

-- 
Jakub Narebski
Poland
