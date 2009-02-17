From: Martin Mares <mj@ucw.cz>
Subject: Re: send-email sending shallow threads by default
Date: Tue, 17 Feb 2009 10:06:18 +0100
Message-ID: <mj+md-20090217.090514.32275.nikam@ucw.cz>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <20090216000732.GC3503@coredump.intra.peff.net> <mj+md-20090216.103512.5791.nikam@ucw.cz> <499A769B.2080308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 17 10:08:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZLvq-0006ag-Pc
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 10:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbZBQJGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 04:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbZBQJGX
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 04:06:23 -0500
Received: from nikam-dmz.ms.mff.cuni.cz ([195.113.20.16]:59579 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751031AbZBQJGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 04:06:22 -0500
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 8A7BA153607; Tue, 17 Feb 2009 10:06:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <499A769B.2080308@op5.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110341>

Hello, world!\n

> There's no need to have the date field be set to the time the mails were
> actually sent though. AFAIR, they get the AUTHOR_DATE now, and I doubt more
> than one commit can be authored every second.

Is it really so?  Last time I have used git send-email, they got the current
date. It was in Git 1.5.5, though, so it is possible that it has changed since
then.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"All that is necessary for the triumph of evil is that good men do nothing." -- E. Burke
