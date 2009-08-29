From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-bz: command line integration for bugzilla
Date: Sat, 29 Aug 2009 01:07:38 -0700 (PDT)
Message-ID: <m3fxbbkpq5.fsf@localhost.localdomain>
References: <1251512664.666.349.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Owen Taylor <otaylor@redhat.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 10:08:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhIye-0002RP-Ex
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 10:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbZH2IHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 04:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbZH2IHk
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 04:07:40 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33718 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZH2IHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 04:07:38 -0400
Received: by bwz19 with SMTP id 19so1965459bwz.37
        for <git@vger.kernel.org>; Sat, 29 Aug 2009 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=C/RbrP4cJiea8Ct1YhcWr262+N0loVWLWp3z7LtbZdo=;
        b=eGskGeWpj7nlrueAhFmY9xo7B3OCZR7Yyff53FJsALTUxXVZi+0I3Qa50AGrQQj80T
         rqylI1pmM9qPTcy+IWstylewytLdjXARgyza+2Q8xgWLJpWke327trsYxKe/zZ3R30op
         xeMuSWPb9MNJBjkU9qeucjNJZD6WecTZlU3do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Rmd1eevnKUeMdbDMFEsj0qELczj6+Gl6r+w/arndRiAmnCSQ1UE3jyd/Q1WvLeqaD4
         I4cvPGVOCWNbXk51HSA6iCEXgkqFiVNqEJKjefpBLWEaKyxe5OQUItElA6p9Qed+KoPK
         jyPSlG6mOZamL3CPYixOQ1LnVjIUm8u2PPYsI=
Received: by 10.204.36.210 with SMTP id u18mr1815117bkd.19.1251533258635;
        Sat, 29 Aug 2009 01:07:38 -0700 (PDT)
Received: from localhost.localdomain (abrz199.neoplus.adsl.tpnet.pl [83.8.119.199])
        by mx.google.com with ESMTPS id 12sm2675952fks.51.2009.08.29.01.07.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Aug 2009 01:07:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7T87YwW005431;
	Sat, 29 Aug 2009 10:07:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7T87Ved005428;
	Sat, 29 Aug 2009 10:07:31 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1251512664.666.349.camel@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127376>

Owen Taylor <otaylor@redhat.com> writes:

> Was filling out the Git user's survey today, and noticed that my git-bz
> tool wasn't on the long list of "Git interfaces, implementations,
> frontends and tools" 

Well, you can always add it in "Other (please specify)" in survey

>                      - but then again, I've never really advertised it
> beyond GNOME IRC. So, I was reminded to mention it here...

Could you please add (short) information about this tool to Git Wiki:
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

-- 
Jakub Narebski
Poland
ShadeHawk on #git
