From: Scott Parish <sRp@srparish.net>
Subject: intended use of "git --exec-path"?
Date: Tue, 23 Oct 2007 21:32:24 -0700
Message-ID: <20071024043224.GR16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 06:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkXv0-0004cN-6O
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 06:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbXJXEcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 00:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXJXEcX
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 00:32:23 -0400
Received: from smtp-gw7.mailanyone.net ([208.70.128.55]:42185 "EHLO
	smtp-gw7.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbXJXEcW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 00:32:22 -0400
Received: from mailanyone.net
	by smtp-gw7.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP quinn@srparish.net)
	id 1IkXun-0003tQ-IC
	for git@vger.kernel.org; Tue, 23 Oct 2007 23:32:21 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Tue, 23 Oct 2007 21:32:25 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62187>

"git --exec-path" presently prints out the highest priority path
to find executable in. That's a what; i'm curious why and when it
should be used. Basically i'm wondering if its still useful, and
what, if anything, it should be printing.

Thanks
sRp

-- 
Scott Parish
http://srparish.net/
