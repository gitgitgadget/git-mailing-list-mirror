From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 19:16:11 +0100
Message-ID: <1152900971.3191.76.camel@pmac.infradead.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	 <200607142005.36998.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 20:16:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1SDU-0004EH-Sl
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 20:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWGNSQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 14:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbWGNSQe
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 14:16:34 -0400
Received: from canuck.infradead.org ([205.233.218.70]:41388 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1422652AbWGNSQd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 14:16:33 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1G1SDF-0003Jp-5u; Fri, 14 Jul 2006 14:16:30 -0400
To: Ingo Oeser <ioe-lkml@rameria.de>
In-Reply-To: <200607142005.36998.ioe-lkml@rameria.de>
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23904>

On Fri, 2006-07-14 at 20:05 +0200, Ingo Oeser wrote:
> Hi David,
> 
> On Friday, 14. July 2006 01:59, David Woodhouse wrote:
> > Only commits in Linus' tree which actually affect the exported result
> > should have an equivalent commit in the above tree, which means that any
> > changes which affect userspace should be clearly visible for review.
> 
> Where can I subscribe for commit messages there?

Well, they're all derived from commits in Linus' tree. I could set up
another mailing list feed script which tracks it, but I'd like to give
it a while (until I'm happy with the export scripts) first.

-- 
dwmw2
