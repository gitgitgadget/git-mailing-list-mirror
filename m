From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Has the git shell revert been done so master should work?
Date: Sun, 24 Aug 2008 23:34:19 -0600
Message-ID: <alpine.LNX.1.10.0808242332580.6062@xenau.zenez.com>
References: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com> <20080824173804.GA26626@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 07:35:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXUjs-0000lk-1t
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 07:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbYHYFeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 01:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbYHYFeW
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 01:34:22 -0400
Received: from zenez.com ([166.70.62.2]:23906 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755260AbYHYFeV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 01:34:21 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 1F1491223BB; Sun, 24 Aug 2008 23:34:20 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 01786122397;
	Sun, 24 Aug 2008 23:34:19 -0600 (MDT)
In-Reply-To: <20080824173804.GA26626@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93597>

On Sun, 24 Aug 2008, Jeff King wrote:
> On Sun, Aug 24, 2008 at 07:02:38AM -0600, Boyd Lynn Gerber wrote:
> > I just did a clean clone of git git and, I am still seeing failures on all 
> > platforms I made work.  Has the git shell bug been reverted?  What should 
> > I do to get this working again on the 12 platforms?  Do I need to submit a 
> > patch that reverts the patch that caused all this?
> 
> It's in 'next' but has not yet graduated to 'master'. You can try
> cherry-picking 4cfc24af into master.

I have never used cherry-pick before.  I can not seem to get the right 
incantation to get this into master to test it.  Could someone assist me 
with how to get this into master for testing?

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
