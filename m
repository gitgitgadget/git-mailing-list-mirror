From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Fri, 31 Aug 2007 18:06:02 -0700 (PDT)
Message-ID: <767502.77573.qm@web31812.mail.mud.yahoo.com>
References: <20070831000149.GK1219@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: jnareb@gmail.com, ltuikov@yahoo.com
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 03:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRHXk-0000Vv-JR
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 03:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbXIABMp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 21:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXIABMp
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 21:12:45 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:35093 "HELO
	web31812.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751306AbXIABMo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 21:12:44 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Aug 2007 21:12:44 EDT
Received: (qmail 93570 invoked by uid 60001); 1 Sep 2007 01:06:02 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=N6LR4SAmywIlzwlMeO+ofKN6CXd3LI0NCPIzK+q4sluuEuQoQ6lNTxiFxFYCcWlOS7Z8hwOzMTfDb5QcFhxzEt3ATPyjP7XbUvN12zo8seg7+4q6XMUUs99gRNpCMJJzza4sTz7L9aNKLHMIWJqeUeGB+yHyPH2ZX65JIqI1+Eg=;
X-YMail-OSG: WR59W9oVM1m_baRziCbZUKrtaUuG_Io2Y3l0gasd1YYbCb68DrviqG9xYO9nBFH5ig--
Received: from [64.215.88.90] by web31812.mail.mud.yahoo.com via HTTP; Fri, 31 Aug 2007 18:06:02 PDT
In-Reply-To: <20070831000149.GK1219@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57236>

--- Petr Baudis <pasky@suse.cz> wrote:
>   Hi,
> 
>   due to popular (Junio's) demand, I have set up a gitweb-oriented fork
> of git at repo.or.cz:
> 
> 	http://repo.or.cz/w/git/gitweb.git
> 
>   It is meant as a hub for various gitweb-related patches and
> development efforts. So far it is pre-seeded by the patches repo.or.cz's
> gitweb uses.

Is this right?

So what's the review process now?  "Because it is part of repo.or.cz's
gitweb" seems to be a weak argument.

   Luben

> It is divided to three main branches (StGIT patchstacks in
> reality), where master is what Junio is gonna pull to git's master.
> 
>   Please feel encouraged to make random forks for your development
> efforts, or push your random patches (preferrably just bugfixes,
> something possibly controversial should be kept in safe containment like
> a fork or separate branch) to the mob branch.
> 
>   Have fun,
> 
> -- 
> 				Petr "Pasky" Baudis
> Early to rise and early to bed makes a male healthy and wealthy and dead.
>                 -- James Thurber
> 
