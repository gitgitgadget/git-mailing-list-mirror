From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: [PATCH] Start conforming code to "git subcmd" style
Date: Sun, 31 Aug 2008 19:37:51 +0300
Message-ID: <20080831163751.GB28666@jolt.modeemi.cs.tut.fi>
References: <20080830111253.GA9148@zakalwe.fi> <7vwshyfctu.fsf@gitster.siamese.dyndns.org> <m38wudr0mq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 18:39:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZpxv-0005Ek-O3
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 18:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbYHaQia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 12:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYHaQia
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 12:38:30 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:48492 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752891AbYHaQi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 12:38:29 -0400
Received: from amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70])
	by mail.cs.tut.fi (Postfix) with ESMTP id B8A9A2D84;
	Sun, 31 Aug 2008 19:38:26 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70]) (amavisd-maia, port 10024)
 with ESMTP id 12821-11-2; Sun, 31 Aug 2008 19:38:25 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 665AE2D7F;
	Sun, 31 Aug 2008 19:38:23 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id 4F31E22200;
	Sun, 31 Aug 2008 19:37:53 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id 9A56C505EC; Sun, 31 Aug 2008 19:37:52 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <m38wudr0mq.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94493>

On Sun, Aug 31, 2008 at 02:32:05AM -0700, Jakub Narebski wrote:
> Either "git-rev-list" or "'git rev-list'" is fine; "git rev-list"
> is not, as it requires careful reading to notice which part is
> proposed git command, and which the rest of message.

I would go for "'git rev-list'". I'll use that form in coming patches, 
unless there is resistance to this idea.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
