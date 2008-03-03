From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The 8th airing of the msysGit herald
Date: Sun, 02 Mar 2008 16:44:58 -0800 (PST)
Message-ID: <m34pbok54h.fsf@localhost.localdomain>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site>
Reply-To: jnareb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 03 01:45:38 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.170])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVyoE-0004Vl-J7
	for gcvm-msysgit@m.gmane.org; Mon, 03 Mar 2008 01:45:38 +0100
Received: by py-out-1314.google.com with SMTP id p69so10363960pyb.5
        for <gcvm-msysgit@m.gmane.org>; Sun, 02 Mar 2008 16:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=ujgw+C+GBKVIGDEkRQyp3DNrA/YYrRiMFpHKiUseZoI=;
        b=OI8SLbKKXP6NRN9bUoe/uiGtUapR/w5kF+qzk4jyQgmg/NV79WKNnkADYStb3UW1oPtitXU+XP8D7xvcSVanMlFGuekptLb52kvmmchG4sVfPqGizFsoZyqjbM42pVsOwO2q7G6ObE4HSRHGXM3IMUVU8cG0ePqRVZyVqthZR9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=g6M5KMtrtcrP/RfU+fbH5ipE5HpmG3g88XX4KwkzuckGKyZKmZPjWi1rVMaO1y3G7zCIbSH9F7Fgj3vzpqCyG+CXOp1waltLgYncpEiQh/gFp5WgEsDwh0FImXCPGgatNVILwltuv6c9aGxJW7rrTnFZw2VFXu8kimDdGREsofs=
Received: by 10.140.144.4 with SMTP id r4mr972893rvd.16.1204505101843;
        Sun, 02 Mar 2008 16:45:01 -0800 (PST)
Received: by 10.107.119.35 with SMTP id w35gr1877prm.0;
	Sun, 02 Mar 2008 16:45:01 -0800 (PST)
X-Sender: jnareb@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.115.60.1 with SMTP id n1mr8745119wak.0.1204505101375; Sun, 02 Mar 2008 16:45:01 -0800 (PST)
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186]) by mx.google.com with ESMTP id k36si2340968waf.1.2008.03.02.16.45.00; Sun, 02 Mar 2008 16:45:01 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 209.85.128.186 as permitted sender) client-ip=209.85.128.186;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 209.85.128.186 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fk-out-0910.google.com with SMTP id 22so6352281fkq.13 for <msysgit@googlegroups.com>; Sun, 02 Mar 2008 16:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date; bh=3o2pF5XhtXCHKC8W0J2Zw4qt3BSs9TDwNGrrs42XnSo=; b=VOLqrNJvTt5NM44LkS27aGVXDQh8RdxgedfYo0ZIM9QzZz+BfkmpqFuwzCawUppvKVWnM9BdHGTWPgGNm8KcN7eLlbthKpIRnPwiIzPIfXUQtyAlUvIxXCQtv794v64hz+h00g5L9WSc8wPoiV9ugSMpFb52LrAU+PNqWfFcaIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date; b=lkliZZtTYjF9nfE6sRN3n7DtRe+FBGw24WVtDMWc5hkFO+EkMyF+2uF7AcJvoq+7csZgeL+HIA8OqjzuWJn88EwRqSzhzBt74DhFh5Dxp+DqfuDlf2QPwwTmm245suy0sUo3qKMKeqLS6WZsb3EZjeLIoGNyIYT3GRuTHH+4TSI=
Received: by 10.82.152.16 with SMTP id z16mr20215656bud.36.1204505099819; Sun, 02 Mar 2008 16:44:59 -0800 (PST)
Received: from localhost.localdomain ( [83.8.212.124]) by mx.google.com with ESMTPS id z37sm21310537ikz.1.2008.03.02.16.44.56 (version=TLSv1/SSLv3 cipher=OTHER); Sun, 02 Mar 2008 16:44:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m230j4TO030471; Mon, 3 Mar 2008 01:45:04 +0100
Received: (from jnareb@localhost) by localhost.localdomain (8.13.4/8.13.4/Submit) id m230j2fD030468; Mon, 3 Mar 2008 01:45:02 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LSU.1.00.0803022329560.22527@racer.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75861>


Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> > 4) What do you hate most in Git? 
> 
> The command line options. Sometimes it seems to me all the really cool 
> actions in git can only be invoked by a mysterious collection of weird 
> option switches which 1. I've never heard of, 2. are hidden deep down 
> in long manual pages which make it impossible to distinguish important 
> options from the unimportant ones, and 3. change very frequently in 
> new versions. For example, "git rebase -i" is a nice feature, but it 
> is simply a different action than a one-shot "git rebase". Hence, if 
> it is supposed to be really used, it should rather be a command such 
> as "git interactive-rebase". The GUI tools go a long way to hide those 
> mysterious option collections, but some of the daily workflow steps 
> are still unavailable in the GUI. Rebase being the most prominent, I 
> guess. 

It is not that much different. The basis operation is the same;
I don't think that "rebase -i" differs from "rebase" more than
"add -i" differs from "add".

> > 6) What was the most frustrating moment when working with Git? 
> 
> Finding that "git pull" will create many more merge commits than I 
> wanted, and that there doesn't seem to be an easy way of running "git 
> fetch; git rebase" in one command.

"git pull --rebase", but it is quite new feature.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
