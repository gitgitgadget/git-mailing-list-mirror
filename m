From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 08:03:22 -0500
Message-ID: <20061022130322.GS75501@over-yonder.net>
References: <20061021130111.GL75501@over-yonder.net> <87ac3p1jn7.wl%cworth@cworth.org> <1161472030.9241.174.camel@localhost.localdomain> <20061021192539.4a00cc3e.seanlkml@sympatico.ca> <1161478005.9241.210.camel@localhost.localdomain> <20061021212645.2f9ba751.seanlkml@sympatico.ca> <1161487417.9241.220.camel@localhost.localdomain> <20061021233014.d4525a1d.seanlkml@sympatico.ca> <20061022100028.GQ75501@over-yonder.net> <20061022074422.50dcbee6.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 15:03:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbcz9-0001DY-Mk
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWJVNDY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 09:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWJVNDY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:03:24 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:25581 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1751793AbWJVNDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 09:03:24 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 349572842F;
	Sun, 22 Oct 2006 08:03:23 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id A610261C52; Sun, 22 Oct 2006 08:03:22 -0500 (CDT)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061022074422.50dcbee6.seanlkml@sympatico.ca>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29733>

On Sun, Oct 22, 2006 at 07:44:22AM -0400 I heard the voice of
Sean, and lo! it spake thus:
> 
> Bzr revnos (dotted or otherwise) can not be guaranteed to be stable
> in a truly distributed system.

Perhaps the difference is that we're making a [fine] distinction
between "useful in a truely distributed system" and "useful when
WORKING in a truely distributed system".  cworth's point back up a few
posts is good; nearly all of my use of revnos is in direct interaction
with the tool, where the revnos just came from looking at the history.
And of those uses that aren't in that class, nearly all of THOSE are
very transient.  Non-local (in time or space) stability in either of
those cases is a total non-concern.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
