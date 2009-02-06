From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Eclipse Plugin install issue
Date: Fri, 6 Feb 2009 07:34:18 -0800
Message-ID: <20090206153418.GM26880@spearce.org>
References: <b0a3bf780902060717l653cc6dcx385aa147f606a520@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Velevitch <chris.velevitch@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 16:36:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSkG-0007dM-Dk
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbZBFPeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbZBFPeU
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:34:20 -0500
Received: from george.spearce.org ([209.20.77.23]:39629 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbZBFPeT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:34:19 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D62C238210; Fri,  6 Feb 2009 15:34:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <b0a3bf780902060717l653cc6dcx385aa147f606a520@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108735>

Chris Velevitch <chris.velevitch@gmail.com> wrote:
> I've pointed the Eclipse update manager to
> http://www.jgit.org/update-site and when try to install it, it get:-
> 
> Cannot complete the request.  See the details.
> Cannot find a solution satisfying the following requirements
> Match[requiredCapability:
> org.eclipse.equinox.p2.iu/org.spearce.egit.feature.group/[0.4.0.200901290136,0.4.0.200901290136]].
...
> The instructions didn't say there were any prerequisites.

There aren't any prerequisites beyond the base Eclipse 3.4 and
any Java 5 or later runtime.  Its very odd that the update manager
can't install EGit.
 
Robin, is there a missing JAR file on the jgit.org update site?

-- 
Shawn.
