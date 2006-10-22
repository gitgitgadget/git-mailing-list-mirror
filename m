From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 08:33:36 -0500
Message-ID: <20061022133336.GT75501@over-yonder.net>
References: <1161472030.9241.174.camel@localhost.localdomain> <20061021192539.4a00cc3e.seanlkml@sympatico.ca> <1161478005.9241.210.camel@localhost.localdomain> <20061021212645.2f9ba751.seanlkml@sympatico.ca> <1161487417.9241.220.camel@localhost.localdomain> <20061021233014.d4525a1d.seanlkml@sympatico.ca> <20061022100028.GQ75501@over-yonder.net> <20061022074422.50dcbee6.seanlkml@sympatico.ca> <20061022130322.GS75501@over-yonder.net> <20061022092845.233deb43.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 15:33:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbdSV-0005oB-FO
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWJVNdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 09:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWJVNdj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:33:39 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:41975 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1750910AbWJVNdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 09:33:38 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 7C55128432;
	Sun, 22 Oct 2006 08:33:37 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id E35CC61C52; Sun, 22 Oct 2006 08:33:36 -0500 (CDT)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20061022092845.233deb43.seanlkml@sympatico.ca>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29744>

On Sun, Oct 22, 2006 at 09:28:45AM -0400 I heard the voice of
Sean, and lo! it spake thus:
> 
> Sure, but if they're just a local feature then why propagate them
> with the distributed data?

Because they're 'local' to a given "branch"; see my message to cworth
a little while ago for expansion of the rather particular meaning of
the word used here.  If somebody takes a clone of my _branch_, it's
the same "branch", so the numbers will be the same (and that's
desired).


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
