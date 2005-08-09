From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb - feature request
Date: Tue, 9 Aug 2005 23:09:48 +0200
Message-ID: <20050809210948.GA21162@vrfy.org>
References: <20050809193104.GA10858@mars.ravnborg.org> <20050809195818.GA19284@vrfy.org> <20050809201836.GA11051@mars.ravnborg.org> <Pine.LNX.4.63.0508092224580.9849@wgmdd8.biozentrum.uni-wuerzburg.de> <20050809204347.GB11132@mars.ravnborg.org> <42F91759.8010008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 23:10:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2bM9-00006n-6O
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 23:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVHIVJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 17:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVHIVJu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 17:09:50 -0400
Received: from soundwarez.org ([217.160.171.123]:58296 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S964943AbVHIVJu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 17:09:50 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id CBC6E29F53; Tue,  9 Aug 2005 23:09:48 +0200 (CEST)
To: John Benes <smartcat99s@gmail.com>
Content-Disposition: inline
In-Reply-To: <42F91759.8010008@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 09, 2005 at 03:51:37PM -0500, John Benes wrote:
> Sam Ravnborg wrote:
> >> You have Firefox, don't you? Next time you surf to gitweb, right click on 
> >> the funny yellow symbol in the lower right corner of your Firefox. It 
> >> should say something like "Subscribe to...". Do it.
> > 
> > Unfortunately not on my firefox. 1.0.6 on gentoo.
> > Puzzled...
> 
> I don't see it either with Firefox/1.0+ ID:2005080905.
> 
> For it to work, this code needs to be added to the HEAD (slightly modified)
> 
> <link rel="alternate" type="application/rss+xml" title="GIT Trees"
> href="http://www.kernel.org/git/?a=opml" />

Are you sure that firefox handles opml without a plugin?

Kay
