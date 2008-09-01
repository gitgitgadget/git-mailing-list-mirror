From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git User's Survey 2008 has started
Date: Mon, 1 Sep 2008 16:48:13 +0200
Message-ID: <200809011648.14308.jnareb@gmail.com>
References: <200808312329.17312.jnareb@gmail.com> <200809011305.35858.jnareb@gmail.com> <20080901143718.GG10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Sep 01 16:49:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaAim-0007N3-El
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 16:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbYIAOsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 10:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbYIAOs3
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 10:48:29 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:64601 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYIAOs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 10:48:28 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1427212fkq.5
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=v6EBCtz5yS8OetaBQrBSY/IZ3sLeSTtPlmdB8ochjHs=;
        b=nXLxQ0gnG3xzqQK/8rt1+dCEL9hQGu7WDU3q7hZb4wlEL0KNsKcx4MisDHeizlg/eF
         zG8tBE2fZ/zLeDzI/7/5dm8q+ck60g0ouZYvstA6GNfFedbDOybvabkF+J6IZegvFz6B
         vMNDJtKZu7U5DPcxkt8aJDLPWpzcYYYKQMqBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uf8zHQZe87JYz4tNPF+PwlGb77ekNU+bK6hLGIagXFY+2h9qPDiqNCn83fUmyesgK0
         lBzriflTWdE+udtW3MRH8oEB4vmLSus2xTkL8EgZIlep42F6EP+XD23e876iOvJ1Zuu9
         B54LjsllyFQ3oPVo0R75QiW8CfO2X1LcoqVH4=
Received: by 10.181.37.11 with SMTP id p11mr5033127bkj.9.1220280505249;
        Mon, 01 Sep 2008 07:48:25 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.218.210])
        by mx.google.com with ESMTPS id z10sm5663661fka.15.2008.09.01.07.48.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Sep 2008 07:48:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080901143718.GG10360@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94589>

On Mon, 1 Sep 2008, Petr Baudis wrote:
> On Mon, Sep 01, 2008 at 01:05:35PM +0200, Jakub Narebski wrote:
> >
> > Thank you very much for posting announcement about Git User's Survey at 
> > http://repo.or.cz.  Could you please add similar announcement somewhere 
> > in the first page of Git Homepage (http://git.or.cz)?  Something like:
> > ---
> > <strong>
> > <a href="http://www.survs.com/survey?id=M3PIVU72&channel=2WXE4BVTW8">The 
> > Git User's Survey 2008</a> is up!
> > 
> > Please devote a few minutes of your time to fill this simple 
> > questionnaire.  It will help the Git community to understand your 
> > needs, what you like of  Git, and, of course, what you don't like of 
> > it.
> > </strong>
> > ---
> > (you can use http://tinyurl.com/GitSurvey2008 instead, if you prefer).
> 
>   oh - around the time you wrote this mail, I've been doing just that.
> ;-)  I kind of prefer my wording, though; if you mind, I have no problem
> replacing it with yours, though.

Ah, I see (now that I force-refreshed the page ;-))
---
<b>The <a href="">Git User's Survey 2008</a> is up!</b> Please take
a short while to answer the questions so that we better understand how
do you use Git and improve it even more.
---

That is I think even better wording. Would you mind if I stole^W
borrowed it, and use as proposal when sending requests for adding
Git User's Survey 2008 announcements to other git related sites,
and other git hosting sites (git.kernel.org, GitHub, Gitorious,
{gitweb,cgit}.freedesktop.org,...)?

-- 
Jakub Narebski
Poland
