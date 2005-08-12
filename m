From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [OT?] git tools at SourceForge ?
Date: Sat, 13 Aug 2005 11:01:53 +1200
Message-ID: <46a038f905081216013941b2c@mail.gmail.com>
References: <20050812210611.GF13550@birddog.com>
	 <20050812220120.EF075353AED@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Kirby C. Bohling" <kbohling@birddog.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 01:02:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3iXO-0001tT-9X
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 01:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVHLXBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 19:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVHLXBy
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 19:01:54 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:13069 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751301AbVHLXBy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 19:01:54 -0400
Received: by rproxy.gmail.com with SMTP id i8so524875rne
        for <git@vger.kernel.org>; Fri, 12 Aug 2005 16:01:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=liaRzSI0uD6QWUuVBRwioIASwSnvzpp26t3a1pCPxI4fwIv4/7aC0lqaHpD8ZVpNhFc0jeAghzZRqCXeX+wGDsgvXbSZb1LqvfACdpUQpvJbnKYYiOwkI/PBfo0g33AX5Vwd1GPnxA6JMUht6bUgOiJdwLr0juFXy1/jeSdWRrU=
Received: by 10.39.2.8 with SMTP id e8mr1171868rni;
        Fri, 12 Aug 2005 16:01:53 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 12 Aug 2005 16:01:53 -0700 (PDT)
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050812220120.EF075353AED@atlas.denx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > I don't think he wants sourceforge to host git, I think he'd like
> > sourceforge to provide access to source trees via git, instead of
> > cvs.  Read that as, I want to do:
> 
> Correct, that's what I am looking for. My  hope  is  that  if  enough
> people ask SF might actually provide such a service.

Ubuntu's 'launchpad' project is trying to do that (a SCM 'proxy' of
sorts) with Arch/Bazaar/BazaarNG/Whatever. It takes massive ammounts
of diskpace and computing power to be tracking external cvs/svn repos
in your SCM format of choice. The talked abundantly about this at the
last Debconf in nightless helsinki.

I know I will be running GIT public repos that mirror CVS repos of a
few large-ish projects I work on a lot, and are starting to strain
CVS's ability to coordinate work. I am keen on starting a Wiki on
'git/cogito' techniques and usage strategies, and my first entry is
going to be about how to track an external project this way.

cheers,


martin
