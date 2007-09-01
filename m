From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Sat, 1 Sep 2007 11:15:58 -0400
Message-ID: <9e4733910709010815t23849056j9039a9d92eae15ee@mail.gmail.com>
References: <20070831000149.GK1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jnareb@gmail.com, ltuikov@yahoo.com
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 01 17:16:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRUi1-0004m8-8Z
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 17:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbXIAPQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 11:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbXIAPP7
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 11:15:59 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:14027 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbXIAPP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 11:15:59 -0400
Received: by rv-out-0910.google.com with SMTP id k20so624866rvb
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 08:15:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YHkKPPRTP5m40tGYwnP4to90n7r1a+GqULwn5pQbpmcTh0AeD+eKSBDHxuQtHtGEOI63oO2chInLJNKiycZl1hJMmRaC9tZ6BGDoD8jDJuqn0fjKA38mj5v8WRm4KVTbwd52mK/Oued2H9NpUTiUY7+lTmYWueveZApU9Hx71nI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ntbchaid/Ht9cHnUrlWniSWkezD3dnM8NhMybFbeeYU1JqCgkBUBhy3xSuc/5XD5ZiQG0Feno15ll3k9kYZIs8ReVicI/wa7aO4mTx2E/+XY+q9DgYuf7FeG4zZU3dfUh5uQjNh/6EcxX/Syy2LiD/nL9U6meeNB2AJZViTCdk0=
Received: by 10.141.169.9 with SMTP id w9mr1193508rvo.1188659758254;
        Sat, 01 Sep 2007 08:15:58 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Sat, 1 Sep 2007 08:15:58 -0700 (PDT)
In-Reply-To: <20070831000149.GK1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57277>

On 8/30/07, Petr Baudis <pasky@suse.cz> wrote:
>   Hi,
>
>   due to popular (Junio's) demand, I have set up a gitweb-oriented fork
> of git at repo.or.cz:
>
>         http://repo.or.cz/w/git/gitweb.git
>
>   It is meant as a hub for various gitweb-related patches and
> development efforts. So far it is pre-seeded by the patches repo.or.cz's
> gitweb uses. It is divided to three main branches (StGIT patchstacks in
> reality), where master is what Junio is gonna pull to git's master.

Using gitweb....
Since this is a patch stack, how do I get the summary log messages for
just the commits on the branch without getting the log messages for
the master repository mixed in? Would that give me a nice list of the
pending patches?

I can get the tree diffs without problem.


>
>   Please feel encouraged to make random forks for your development
> efforts, or push your random patches (preferrably just bugfixes,
> something possibly controversial should be kept in safe containment like
> a fork or separate branch) to the mob branch.
>
>   Have fun,
>
> --
>                                 Petr "Pasky" Baudis
> Early to rise and early to bed makes a male healthy and wealthy and dead.
>                 -- James Thurber
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
