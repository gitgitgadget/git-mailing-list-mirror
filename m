From: Peter Shenkin <shenkin@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Sat, 1 Oct 2011 05:40:02 +0000 (UTC)
Message-ID: <loom.20111001T073652-884@post.gmane.org>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com> <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com> <119711285.RuumktFLOq@hyperion> <loom.20110930T041939-332@post.gmane.org> <CAMOZ1BsTKBPArRF-LxoNOJcQarMWx-2a2UBoVjWN-96xJ3Ad8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 07:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9sJE-0001AC-Hu
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 07:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082Ab1JAFkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 01:40:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:33076 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775Ab1JAFkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 01:40:18 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R9sJ7-00018h-3H
	for git@vger.kernel.org; Sat, 01 Oct 2011 07:40:17 +0200
Received: from h-67-101-25-249.nycmny83.dynamic.covad.net ([67.101.25.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 07:40:17 +0200
Received: from shenkin by h-67-101-25-249.nycmny83.dynamic.covad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 07:40:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.101.25.249 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.186 Safari/535.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182537>

Michael Witten <mfwitten <at> gmail.com> writes:
> Well, you're missing the fact that it not only causes those to
> be downloaded, but it also causes the defaults to be ignored,
> which is why you don't get the other stuff. You can still tell
> git to fetch anything else you want in addition.

I was no longer missing it at the time I posted. 

But that is indeed what I was missing when I first encountered 
the behavior. The purpose of posting was to point out that 
with  a very small change in the documentation,  I would not
have missed it. 

-P.
