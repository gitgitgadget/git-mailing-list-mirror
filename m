From: John Goerzen <jgoerzen@complete.org>
Subject: Re: [RFH] bug in unpack_trees
Date: Fri, 14 Mar 2008 08:09:01 -0600
Message-ID: <200803140909.02107.jgoerzen@complete.org>
References: <20080304115940.GA5260@sigill.intra.peff.net> <alpine.LFD.1.00.0803081417040.5896@woody.linux-foundation.org> <20080313140005.GA30348@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 15:10:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaAbY-0005zI-QT
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 15:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbYCNOJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 10:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbYCNOJN
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 10:09:13 -0400
Received: from gatekeeper.excelhustler.com ([69.44.136.67]:32803 "EHLO
	excelhustler.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752567AbYCNOJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 10:09:12 -0400
Received: from jgoerzen by wile.internal.excelhustler.com with local (Exim 4.68)
	(envelope-from <jgoerzen@complete.org>)
	id 1JaAak-0002a3-4A; Fri, 14 Mar 2008 09:09:02 -0500
User-Agent: KMail/1.9.7
In-Reply-To: <20080313140005.GA30348@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77227>

On Thu March 13 2008 9:00:05 am Jeff King wrote:

> John, is it possible for you to re-try that rebase and confirm that it
> works with the current master? I deleted the repo you sent me after
> narrowing the bug.

I have just tried it on the precise test case I gave you, and it looks like 
the problem has indeed been fixed.

Many thanks to all of you that have worked on this.

-- John
