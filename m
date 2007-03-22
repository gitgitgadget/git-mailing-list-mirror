From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Wed, 21 Mar 2007 22:09:34 -0700
Message-ID: <7vd531yicx.fsf@assigned-by-dhcp.cox.net>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322043604.GA6303@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Mar 22 06:10:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUFYt-0000RD-Im
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 06:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965748AbXCVFJg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 01:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965741AbXCVFJg
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 01:09:36 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:42251 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965737AbXCVFJf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 01:09:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322050935.NXSW321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 22 Mar 2007 01:09:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dh9a1W00M1kojtg0000000; Thu, 22 Mar 2007 01:09:34 -0400
In-Reply-To: <20070322043604.GA6303@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 22 Mar 2007 07:02:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42838>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> Quoting Junio C Hamano <junkio@cox.net>:
>> Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
>> 
>> Would "Hi!" and "Would the following be appropriate?" be part of
>> the final commit log message?
>
> Sigh. I wish there was a way to tell git-am "ignore text *before* this line"
> just like --- means ignore text after this line.

Well, I'd sigh back.  I wish people imitated good examples, such as:

Message-ID: <Pine.LNX.4.63.0703220240590.4045@wbgn013.biozentrum.uni-wuerzburg.de>

which is not too hard to follow.
