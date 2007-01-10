From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix warnings on PowerPC - use C99 printf format if available
Date: Tue, 09 Jan 2007 21:22:34 -0800
Message-ID: <7vk5zvfobp.fsf@assigned-by-dhcp.cox.net>
References: <20070110040710.7403.74668.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 06:22:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4VvD-0001EW-Bz
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 06:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbXAJFWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 00:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXAJFWg
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 00:22:36 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35608 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932580AbXAJFWf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 00:22:35 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110052235.KRPG3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 00:22:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9HMk1W00N1kojtg0000000; Wed, 10 Jan 2007 00:21:44 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <20070110040710.7403.74668.stgit@localhost.localdomain> (Pavel
	Roskin's message of "Tue, 09 Jan 2007 23:07:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36478>

Pavel Roskin <proski@gnu.org> writes:

> Signed-off-by: Pavel Roskin <proski@gnu.org>

This needs a better subject.  I do not see anything PowerPC specific...
