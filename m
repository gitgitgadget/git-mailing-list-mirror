From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase: unexpected conflict
Date: Thu, 08 Feb 2007 14:27:25 -0800
Message-ID: <7vk5ysz3n6.fsf@assigned-by-dhcp.cox.net>
References: <7vired64tp.fsf@assigned-by-dhcp.cox.net>
	<20070208133921.GB20183@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Feb 08 23:27:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHjs-0003de-6E
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423492AbXBHW12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423487AbXBHW12
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:27:28 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:36214 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423492AbXBHW11 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:27:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208222725.NXRW1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 17:27:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MATR1W00S1kojtg0000000; Thu, 08 Feb 2007 17:27:26 -0500
In-Reply-To: <20070208133921.GB20183@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 8 Feb 2007 15:39:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39106>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> Junio, is the following patch correct?

Looks sane to me.
