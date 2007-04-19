From: Marcin Kasperski <Marcin.Kasperski@softax.pl>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 14:37:27 +0200
Organization: Softax
Message-ID: <1176986247.30690.37.camel@cauchy.softax.local>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <20070417104520.GB4946@moonlight.home>
	 <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
	 <200704171818.28256.andyparkins@gmail.com>
	 <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl>
	 <Pine.LNX.4.64.0704181130150.12094@racer.site>
	 <1176984208.30690.18.camel@cauchy.softax.local>
	 <Pine.LNX.4.64.0704191423130.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 19 14:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeVtH-0002ri-Dl
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 14:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993219AbXDSMhc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 08:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993223AbXDSMhb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 08:37:31 -0400
Received: from bozon2.softax.com.pl ([83.238.10.48]:44077 "EHLO
	bozon2.softax.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993219AbXDSMha (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 08:37:30 -0400
Received: from bozon2.softax.pl (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 845F4DC00A;
	Thu, 19 Apr 2007 14:37:29 +0200 (CEST)
Received: from 127.0.0.1 (127.0.0.1)
 by bozon2.softax.pl (F-Secure/fsigk_smtp/488/bozon2.softax.pl);
 Thu, 19 Apr 2007 14:37:29 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/488/bozon2.softax.pl)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bozon2.softax.com.pl (Postfix) with ESMTP id 7834ADC007;
	Thu, 19 Apr 2007 14:37:29 +0200 (CEST)
Received: from bozon2.softax.com.pl ([127.0.0.1])
 by localhost (bozon2.softax.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04734-07; Thu, 19 Apr 2007 14:37:27 +0200 (CEST)
Received: from cauchy.softax.local (unknown [16.193.144.107])
	by bozon2.softax.com.pl (Postfix) with ESMTP id C7711DC006;
	Thu, 19 Apr 2007 14:37:27 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0704191423130.8822@racer.site>
X-Mailer: Evolution 2.6.3 
X-Virus-Scanned: amavisd-new at softax.pl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45011>

(I am not trying to make flame-war, so I restrict to 

> > He he, I even downloaded minGW version, just to find that git-pull is 
> > bash script...
> 
> So what? Do you think a Python program is a native Windows application?

Who cares... Mercurial binary build distributes hg as .exe (made by
py2exe or some other converter). The net point is that when I type 'hg'
in windows console, I get running mercurial. When I type 'git-pull' I
get error.

> > That's double edged sword. The more useful shell scripts, the more 
> > unportable tool.
> 
> Wrong.
> 
> Wrong, wrong, wrong. Shell runs on more machines than Python, for example. 
> And if you do not use things like bash arrays, scripts are _perfectly_ 
> portable.

Hmm. At the moment I am using more or less frequently: Debian Linux,
Tru64 Unix, OpenVMS, Windows XP. Python works well on all of those.
Shell scripts work on the first one and partially on the second one.

(yesss, I tried using Cygwin, this is NOT the way to go)
