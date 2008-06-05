From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Patches for some OS's.
Date: Thu, 5 Jun 2008 12:49:07 -0600
Message-ID: <Pine.LNX.4.64.0806051240550.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806051114260.18454@xenau.zenez.com>
 <alpine.DEB.1.00.0806051935540.21190@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4KXJ-0002kE-0S
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbYFEStQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 14:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbYFEStQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:49:16 -0400
Received: from zenez.com ([166.70.62.2]:27352 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754192AbYFEStP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 14:49:15 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 2ED9BE4839; Thu,  5 Jun 2008 12:49:07 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id DFCC8E4838;
	Thu,  5 Jun 2008 12:49:07 -0600 (MDT)
In-Reply-To: <alpine.DEB.1.00.0806051935540.21190@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83957>

On Thu, 5 Jun 2008, Johannes Schindelin wrote:
> On Thu, 5 Jun 2008, Boyd Lynn Gerber wrote:
> > I have attached the patches necessary to use GIT on some Non Linux OS's.
>
> One might think that you could now use Git to generate the patches, and
> follow the conventions to submit them...

I should have.  I am just now cloning the git tree.  Once I get a my clone
I will create a working copy and make the patches to it.

> For example, reviewing attached patches makes it unduly hard on the
> reviewers.
>
> For example, you do not have any explanation AKA commit message.
>
> For example, you use context diffs.
>
> See Documentation/SubmittingPatches for more hints how to get your
> patches integrated.

I just found on the website the proper way to submit patches.  I will
follow it.  I just have been submitting patches to to many differt version
control systems.  I have to submit patches to cvs, svn, hg and git.  I
have a hard time remembering which source tree is what.  I have just now
created my

/master/src/cvs
/master/src/git
/master/src/hg
/master/src/svn
/working/src/cvs
/working/src/git
/working/src/hg
/working/src/svn

I am moving things to these directories.  This will allow me to know which
tools to use for each type of version control.  I also still have SCCS and
RCS repos as well.  I really wish we could get the industry to standardize
on git.  But that will be a while.

Sorry, I did not follow the proper method, for submittal.  I did not even
know there was one when I submitted the patches. I will do them that way
once I finish my migration above.


--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
