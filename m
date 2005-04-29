From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 22:46:49 -0400
Message-ID: <20050429024649.GB11692@delft.aura.cs.cmu.edu>
References: <42703E79.8050808@zytor.com> <1114673723.12012.324.camel@baythorne.infradead.org> <20050428081005.GG8612@pasky.ji.cz> <1114676955.12012.346.camel@baythorne.infradead.org> <1114680199.12012.363.camel@baythorne.infradead.org> <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org> <1114723214.2734.9.camel@localhost.localdomain> <42715B30.6010705@zytor.com> <1114726373.2734.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 29 04:41:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRLRX-00020U-FC
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 04:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVD2Cqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 22:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVD2Cqy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 22:46:54 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:54665 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261428AbVD2Cqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 22:46:53 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DRLWj-0003A2-00
	for <git@vger.kernel.org>; Thu, 28 Apr 2005 22:46:49 -0400
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1114726373.2734.47.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2005 at 11:12:52PM +0100, David Woodhouse wrote:
> You might perhaps attempt to find a path through the graph which takes
> in as many commits as possible where committer == `logname`@`hostname`
> -- but as Linus and I already said, that's expensive.
> 
> I'm not entirely sure what the answer is; but it isn't parent ordering
> and it isn't dates.

Perhaps a lamport clock?

Jan
