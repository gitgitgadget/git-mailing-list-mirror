From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH/RFC] git-cvsserver: Add a basic test file for cvsserver
Date: Tue, 1 May 2007 13:29:43 +0200
Message-ID: <20070501112943.GP7085@planck.djpig.de>
References: <11778774271937-git-send-email-frank@lichtenheld.de> <7vfy6h7wsb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 13:39:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiqhJ-00079i-6y
	for gcvg-git@gmane.org; Tue, 01 May 2007 13:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbXEALiq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 07:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754389AbXEALiq
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 07:38:46 -0400
Received: from planck.djpig.de ([85.10.192.180]:1631 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754296AbXEALiq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 07:38:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id EFC3B88003;
	Tue,  1 May 2007 13:38:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EuSOQqZdUFHP; Tue,  1 May 2007 13:37:16 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id AE6FF8803C; Tue,  1 May 2007 13:29:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vfy6h7wsb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45942>

On Tue, May 01, 2007 at 01:50:12AM -0700, Junio C Hamano wrote:
> But a git-cvsserver test suite that can be run from "make test"
> is a really good thing to have for us.
> 
> I haven't pursued this but have you considered :fork: connect
> method instead of :ext:, so that you do not have to use pserver
> nor ssh connection?

Ok, I have to confess I never heard of :fork: before :| (or forgot about
it again)
Thanks for the tip...

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
