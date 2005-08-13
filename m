From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [OT?] git tools at SourceForge ?
Date: Fri, 12 Aug 2005 21:16:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508122046370.12816@iabervon.org>
References: <20050812190739.AC222352633@atlas.denx.de> 
 <Pine.LNX.4.63.0508121634570.12816@iabervon.org>  <Pine.LNX.4.58.0508121513530.3295@g5.osdl.org>
 <46a038f90508121617560d00c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 03:13:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3kah-000582-IU
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 03:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVHMBNe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 21:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbVHMBNe
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 21:13:34 -0400
Received: from iabervon.org ([66.92.72.58]:11018 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750811AbVHMBNd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 21:13:33 -0400
Received: (qmail 26268 invoked by uid 1000); 12 Aug 2005 21:16:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Aug 2005 21:16:48 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90508121617560d00c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 13 Aug 2005, Martin Langhoff wrote:

> >    Yes, developers can just merge with each other directly
> 
> I take it that you mean an exchange of patches that does not depend on
> having public repos. What are the mechanisms available on that front,
> other than patchbombs?

If each developer has a trivial web server, they can put their output 
there, and everyone else can pull from it, because it only needs to serve 
static files out of a directory structure that the programs create 
regularly. Of course, this is only strictly different from a public repo 
in that you don't advertize it beyond the other developers. But it's a 
within-system equivalent to posting a link to a web-hosted patch set, 
which people sometimes do to pass things around.

> > And so I'd be thrilled to have some site like SF support it.
> 
> Eduforge's charter is to host education-related projects, so that's
> not a free-for-all-comers, but I'm considering git support, as our
> usage of git is growing.

If you contribe the git support to gforge, presumably similar hosting 
sites will pick it up before too long.

	-Daniel
*This .sig left intentionally blank*
