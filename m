From: jdl@freescale.com
Subject: Re: Should Cogito scripts be renamed?
Date: Thu, 15 Sep 2005 19:07:04 -0500
Message-ID: <E1EG3ku-0005hU-Eb@jdl.com>
References: <20050915234607.GA10867@pasky.or.cz>
X-From: git-owner@vger.kernel.org Fri Sep 16 02:07:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG3lG-0003z0-KK
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 02:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVIPAHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 20:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbVIPAHP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 20:07:15 -0400
Received: from colo.jdl.com ([66.118.10.122]:20362 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751218AbVIPAHO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 20:07:14 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EG3ku-0005hU-Eb
	for git@vger.kernel.org; Thu, 15 Sep 2005 19:07:05 -0500
To: git@vger.kernel.org
In-Reply-To: <20050915234607.GA10867@pasky.or.cz>
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8653>

So, like, the other day Petr asked:
>  I'd like to hear the opinion of Cogito users about renaming the Cogito
> commands accordingly to the GIT big renames. This would be:
>
>	cg-pull -> cg-fetch
>	cg-update -> cg-pull

It took me a good long while of confusion before I
realized that cg and git were inconsistent in their
command names and meanings here.  It was the source
of Head Scratching and Not Understanding.

I am firmly of the opinion that CG should either rename 
these commands to be more consistent with GIT, or else
make up totally new, different names unrelated to git
entirely.  The reuse of "pull" alone will be, IMO, a
constant source of documentation and explanation headaches.

As with git, sooner rather than later, please.

jdl
