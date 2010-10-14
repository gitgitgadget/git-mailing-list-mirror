From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Thu, 14 Oct 2010 08:03:23 +0000 (UTC)
Message-ID: <loom.20101014T095743-275@post.gmane.org>
References: <loom.20101012T114900-532@post.gmane.org> <AANLkTinnYEnCwpTh45N69n73JQm=ndXH-SUJ5b1piUYv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 10:03:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Imr-0006sJ-AS
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 10:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab0JNIDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 04:03:34 -0400
Received: from lo.gmane.org ([80.91.229.12]:35566 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861Ab0JNIDc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 04:03:32 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P6Imh-0006oL-4X
	for git@vger.kernel.org; Thu, 14 Oct 2010 10:03:31 +0200
Received: from 155.56.68.217 ([155.56.68.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 10:03:31 +0200
Received: from christian.halstrick by 155.56.68.217 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 10:03:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 155.56.68.217 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.63 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159028>

Thank's a lot for all your responses. I know now how to solve my problem. I'll
definitely not going to commit my unit-test before my fix and publish that
because then I would have commits in the history where tests fail. But other
suggested solutions do work.

Still, all that sounds like workarounds for a lacking feature. Checkout content
to the worktree without altering the index. What do you think, couldn't that be
added as an option to checkout?

-- Chris
