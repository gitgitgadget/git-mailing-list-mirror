From: Martin Mares <mj@ucw.cz>
Subject: Re: send-email sending shallow threads by default
Date: Mon, 16 Feb 2009 11:38:24 +0100
Message-ID: <mj+md-20090216.103512.5791.nikam@ucw.cz>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <20090216000732.GC3503@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 12:12:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ1P4-00086P-B4
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 12:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbZBPLLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 06:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbZBPLLO
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 06:11:14 -0500
Received: from nikam-dmz.ms.mff.cuni.cz ([195.113.20.16]:44210 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750757AbZBPLLO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 06:11:14 -0500
X-Greylist: delayed 1967 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Feb 2009 06:11:14 EST
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 564131535D7; Mon, 16 Feb 2009 11:38:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090216000732.GC3503@coredump.intra.peff.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110168>

Hello, world!\n

> Is that the case? mutt at least orders by thread, but by rfc822 date
> within a single level of thread. So as long as the date fields (set by
> the sender) are correct, it looks right no matter what order they arrive in.

Actually, it matters, because the Date field has limited precision
and it frequently happens that the sender produces several mails
within a single second.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Press any key to quit or any other key to continue
