From: James Morris <jmorris@namei.org>
Subject: Re: linux-next: manual merge of the security-testing tree with the
  tree
Date: Thu, 30 Jun 2011 15:22:33 +1000 (EST)
Message-ID: <alpine.LRH.2.00.1106301518430.13767@tundra.namei.org>
References: <20110630142910.2fea4257.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@vger.kernel.org, Linus <torvalds@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-From: git-owner@vger.kernel.org Thu Jun 30 07:22:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc9iC-0007Ph-V6
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 07:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab1F3FWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 01:22:45 -0400
Received: from tundra.namei.org ([65.99.196.166]:48814 "EHLO tundra.namei.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab1F3FWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 01:22:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by tundra.namei.org (8.13.1/8.13.1) with ESMTP id p5U5MXMJ014070;
	Thu, 30 Jun 2011 01:22:33 -0400
In-Reply-To: <20110630142910.2fea4257.sfr@canb.auug.org.au>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176475>

On Thu, 30 Jun 2011, Stephen Rothwell wrote:

> I cannot merge commit bcd05ca10420 ("Merge branch 'for-security' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jj/apparmor-dev into next")
> which is the child of the above two commits.

Actually, I may have accidentally pulled upstream commits in via the 
above.  I'll rebase my tree to the TOMOYO merge.


- James
-- 
James Morris
<jmorris@namei.org>
