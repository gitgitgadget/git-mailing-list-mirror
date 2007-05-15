From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use $Id$ as the ident attribute keyword rather than $ident$  to be consistent with other VCSs
Date: Tue, 15 May 2007 01:54:07 -0700
Message-ID: <7v8xbqlb68.fsf@assigned-by-dhcp.cox.net>
References: <200705141429.58412.andyparkins@gmail.com>
	<200705142324.02929.andyparkins@gmail.com>
	<7vmz06lu7d.fsf@assigned-by-dhcp.cox.net>
	<200705150914.44641.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 10:54:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnsnN-0004TC-Sc
	for gcvg-git@gmane.org; Tue, 15 May 2007 10:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757832AbXEOIyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 04:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758448AbXEOIyK
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 04:54:10 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64600 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757832AbXEOIyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 04:54:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515085408.XUDZ13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 15 May 2007 04:54:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id zLu71W0051kojtg0000000; Tue, 15 May 2007 04:54:08 -0400
In-Reply-To: <200705150914.44641.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 15 May 2007 09:14:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47329>

Andy Parkins <andyparkins@gmail.com> writes:

> On Tuesday 2007 May 15, Junio C Hamano wrote:
>
>> I think this on top of your patch would be the minimum necessary
>> for v1.5.2.
>
> Oops.  I think I'm going to mail you a big bat with
> "Documentation" carved into it that you can use for smacking
> us (me), for submitting patches without documentation.

Actually, Documentation is the least offence.  I wanted to have
somebody sanity-check the change to count_ident().
