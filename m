From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add hg-to-git conversion utility.
Date: Fri, 12 Jan 2007 15:14:56 -0800
Message-ID: <7vzm8nq1lb.fsf@assigned-by-dhcp.cox.net>
References: <1168537766.22649.19.camel@localhost.localdomain>
	<eo8ngk$ja$1@sea.gmane.org> <1168632860.29218.5.camel@voyager.dsnet>
	<1168639023.13640.2.camel@localhost.localdomain>
	<20070112221525.GA20956@spearce.org> <45A81328.9030109@popies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 00:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Vbx-0004QE-Ld
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 00:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbXALXO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 18:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbXALXO6
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 18:14:58 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39281 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161140AbXALXO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 18:14:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112231456.CQZA16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 18:14:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id APE41W0161kojtg0000000; Fri, 12 Jan 2007 18:14:05 -0500
To: Stelian Pop <stelian@popies.net>
In-Reply-To: <45A81328.9030109@popies.net> (Stelian Pop's message of "Sat, 13
	Jan 2007 00:00:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36726>

Stelian Pop <stelian@popies.net> writes:

> But I wrote this since I had a need for it, and once my repositories
> converted to git I'm not sure I'll need it again :)

It is not a good strategy to say upfront that you are not going
to maintain it, when you are submitting something for inclusion.
