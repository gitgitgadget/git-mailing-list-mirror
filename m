From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: pushing to a remote branch that one does not own
Date: Wed, 19 Jan 2011 19:56:30 +0000 (UTC)
Message-ID: <loom.20110119T205035-308@post.gmane.org>
References: <1295461011273-5940751.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 19 20:57:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfe9M-00064g-VG
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082Ab1AST4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:56:50 -0500
Received: from lo.gmane.org ([80.91.229.12]:55443 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997Ab1AST4t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 14:56:49 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pfe93-0005u7-Hr
	for git@vger.kernel.org; Wed, 19 Jan 2011 20:56:41 +0100
Received: from ppp85-140-55-104.pppoe.mtu-net.ru ([85.140.55.104])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 20:56:41 +0100
Received: from zapped by ppp85-140-55-104.pppoe.mtu-net.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 20:56:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.140.55.104 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.237 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165290>

> Am I strictly limited to committing only on the master / origin/master
> branched, and forced to make a new branch for every branch that I cloned
> from the remote repo, or is there a way of making the heads of the remote
> branches visible as local too? 
> 
> Thanks, 
> 
> Iannis Zannos
> 

Maybe you should read "Pro Git" book chapter 3 "Git Branching"
http://progit.org/book/ch3-0.html
(and look forward for chapter 3.5 "Remote Branches")?
