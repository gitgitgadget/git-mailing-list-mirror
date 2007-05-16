From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv3] connect: display connection progress
Date: Wed, 16 May 2007 11:00:03 -0700
Message-ID: <7vwsz8ejj0.fsf@assigned-by-dhcp.cox.net>
References: <20070516170941.GA19449@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed May 16 20:00:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoNnL-0002g0-ML
	for gcvg-git@gmane.org; Wed, 16 May 2007 20:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760674AbXEPSAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 14:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759744AbXEPSAH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 14:00:07 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:56402 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758808AbXEPSAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 14:00:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516180004.RGQZ19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 16 May 2007 14:00:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zu041W00B1kojtg0000000; Wed, 16 May 2007 14:00:04 -0400
In-Reply-To: <20070516170941.GA19449@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 16 May 2007 20:09:41 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47446>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> Make git notify the user about host resolution/connection attempts.
> This is useful both as a progress indicator on slow links, and helps
> reassure the user there are no firewall problems.

Nicely done.  Thanks.
