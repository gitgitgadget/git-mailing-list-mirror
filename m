From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: Is reserving the branch name "bisect" a good thing?
Date: Fri, 2 Dec 2005 23:44:07 +0000 (UTC)
Message-ID: <loom.20051203T004324-557@post.gmane.org>
References: <20051202232555.13082.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Dec 03 00:49:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiKd3-00037q-0C
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 00:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbVLBXrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 18:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVLBXrX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 18:47:23 -0500
Received: from main.gmane.org ([80.91.229.2]:5011 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751072AbVLBXrW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 18:47:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EiKb3-0002Wu-2L
	for git@vger.kernel.org; Sat, 03 Dec 2005 00:45:45 +0100
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Dec 2005 00:45:44 +0100
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Dec 2005 00:45:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13138>

 <linux <at> horizon.com> writes:

> Would it be better if "git bisect" followed that rule as well?
> Otherwise, we really should document the reserved word.

I wonder if you broke "git bisect visualize" with that patch.
