From: Junio C Hamano <junkio@cox.net>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Fri, 12 Jan 2007 11:43:32 -0800
Message-ID: <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
	<7virfct737.fsf@assigned-by-dhcp.cox.net>
	<slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 20:43:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5SJP-0002QQ-Ds
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 20:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbXALTne (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 14:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbXALTne
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 14:43:34 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62485 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964958AbXALTnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 14:43:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112194332.IOMZ19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 14:43:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AKih1W0011kojtg0000000; Fri, 12 Jan 2007 14:42:41 -0500
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
In-Reply-To: <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx> (Peter Baumann's
	message of "Fri, 12 Jan 2007 20:11:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36697>

Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
writes:

> Me doesn't really like the new semantics of "git-add", because it does
> two seperate things - it adds new files and it refreshes the content of
> previously known files.

http://thread.gmane.org/gmane.comp.version-control.git/32452/focus=32792
