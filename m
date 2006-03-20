From: Paul Mackerras <paulus@samba.org>
Subject: Re: What should I use instead of git show?
Date: Mon, 20 Mar 2006 22:33:31 +1100
Message-ID: <17438.37643.583091.800359@cargo.ozlabs.ibm.com>
References: <20060313144747.GA81092@dspnet.fr.eu.org>
	<200603131717.53416.astralstorm@o2.pl>
	<20060313165015.GC87487@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Radoslaw Szkodzinski <astralstorm@o2.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 12:34:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLIeS-0003dw-1e
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 12:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWCTLeR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 06:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWCTLeQ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 06:34:16 -0500
Received: from ozlabs.org ([203.10.76.45]:11717 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750727AbWCTLeQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 06:34:16 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 55003679E9; Mon, 20 Mar 2006 22:34:15 +1100 (EST)
To: Olivier Galibert <galibert@pobox.com>
In-Reply-To: <20060313165015.GC87487@dspnet.fr.eu.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17749>

Olivier Galibert writes:

> gitk does not seem to have an export function.  Dunno about qgit.

Right-click on a commit should bring up a context menu which includes
a "write commit to file" option.  Or did you mean something different
by "export"?

Paul.
