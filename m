From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 22:00:04 -0500
Message-ID: <20100213030004.GA20863@cthulhu>
References: <ron1-CD3223.04030512022010@news.gmane.org>
 <4B75BD06.1010802@lsrfire.ath.cx>
 <ron1-519083.13253112022010@news.gmane.org>
 <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com>
 <ron1-62D136.13570812022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 04:00:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng8Ev-0006Q1-RE
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 04:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab0BMDAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 22:00:07 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:51935 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab0BMDAF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 22:00:05 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 688AC822215; Fri, 12 Feb 2010 22:00:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <ron1-62D136.13570812022010@news.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139772>

* Ron Garret (ron1@flownet.com) [100212 16:58]:
> That would require a separate branch for every snapshot, no?  I want 
> this to be lightweight.  It's not so much the creation of a zillion 
> branches that bothers me, but having to come up with a new name every 
> time would be a real hassle.

I like to keep a branch called 'archive' for crap that's not being actively used
anymore, but that I don't to throw away.  Like failed experiments, or top-git
branches that have been merged.  I just merge -s ours all of it into archive and
forget about it.

       --larry
