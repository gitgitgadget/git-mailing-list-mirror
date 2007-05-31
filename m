From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig 0.7
Date: Thu, 31 May 2007 23:55:08 +0200
Message-ID: <20070531215508.GB9260@diku.dk>
References: <20070531123808.GA25719@diku.dk> <465F2731.2080707@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 00:02:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htsiw-0008Bv-0H
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 00:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbXEaWCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 18:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbXEaWCS
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 18:02:18 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:47797 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbXEaWCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 18:02:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 4438D9681A6;
	Fri,  1 Jun 2007 00:02:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jAZks62AWV1u; Fri,  1 Jun 2007 00:02:15 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 97601F0193;
	Thu, 31 May 2007 23:55:08 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3AD8F6DFD37; Thu, 31 May 2007 23:53:05 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 7CA6462A5D; Thu, 31 May 2007 23:55:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <465F2731.2080707@midwinter.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48821>

Steven Grimm <koreth@midwinter.com> wrote Thu, May 31, 2007:
> This doesn't build on OS X out of the box, FYI. It needs the following 
> tweaks (which break the build on Linux, so I'm not suggesting you apply 
> this -- looks like you might need a configure script or at least some 
> conditionals in the Makefile.) The change to tig.c cleans up a compiler 
> warning, but it does build fine without that change.

I am aware of this and your suggestion is already in the TODO file.
However, for 0.7 I ended up needing the new status view feature more
than working on fixing that.

-- 
Jonas Fonseca
