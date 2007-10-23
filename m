From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk patch collection pull request
Date: Wed, 24 Oct 2007 09:37:50 +1000
Message-ID: <18206.34254.741787.255299@cargo.ozlabs.ibm.com>
References: <20071019052823.GI14735@spearce.org>
	<alpine.LFD.0.999.0710191227340.26902@woody.linux-foundation.org>
	<18201.34779.27836.531742@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710192149020.3794@woody.linux-foundation.org>
	<18205.15967.792413.775786@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710231214150.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 01:38:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkTKJ-0006ZR-NM
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 01:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbXJWXiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 19:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbXJWXiL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 19:38:11 -0400
Received: from ozlabs.org ([203.10.76.45]:54134 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597AbXJWXiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 19:38:10 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 33555DDEE0; Wed, 24 Oct 2007 09:38:09 +1000 (EST)
In-Reply-To: <alpine.LFD.0.999.0710231214150.30120@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62169>

Linus Torvalds writes:

> Ok, the diff looks fine, but now the "list of files" pane on the right is 
> empty. 

Really?  It looks OK here - that is, it lists the names of the files
whose diffs are shown on the left, i.e. the files modified by the
commit that are within the path limit.

Is it completely empty, or does it have just the "Comments" entry at
the top?

Can you give me an example of a gitk command line that shows the
problem on the kernel tree?

Paul.
