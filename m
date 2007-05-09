From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Wed, 9 May 2007 13:36:22 -0400
Message-ID: <20070509173622.GE23778@fieldses.org>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site> <20070509031803.GA27980@fieldses.org> <7vps5azlm1.fsf@assigned-by-dhcp.cox.net> <7v4pmmzivz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 19:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlq5W-0001vb-IS
	for gcvg-git@gmane.org; Wed, 09 May 2007 19:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbXEIRg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 13:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755700AbXEIRg0
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 13:36:26 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54723 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669AbXEIRgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 13:36:25 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Hlq5O-0008OB-NM; Wed, 09 May 2007 13:36:22 -0400
Content-Disposition: inline
In-Reply-To: <7v4pmmzivz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46758>

On Tue, May 08, 2007 at 10:05:36PM -0700, Junio C Hamano wrote:
> Having said that, I do not think the patch belongs to the "git
> USER'S manual".

Well, we could remove the word "user" from the name.  There's a pretty
good continuum between users and hackers, and that's as it should be.
(Where do you document "porcelain" level stuff?)

> It is a very good introductory material for a separate "git hackers
> manual", though.

But that would be OK too, as long as we have a clear idea how we're
going to decide what goes in which manual.  No need to wait until the
whole thing's done--we could commit an initial version of it Johannes's
work and your outline and fill in the rest later.

--b.
