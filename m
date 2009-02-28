From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: make use of themed widgets where available
Date: Sat, 28 Feb 2009 13:45:18 +1100
Message-ID: <18856.42302.321781.759870@cargo.ozlabs.ibm.com>
References: <87ljrre7nr.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Feb 28 03:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdFMF-00048f-SP
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 03:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbZB1Cxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 21:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbZB1Cxw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 21:53:52 -0500
Received: from bilbo.ozlabs.org ([203.10.76.25]:52859 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbZB1Cxw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 21:53:52 -0500
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Feb 2009 21:53:51 EST
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 440E0B7068; Sat, 28 Feb 2009 13:45:24 +1100 (EST)
In-Reply-To: <87ljrre7nr.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111741>

Pat Thoyts writes:

>     This patch improves the appearence of gitk on Windows XP and Vista
>     by making use of the themed widgets that are provided in Tk 8.5
>     and above. For good Vista support 8.6 will be needed.

Wow.  It'll take me a while to digest this.  Before I start diving
into it, does gitk still work on Tk 8.4 with this patch?

Paul.
