From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.5.1
Date: Thu, 05 Apr 2007 22:41:29 -0700
Message-ID: <7vlkh6kqk6.fsf@assigned-by-dhcp.cox.net>
References: <7v648c7bbn.fsf@assigned-by-dhcp.cox.net>
	<200704041038.36183.andyparkins@gmail.com>
	<7vwt0s5tsc.fsf@assigned-by-dhcp.cox.net>
	<vpq8xd8o0q6.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Apr 06 07:41:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZhCX-0004wG-Sq
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 07:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbXDFFlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 01:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbXDFFlb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 01:41:31 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49291 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbXDFFla (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 01:41:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070406054129.EFJC1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 01:41:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id jhhV1W00B1kojtg0000000; Fri, 06 Apr 2007 01:41:29 -0400
In-Reply-To: <vpq8xd8o0q6.fsf@olympe.imag.fr> (Matthieu Moy's message of "Wed,
	04 Apr 2007 13:09:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43900>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Thanks -- that's very true.  I meant that they are loooong
>> deprecated, and finally we removed them in this release.
>
> In a perfect world, the release notes would mention the reason for the
> removal (e.g. "use git foo-bar instead").

Soon after 1.5.0 was released, I think we said these two were
not used in practice and declared them as deprecated.  So there
is no "use this instead".

In a perfect world, nobody would kibitz, but instead everybody
reads, understands and remembers the discussion that led to the
change ;-)
