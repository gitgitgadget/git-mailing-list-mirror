From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: github:FI
Date: Sun, 13 Jun 2010 07:44:53 -0700 (PDT)
Message-ID: <m3aaqzouv0.fsf@localhost.localdomain>
References: <AANLkTin838fW6L0W1P__seKnIZi58QtdQzgmUFFQTJC2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 13 16:45:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONoRg-0001UK-6z
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 16:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944Ab0FMOo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 10:44:56 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43229 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab0FMOo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 10:44:56 -0400
Received: by fxm8 with SMTP id 8so1959945fxm.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=GCn74CiKcMWG/IPV4kBrfVnn09tmDWejOPGnCSr0Fzg=;
        b=uXZskKXpj19xUXCxXKuiRq+QLhTFyUiJ0FUox7bggFUUPGgXPGU6JXxhX9jiJLqylE
         W52jVBFuRz/q2SZvBcgPsg7JqeJvG+PHM2098sP/noF3xExqODvatO9+mIlwnrAgH6eA
         gIQJWgL5EfARweH1skPrIby4BuBl+w3BYWjtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=avxSzTmrISLPjvy0J51zRZlKUHQrvp2SHhN71Vcqbf3TR0RY2LK9VPL7wKqf2QQ9ge
         sEEhCCeeiUF8En4hwmGsyGbX/wLjI02pdpwDTcv/MzyYFd+0ux8NTtoQ9U4Bq0HLuXEC
         mDar5byzkmEQz+k1d7Eqf/xGCtQV/uH76eLBU=
Received: by 10.223.20.216 with SMTP id g24mr4233478fab.63.1276440294382;
        Sun, 13 Jun 2010 07:44:54 -0700 (PDT)
Received: from localhost.localdomain (abve213.neoplus.adsl.tpnet.pl [83.8.202.213])
        by mx.google.com with ESMTPS id n6sm1330724fam.31.2010.06.13.07.44.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 07:44:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5DEiPZH032607;
	Sun, 13 Jun 2010 16:44:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o5DEiJdE032603;
	Sun, 13 Jun 2010 16:44:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTin838fW6L0W1P__seKnIZi58QtdQzgmUFFQTJC2@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149049>

Mahesh Vaidya <forvaidya@gmail.com> writes:

> I am exploring git hosting options and web interfaces. I have
> implemented my own system based on gitweb, git, gitosis and gitstat.
> I'm exploring github:FI

If you are looking at OSS equivalents to GitHub, you should take a
look at Gitorious (in Ruby), InDefero (in PHP) and Girocco (in Perl +
shell, powers repo.or.cz).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
