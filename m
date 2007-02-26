From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues
Date: Sun, 25 Feb 2007 21:33:58 -0800
Message-ID: <7v8xelo52x.fsf@assigned-by-dhcp.cox.net>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702260112160.12555@beast.quantumfyre.co.uk>
	<7vtzx9oaeb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702260455020.16708@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sbejar@gmail.com
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Feb 26 06:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLYV7-0006lq-FN
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 06:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbXBZFeC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 00:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbXBZFeC
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 00:34:02 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:62038 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbXBZFeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 00:34:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070226053400.FVOQ3767.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Feb 2007 00:34:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U5Zx1W00Q1kojtg0000000; Mon, 26 Feb 2007 00:33:58 -0500
In-Reply-To: <Pine.LNX.4.64.0702260455020.16708@beast.quantumfyre.co.uk>
	(Julian Phillips's message of "Mon, 26 Feb 2007 05:10:33 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40611>

Julian Phillips <julian@quantumfyre.co.uk> writes:

>> I was kind of waiting for dust from Santi's code shuffling to
>> settle down, because the series moderately conflicts with it.  I
>> wanted to take Santi's patch first as it was supposed to be a
>> clean-up without any functionality changes, although it was kind
>> of painful to really make sure there is no regression.
>
> Indeed.  I was thinking pretty much the same.  It seems unnecessary to
> make Santi rebase his patch without any evidence that the jc/fetch
> topic is actually urgently needed by anyone.

Sorry, too late --- it's a done deal.  Partial C rewrite of
git-fetch is now in 'next'.
