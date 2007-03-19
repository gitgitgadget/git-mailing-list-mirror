From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] mergetool: Use merge.tool config option.
Date: Sun, 18 Mar 2007 21:09:29 -0700
Message-ID: <7vircxnabq.fsf@assigned-by-dhcp.cox.net>
References: <11742343911678-git-send-email-jbowes@dangerouslyinc.com>
	<7vwt1em6gf.fsf@assigned-by-dhcp.cox.net>
	<3f80363f0703181811x54acb3f4n689f4fd68f5a5dbe@mail.gmail.com>
	<20070319023238.GC11371@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 05:09:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT9Bc-0000RD-KU
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 05:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbXCSEJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 00:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbXCSEJb
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 00:09:31 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49270 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbXCSEJb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 00:09:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319040930.KERW748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 00:09:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cU9V1W00a1kojtg0000000; Mon, 19 Mar 2007 00:09:30 -0400
In-Reply-To: <20070319023238.GC11371@thunk.org> (Theodore Tso's message of
	"Sun, 18 Mar 2007 22:32:38 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42583>

Theodore Tso <tytso@mit.edu> writes:

> It seemed to me that Junio's suggestion made the most amount of sense,
> but I tinkered with the with the warning message to make it clear that
> the cause of the warning was a bugus tool in the merge.tool
> configuration parameter.
>
> This has also been pushed out to git://repo.or.cz/git/mergetool.git
>
> Junio, please pull if you approve...

Surely, and thanks.  I think your message is much nicer.
