From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/6] Remove whitespace breakage from *.c files
Date: Mon, 21 May 2007 09:39:34 -0700
Message-ID: <7vmyzydtbt.fsf@assigned-by-dhcp.cox.net>
References: <4650222D.4070707@gmail.com>
	<7vfy5rjhyq.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550705210454s6e89fb2frb8cb74ea97d7c2ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 18:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqAvA-00066u-DR
	for gcvg-git@gmane.org; Mon, 21 May 2007 18:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069AbXEUQjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 12:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756569AbXEUQjg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 12:39:36 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33754 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069AbXEUQjg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 12:39:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521163936.OXCG13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 21 May 2007 12:39:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1sfa1X00A1kojtg0000000; Mon, 21 May 2007 12:39:35 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48027>

"Marco Costalba" <mcostalba@gmail.com> writes:

> ... I
> understand that this kind of patches are mostly automatically created
> and also touch a lot of files so the manteiner has the best _timing_
> to create and apply them.

I was thinking about the same thing last night.  The tips of
'master' branch and 'next' branch were identical after pushing
out the "first batch" I announced in the last "What's cooking"
message, and it was really a good time to do this kind of thing.

Will do, sometime soon.
