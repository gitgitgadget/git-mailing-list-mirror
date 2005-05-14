From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: gitweb wishlist
Date: Sat, 14 May 2005 12:54:57 +0200
Message-ID: <20050514105457.GA21705@diku.dk>
References: <20050511012626.GL26384@pasky.ji.cz> <1116038598.9317.22.camel@dhcp-188.off.vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 12:56:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWuJ5-0000aV-9e
	for gcvg-git@gmane.org; Sat, 14 May 2005 12:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVENKzO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 06:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbVENKzO
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 06:55:14 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:20945 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262716AbVENKzB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 06:55:01 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 67E236E182E; Sat, 14 May 2005 12:54:49 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 2D4C56E1809; Sat, 14 May 2005 12:54:49 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 7792C61FDE; Sat, 14 May 2005 12:54:57 +0200 (CEST)
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <1116038598.9317.22.camel@dhcp-188.off.vrfy.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Kay Sievers <kay.sievers@vrfy.org> wrote Sat, May 14, 2005:
> On Wed, 2005-05-11 at 03:26 +0200, Petr Baudis wrote:
> >   I would be very happy if you could extend the gitweb scripts a little.
> > Basically, what I need is to have ability to create a permanent link to
> > a given file in the repository, which stays same across revisions (as
> > long as the file stays with the given name, obviously).
> > 
> >   E.g. I would like to have something like
> > 
> > 	http://www.kernel.org/git/gitweb.cgi?p=cogito%2Fcogito.git;n=contrib/ciabot.pl
> > 
> > for file contrib/ciabot.pl in the latest Cogito tree, and
> 
> http://www.kernel.org/git/gitweb.cgi?p=cogito/cogito.git;a=blob;f=contrib/ciabot.pl

How about support for getting the 'raw' files and diffs without all the
HTML markup?

-- 
Jonas Fonseca
