From: Jeff Garzik <jeff@garzik.org>
Subject: Minor git-archive bug
Date: Thu, 05 Apr 2007 07:27:08 -0400
Message-ID: <4614DD0C.50600@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 13:27:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZQ7r-0001nI-M3
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 13:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992504AbXDEL1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 07:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992513AbXDEL1L
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 07:27:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:53689 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992504AbXDEL1K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 07:27:10 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HZQ7R-0006Mt-8s
	for git@vger.kernel.org; Thu, 05 Apr 2007 11:27:09 +0000
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.8 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43817>

"git-archive --list" requires a git repository.  Certainly listing the 
archive formats doesn't /really/ require such things.

	Jeff
