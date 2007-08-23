From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 14:06:33 -0400
Message-ID: <20070823180633.GA24530@filer.fsl.cs.sunysb.edu>
References: <20070823092254.GA5976@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 20:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOH5J-0006P2-GN
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 20:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759797AbXHWSGj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 14:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759618AbXHWSGi
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 14:06:38 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44680 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759442AbXHWSGi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 14:06:38 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l7NI6XWg001250;
	Thu, 23 Aug 2007 14:06:33 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l7NI6Xhf001248;
	Thu, 23 Aug 2007 14:06:33 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <20070823092254.GA5976@kroah.com>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56510>

On Thu, Aug 23, 2007 at 02:22:54AM -0700, Greg KH wrote:
> Hi,
> 
> I wanted to see if I could start using stgit instead of quilt, so I
> tried to import my current set of kernel patches.
 
May I suggest you give guilt [1,2] a spin? It uses the same quilt-like
patch directory format so things should Just Work(tm).

Josef 'Jeff' Sipek.

[1] http://kernel.org/pub/linux/kernel/people/jsipek/guilt/
[2] git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git

-- 
You measure democracy by the freedom it gives its dissidents, not the
freedom it gives its assimilated conformists.
		- Abbie Hoffman
