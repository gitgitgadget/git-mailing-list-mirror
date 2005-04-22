From: Kyle Hayes <kyle@marchex.com>
Subject: Re: [patch] fixup GECOS handling
Date: Fri, 22 Apr 2005 10:58:22 -0700
Organization: Marchex Inc.
Message-ID: <1114192702.31076.428.camel@axer.marchex.com>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
	 <1114179795.29271.18.camel@nosferatu.lan>
	 <1114186599.31076.409.camel@axer.marchex.com>
	 <1114189105.29271.36.camel@nosferatu.lan>
	 <20050422171818.GE7173@pasky.ji.cz>
Reply-To: kyle@marchex.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:55:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP2M1-0000TW-8C
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 19:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVDVR6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 13:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVDVR6k
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 13:58:40 -0400
Received: from peer.sef.marchex.com ([66.150.8.204]:19730 "HELO
	nosecone.marchex.com") by vger.kernel.org with SMTP id S262089AbVDVR60
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 13:58:26 -0400
Received: (qmail 7416 invoked from network); 22 Apr 2005 17:58:23 -0000
Received: from unknown (HELO axer.marchex.com) (10.101.11.64)
  by nosecone.marchex.com with SMTP; 22 Apr 2005 17:58:23 -0000
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422171818.GE7173@pasky.ji.cz>
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-22 at 19:18 +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 22, 2005 at 06:58:25PM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > Meaning, if they use a ',' in one of the fields (and it is a linux
> > system with the chfn most probably from the shadow package), then they
> > are looking for trouble.  The only reason I added the ';' was because
> > somebody said whatever OS used it instead of a ','.
> 
> What about just swapping the two tests so that ; is cut off and , only
> when no ; is around?

Even nicer.  I like it.  Very clean!

Best,
Kyle

-- 
Kyle Hayes <kyle@marchex.com>
Marchex Inc.

