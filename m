From: Jon Loeliger <jdl@freescale.com>
Subject: Now What?
Date: Wed, 02 Nov 2005 19:30:37 -0600
Message-ID: <E1EXTw5-00063o-Gt@jdl.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 02:30:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXTwD-0001nI-Fm
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 02:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVKCBam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 20:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVKCBam
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 20:30:42 -0500
Received: from www.jdl.com ([66.118.10.122]:37797 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1030243AbVKCBam (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 20:30:42 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EXTw5-00063o-Gt
	for git@vger.kernel.org; Wed, 02 Nov 2005 19:30:38 -0600
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11062>


The Other Day, I offered to help write up some parts of
a "Something weird just happened.  Now What?" document.

So, I'm now soliciting suggestions and/or tips that can
be thrown together to form the basis of that document.

I have a few ideas and a rough outline up my sleeve, but
I am curious to know what _you_ think needs to be covered.

I think one of the most crucial aspects that needs to be
covered well is the "Merge Failed" problem.  So, for starters,
I'd like to get your suggestions on this particular issue.
I know when I see the dreaded "merge by hand" message I
often sit and stare, pondering "Now what?"

I feel that an explanation of all of the behind-the-scripts-
in-.git communication files is needed.  In particular these:

    FETCH_HEAD
    MERGE_HEAD
    LAST_MERGE
    MERGE_MSG

These need to be mentioned and explained because they
frequently form exactly the critical missing link or
starting point after a failed fetch or merge.

Finally, a procedure or style question.  Should this
write-up be in the form of a structured FAQ?  A stand-alone
expository document?

Thanks,
jdl
