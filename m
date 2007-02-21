From: Michael Hendricks <michael@ndrix.org>
Subject: removing content from git history
Date: Wed, 21 Feb 2007 09:45:27 -0700
Message-ID: <20070221164527.GA8513@ginosko.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 21 17:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJubZ-0006MK-Ja
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 17:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbXBUQqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 11:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbXBUQqG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 11:46:06 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:47199 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422669AbXBUQqD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Feb 2007 11:46:03 -0500
Received: from out1.internal (unknown [10.202.2.149])
	by out1.messagingengine.com (Postfix) with ESMTP id E53F91C0686
	for <git@vger.kernel.org>; Wed, 21 Feb 2007 11:46:45 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by out1.internal (MEProxy); Wed, 21 Feb 2007 11:46:45 -0500
X-Sasl-enc: 8JatmxzyBShJTQON3teyv9PprcKsbtGopqJWe2VuP1QM 1172076405
Received: from tameion.ndrix.org (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id 6CD332D7D8
	for <git@vger.kernel.org>; Wed, 21 Feb 2007 11:46:45 -0500 (EST)
Received: from [10.10.9.99] (helo=localhost)
	by tameion.ndrix.org with esmtp (Exim 4.63)
	(envelope-from <michael@ndrix.org>)
	id 1HJuau-0007nm-0N
	for git@vger.kernel.org; Wed, 21 Feb 2007 09:45:28 -0700
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40302>

I assume that this question has already been addressed on the mailing
list, but I wasn't able to find anything about it in the archives.

Is it possible to remove content entirely from git's history?  I have a
client who does not use git for version control.  A couple months ago
they committed some sensitive client information which should never have
been committed.  Recently, they realized the mistake and now want to
remove all traces of the mistake from history.

I would like to migrate them to git at some point.  However, if they had
been using git for version control already, I'm not sure how I would
solved this particular problem.  Any suggestions?

-- 
Michael
