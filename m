From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [ANNOUNCE] GIT 1.5.2
Date: Sun, 20 May 2007 12:30:57 +0200
Message-ID: <20070520103057.GD5015@cip.informatik.uni-erlangen.de>
References: <7vsl9rq2u2.fsf@assigned-by-dhcp.cox.net> <20070520093732.GA5015@cip.informatik.uni-erlangen.de> <7vejlbq0gf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 12:32:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpihp-0006YK-JT
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765254AbXETKbB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 06:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759543AbXETKbB
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:31:01 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:42727 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933211AbXETKbA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2007 06:31:00 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id CF87C3F3A5; Sun, 20 May 2007 12:30:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vejlbq0gf.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47821>

Hello Junio,

> Please add $(LIBS) at the end and try again.  Sorry.

that fixes it.

        Thomas
