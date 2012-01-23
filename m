From: Mathieu CLAVEL <math.clavel@gmail.com>
Subject: Re: [BUG ?] completion of stash name with git stash
Date: Mon, 23 Jan 2012 08:36:28 +0000 (UTC)
Message-ID: <loom.20120123T093453-132@post.gmane.org>
References: <loom.20120119T141601-606@post.gmane.org> <87lip3mzsz.fsf@thomas.inf.ethz.ch> <loom.20120119T172954-563@post.gmane.org> <87obtzlfuv.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 09:36:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpFOW-0002Wn-SW
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 09:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab2AWIgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 03:36:47 -0500
Received: from lo.gmane.org ([80.91.229.12]:49549 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695Ab2AWIgr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 03:36:47 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RpFOO-0002TC-Jt
	for git@vger.kernel.org; Mon, 23 Jan 2012 09:36:44 +0100
Received: from 249-137-167-83.reverse.alphalink.fr ([83.167.137.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 09:36:44 +0100
Received: from math.clavel by 249-137-167-83.reverse.alphalink.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 09:36:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.167.137.249 (Mozilla/5.0 (Windows NT 5.1; rv:9.0.1) Gecko/20100101 Firefox/9.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188979>

Thomas Rast <trast <at> student.ethz.ch> writes:


> Indeed, I compiled bash 3.1 and with that (and otherwise the same bashrc
> etc.) I can reproduce.  Ditto for 4.0-rc1, which was the newest version
> in the repository where I found the bash source[1], so I couldn't
> bisect.  Perhaps if you can hunt down something newer you could try to
> find the version where it starts working.
> 
> [1] git://gitorious.org/bash/bash.git
> 

Thanks, so it's not a git issue, but a problm with the bash version.

Regards,

Mathieu
