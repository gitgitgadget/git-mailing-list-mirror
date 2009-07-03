From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rails code to serve git repositories?
Date: Fri, 03 Jul 2009 04:48:10 -0700 (PDT)
Message-ID: <m3zlbmugx8.fsf@localhost.localdomain>
References: <a6591d550907030428w175ba2ajb4bef8e906a2de5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bjorn Boulder <bornboulder77@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 13:48:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMhFd-0005z4-UY
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 13:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbZGCLsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 07:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbZGCLsL
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 07:48:11 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:50272 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbZGCLsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 07:48:10 -0400
Received: by fxm18 with SMTP id 18so2108199fxm.37
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=WyRz8Hm/1Dnv/TJXKr3norS9moiSFbEB4L1goqPl92A=;
        b=sca8aiTrsxrwuZ2JyXugcI8AbBlUS5Y4mm9nLB2dFlapGl/6I4CcQq7JQqZ/XUhuFY
         YPqlse1BtDpu40uMt8dd1FfSbjAradYLLteOG82PnA9uHF8eeN9+ECcuL8m8ApyDM7DA
         n72SL5ZVtFxZazhyKSMZojicKfKs9Gd43e3i4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=kuiGagxdsexOlqz25zvHzw8Ac3CRexJK8JHRz+Nbl6uBfaoILkUyt3AkwVURxZS7kr
         EQmOUxJgiMIhaXxG38+GPkhebHLQG5W/LHc1KKWH2E56oCI9nmlUc7UlV9xS/3JXALLn
         ay1hjH7e4E0gXEQX1K+Hxhk0zuQOccm4lOb4M=
Received: by 10.103.218.9 with SMTP id v9mr733147muq.109.1246621691363;
        Fri, 03 Jul 2009 04:48:11 -0700 (PDT)
Received: from localhost.localdomain (abvs71.neoplus.adsl.tpnet.pl [83.8.216.71])
        by mx.google.com with ESMTPS id i5sm17280496mue.55.2009.07.03.04.48.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Jul 2009 04:48:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n63Blgft014144;
	Fri, 3 Jul 2009 13:47:53 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n63BlWCH014140;
	Fri, 3 Jul 2009 13:47:32 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <a6591d550907030428w175ba2ajb4bef8e906a2de5a@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122697>

Bjorn Boulder <bornboulder77@gmail.com> writes:

> rails and git people,
> 
> I am searching for some Rails code I can use to serve git repositories.
> 
> Please alert me if you know of any projects which have this use-case.
> 
> In other words I want to create my own github.

Gitorious (git hosting).

Gitarella, Ginatra (gitweb-like).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
