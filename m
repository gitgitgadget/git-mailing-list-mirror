From: Jeff Garzik <jeff@garzik.org>
Subject: git daemon request logging?
Date: Fri, 15 May 2009 15:39:12 -0400
Message-ID: <4A0DC4E0.7020001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 15 21:39:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M53Fa-0000Kj-U5
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbZEOTjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 15:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbZEOTjN
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:39:13 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50226 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258AbZEOTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 15:39:12 -0400
Received: from cpe-069-134-158-197.nc.res.rr.com ([69.134.158.197] helo=bd.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1M53FR-0007Og-CO
	for git@vger.kernel.org; Fri, 15 May 2009 19:39:13 +0000
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119288>

Does the git daemon do any sort of request logging?  Could it?

I was thinking it would be nice to see the amount of pulls/clones for 
each git.kernel.org repository.

	Jeff
