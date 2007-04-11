From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Fix handling of diappeared files on update
Date: Wed, 11 Apr 2007 14:09:45 -0700
Message-ID: <7v6482obxi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704111158220.27922@iabervon.org>
	<11763238991005-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbk4c-0007xf-Ee
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 23:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbXDKVJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbXDKVJr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 17:09:47 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39936 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbXDKVJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 17:09:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411210947.FYGH1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 17:09:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lx9l1W00i1kojtg0000000; Wed, 11 Apr 2007 17:09:46 -0400
In-Reply-To: <11763238991005-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Wed, 11 Apr 2007 22:38:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44257>

Thanks.
