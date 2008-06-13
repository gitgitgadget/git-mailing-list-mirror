From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 21:00:26 -0700 (PDT)
Message-ID: <alpine.DEB.1.00.0806122058500.8280@alchemy.localdomain>
References: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com> <20080612185545.GN29404@genesis.frugalware.org> <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com> <alpine.LNX.1.00.0806121523370.19665@iabervon.org> <Pine.LNX.4.64.0806121348340.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806121652220.19665@iabervon.org> <Pine.LNX.4.64.0806121457490.18454@xenau.zenez.com> <alpine.LNX.1.00.0806121759300.19665@iabervon.org> <Pine.LNX.4.64.0806121615290.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 06:12:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K70eV-00029Z-2f
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 06:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbYFMELo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 00:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbYFMELo
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 00:11:44 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:48683 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750835AbYFMELo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 00:11:44 -0400
Received: from alchemy (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id DAA45A012E;
	Fri, 13 Jun 2008 00:13:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by alchemy (Postfix) with ESMTPS id 8522B6E4DA;
	Thu, 12 Jun 2008 21:00:26 -0700 (PDT)
X-X-Sender: paulproteus@alchemy.localdomain
In-Reply-To: <Pine.LNX.4.64.0806121615290.18454@xenau.zenez.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84826>

On Thu, 12 Jun 2008, Boyd Lynn Gerber wrote:

> The problem is I have over 100 projects in my /master/svn/... we use them
> to do checkouts.  I am able to check out from my /master/svn/ with svn, I
> just can not seem to get the same to work with git.

Can you type the working "svn checkout" command into an email, and paste 
that conversation into the email also?

Can you then try doing "git svn init $THAT_URL_YOU_PASSED_TO_SVN_CHECKOUT 
; git svn fetch" and paste the conversation into an email to the git list?

-- Asheesh.

-- 
Ok, I'm just uploading the new version of the kernel, v1.3.33, also
known as "the buggiest kernel ever".
 		-- Linus Torvalds
