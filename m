From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH 1/1] Guilt: Added an uninstall target - uninstall in git?
Date: Mon, 5 Mar 2007 22:47:55 -0500
Message-ID: <20070306034755.GA15701@filer.fsl.cs.sunysb.edu>
References: <1173151869.4877.15.camel@gandalf.dcc.usm.my>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nur Hussein <hussein@cs.usm.my>
X-From: git-owner@vger.kernel.org Tue Mar 06 04:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOQf4-0007NX-Oe
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 04:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933912AbXCFDsT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 22:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933913AbXCFDsT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 22:48:19 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:36855 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933912AbXCFDsS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 22:48:18 -0500
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l263ltTC016174;
	Mon, 5 Mar 2007 22:47:55 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l263lthl016172;
	Mon, 5 Mar 2007 22:47:55 -0500
Content-Disposition: inline
In-Reply-To: <1173151869.4877.15.camel@gandalf.dcc.usm.my>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41534>

On Tue, Mar 06, 2007 at 11:31:09AM +0800, Nur Hussein wrote:
> Invoking make uninstall will remove guilt files from installed directory.
 
I glanced at git to see what it does with respect to uninstall, and unless I
completely missed it, it just doesn't support it. Is there any reason for
that? Maybe a similar patch to git would be in order?

And yes, I do understand that once you install git, there's no way you'd
want to uninstall it :)

Josef "Jeff" Sipek.

-- 
The reasonable man adapts himself to the world; the unreasonable one
persists in trying to adapt the world to himself. Therefore all progress
depends on the unreasonable man.
		- George Bernard Shaw
