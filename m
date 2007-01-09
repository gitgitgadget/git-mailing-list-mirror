From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-remote
Date: Mon, 08 Jan 2007 21:50:05 -0800
Message-ID: <7vr6u4sq9e.fsf@assigned-by-dhcp.cox.net>
References: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
	<20070109042851.GF1686@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 06:50:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H49sO-0004kj-Sy
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 06:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbXAIFuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 00:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXAIFuW
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 00:50:22 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:48005 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbXAIFuV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 00:50:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109055021.BOEN19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 00:50:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8tqc1W00W1kojtg0000000; Tue, 09 Jan 2007 00:50:37 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070109042851.GF1686@fieldses.org> (J. Bruce Fields's message
	of "Mon, 8 Jan 2007 23:28:51 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36318>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Would it make sense for "git add" to do the initial fetch as well?

It would be handy.

And perhaps we could make it the default but with a command line
override to help disconnected people.
