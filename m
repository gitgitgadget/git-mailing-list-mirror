From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Starting to think about sha-256?
Date: Sun, 27 Aug 2006 22:30:12 +0200
Message-ID: <m31wr1exbf.fsf@defiant.localdomain>
References: <44F1DCB7.6020804@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 27 22:30:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHRH3-0000d1-UW
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 22:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWH0UaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 16:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWH0UaQ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 16:30:16 -0400
Received: from khc.piap.pl ([195.187.100.11]:28640 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751123AbWH0UaP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 16:30:15 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 2E1BF10811; Sun, 27 Aug 2006 22:30:13 +0200 (CEST)
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <44F1DCB7.6020804@garzik.org> (Jeff Garzik's message of "Sun, 27 Aug 2006 13:56:07 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26111>

Jeff Garzik <jeff@garzik.org> writes:

> Downsides to sha-256:
> * git protocol/storage format change implications.

The only which really matters, I think.

> Maybe sha-256 could be considered for the next major-rev of git?

Not sure, but _if_ we want it we should do it sooner rather than
later.
-- 
Krzysztof Halasa
