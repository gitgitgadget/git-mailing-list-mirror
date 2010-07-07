From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2010 (resend)
Date: Wed, 07 Jul 2010 14:43:16 -0700 (PDT)
Message-ID: <m3fwzvm0jc.fsf@localhost.localdomain>
References: <201007032158.57700.jnareb@gmail.com>
	<AANLkTilD8N6rnj9e3KzRB7_q3J0I4cJGx5EduX_UJScC@mail.gmail.com>
	<201007041013.40563.jnareb@gmail.com>
	<loom.20100707T105938-93@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Wed Jul 07 23:43:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWcP5-00036x-EW
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 23:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841Ab0GGVnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 17:43:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59260 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757667Ab0GGVnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 17:43:19 -0400
Received: by fxm14 with SMTP id 14so54732fxm.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 14:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yf3bxJCMHGtSdAaDNMHPNwMv3FGjciurxuiXBxiUthg=;
        b=bHfIut011y8oYv13nJaeJaDErRPi4sGgGEdCNKI6Hl0A67POCQ3XGVmQzNaJrOEkmD
         zlDAWWb96N3StWiVNklBgTCLbv38RJr9kEsalvMObPZpy9FLcQ+o1vVyhWKJR7+zLewQ
         XxFn2AMmREkYZVJQv/iXnIY/3RvxWuvVU12DA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ZlFl2RspAyDQ+8JxaLdNVusheqO03zUkoXrij0cXSoFGT6koIq7QkW20GuWazM/XtS
         HBR6jEtelmttHTlPKn1Tb2hEKVKwLD+C8GyTc3KAuexuM/MCg2DNQ46KCOQkKKGS2C5O
         U9C+BFIblKvYAyg0A6YnapHI+9Y4+dp79Lv6c=
Received: by 10.223.103.211 with SMTP id l19mr6391870fao.62.1278538997502;
        Wed, 07 Jul 2010 14:43:17 -0700 (PDT)
Received: from localhost.localdomain (abvr9.neoplus.adsl.tpnet.pl [83.8.215.9])
        by mx.google.com with ESMTPS id q24sm15353564faa.42.2010.07.07.14.43.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 14:43:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o67LglBO002636;
	Wed, 7 Jul 2010 23:42:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o67LgVlO002632;
	Wed, 7 Jul 2010 23:42:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20100707T105938-93@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150511>

Yann Dirson <ydirson@free.fr> writes:

> Jakub Narebski <jnareb <at> gmail.com> writes:
> > === xx. Have you found distributed version control easy? ===
> > (multiple choice)
> > 
> >  + Very easy
> >  + Easy
> >  + Reasonably easy
> >  + Hard
> >  + Very hard
> > 
> > Or something like that, with separate question if DVCS is difficult
> > or not.
> > 
> > Alternatively we could ask about _relative_ ease of learning / use.
> > But I don't think this would go well (and I don't think we could get
> > good answers from that).
> 
> Related to that, would be whether the user was familiar with DVCS before
> starting to use git, or even familiar with VCS - the answers would be different
> for people for whom git is the first VCS they ever used, or for people having
> used other DVCS before...

Relative ease of use of Git as compared to perceived ease of
distributed version control as generic subject.

But I don't think it is a good way to go (and get meaningfull
answers).
 
> > Well, Git User's Surveys always served more or less accidentally as
> > the source of information about git and git community ("we have wiki?"
> > from the first survey )
> 
> Count me in for "we have git new-worktree ?" :)
> In fact, I found nothing by that name in git's tree or in the wiki's
> InterfacesFrontendsAndTools.  Google finally pointed me to contrib/ where I
> noticed workdir/git-new-workdir.
> 
> It may be worth to use a URL for publicizing non-mainstream stuff.  That's
> better as publicizing goes, and makes it easy to crowdsource discovery of
> mistakes or outdated things.

Hmmm... perhaps it would be worth to create GitContrib page on Git
Wiki, and link it from InterfacesFrontendsAndTools page...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
