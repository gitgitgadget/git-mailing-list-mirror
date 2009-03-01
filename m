From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk endless loop
Date: Mon, 2 Mar 2009 09:48:45 +1100
Message-ID: <18859.4301.651796.42262@cargo.ozlabs.ibm.com>
References: <4992B5DE.3010207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 23:50:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LduUM-0002jY-4o
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 23:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758485AbZCAWs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 17:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758458AbZCAWsz
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 17:48:55 -0500
Received: from bilbo.ozlabs.org ([203.10.76.25]:35404 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758425AbZCAWsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 17:48:54 -0500
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 61360B7066; Mon,  2 Mar 2009 09:48:52 +1100 (EST)
In-Reply-To: <4992B5DE.3010207@viscovery.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111894>

Johannes Sixt writes:

> This recipe sends gitk into an endless loop. In git.git do:

I just pushed out a fix.  Thanks for the recipe for reproducing the
problem.

Paul.
