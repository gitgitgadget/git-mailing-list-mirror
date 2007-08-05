From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Problem with bisect
Date: Sun, 5 Aug 2007 21:44:54 +0200
Message-ID: <20070805194454.GI25680@cip.informatik.uni-erlangen.de>
References: <46B5F48D.7020907@lwfinger.net> <20070805145234.554bf671.seanlkml@sympatico.ca> <46B623D6.7070809@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Larry Finger <larry.finger@lwfinger.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHm27-0005we-1J
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444AbXHETo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755395AbXHETo4
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:44:56 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55655 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755444AbXHETo4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 15:44:56 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 0C6FC3F415; Sun,  5 Aug 2007 21:44:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46B623D6.7070809@lwfinger.net>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55062>

Hello,

> I'm using git version 1.4.4.2.g04509

1.4 has a issue with bisect at least the Debian 1.4 versio. Update to
1.5 and try again.

        Thomas
