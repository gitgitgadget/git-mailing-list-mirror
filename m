From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fix up strtoul_ui error handling
Date: Wed, 18 Apr 2007 19:26:41 -0700
Message-ID: <7vtzvdayla.fsf@assigned-by-dhcp.cox.net>
References: <871witxicn.fsf@rho.meyering.net>
	<37ce3db845caa21ba45c15d4f829ece1@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 04:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeMMB-0003pU-Cq
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 04:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993113AbXDSC0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 22:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993114AbXDSC0n
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 22:26:43 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:39506 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993113AbXDSC0m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 22:26:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070419022642.SQQM1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 22:26:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id oqSi1W0051kojtg0000000; Wed, 18 Apr 2007 22:26:42 -0400
In-Reply-To: <37ce3db845caa21ba45c15d4f829ece1@pinky> (Andy Whitcroft's
	message of "Thu, 19 Apr 2007 03:08:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44977>

Thanks.
