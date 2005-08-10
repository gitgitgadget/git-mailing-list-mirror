From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb - feature request
Date: Wed, 10 Aug 2005 02:11:16 +0200
Message-ID: <20050810001116.GA22489@vrfy.org>
References: <20050809193104.GA10858@mars.ravnborg.org> <20050809195818.GA19284@vrfy.org> <20050809201836.GA11051@mars.ravnborg.org> <Pine.LNX.4.63.0508092224580.9849@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.58.0508091447080.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 10 02:12:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2eC3-0001A4-9j
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 02:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVHJALT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 20:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVHJALT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 20:11:19 -0400
Received: from soundwarez.org ([217.160.171.123]:39374 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750989AbVHJALS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 20:11:18 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 06835476DC; Wed, 10 Aug 2005 02:11:16 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508091447080.3258@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 09, 2005 at 02:53:58PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 9 Aug 2005, Johannes Schindelin wrote:
> > 
> > You have Firefox, don't you? Next time you surf to gitweb, right click on 
> > the funny yellow symbol in the lower right corner of your Firefox. It 
> > should say something like "Subscribe to...". Do it.
> 
> Left-click. And you need to be inside the project you want to rss (it 
> would be nice if you could be at the "projects" page and it would give you 
> a list of things to subscribe to, but that may not be possible).

Sure, it is that way. It is called OPML and I once tested it with a RSS
reader and it was able to read the list of offered feeds in with a single
request.
Just click on the RSS pict in the footer and it will return the overview
of the index page. Firefox may need a plugin to be able to read it, I don't
really know...

Kay
