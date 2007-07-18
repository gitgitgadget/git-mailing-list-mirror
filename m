From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Rsync fetch?
Date: Wed, 18 Jul 2007 12:37:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707181226020.14596@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 18:37:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBCWl-0001wH-Ei
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 18:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758058AbXGRQhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 12:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbXGRQhX
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 12:37:23 -0400
Received: from iabervon.org ([66.92.72.58]:3265 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754246AbXGRQhW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 12:37:22 -0400
Received: (qmail 30866 invoked by uid 1000); 18 Jul 2007 16:37:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jul 2007 16:37:21 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52879>

The only thing that's totally missing at this point from my builtin-fetch 
is rsync. Do we still care? Any takers for actually implementing it?

	-Daniel
*This .sig left intentionally blank*
