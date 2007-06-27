From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Avoid perl in t1300-repo-config
Date: Wed, 27 Jun 2007 17:15:46 +0200
Message-ID: <20070627151545.GF12721@planck.djpig.de>
References: <81b0412b0706270545w65ca2556yaafaac6ff31b5961@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 17:15:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3ZFM-0003kN-FR
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 17:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbXF0PPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 11:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbXF0PPz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 11:15:55 -0400
Received: from planck.djpig.de ([85.10.192.180]:3509 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546AbXF0PPy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 11:15:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 6A2C088105;
	Wed, 27 Jun 2007 17:15:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t3yFAVvyurCt; Wed, 27 Jun 2007 17:15:46 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 50D2E881B6; Wed, 27 Jun 2007 17:15:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0706270545w65ca2556yaafaac6ff31b5961@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51050>

On Wed, Jun 27, 2007 at 02:45:40PM +0200, Alex Riesen wrote:
> It fixes the test on system where ActiveState Perl is used.
> It is also shorter.

Thanks :)

For future reference: What in my code broke with ActiveState Perl?
The command line options?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
