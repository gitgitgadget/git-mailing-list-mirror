From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use git-for-each-ref to check whether the origin branch exists.
Date: Wed, 23 May 2007 11:06:24 -0700
Message-ID: <7vlkff2z4v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705230909310.25524@lar.bfw.de>
	<Pine.LNX.4.64.0705231153000.4113@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Springl <springl-git@bfw-online.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 23 20:06:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqvEE-00006D-JV
	for gcvg-git@gmane.org; Wed, 23 May 2007 20:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632AbXEWSG0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 14:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756000AbXEWSG0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 14:06:26 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60298 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbXEWSGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 14:06:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523180625.LGNA2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 14:06:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2i6P1X00b1kojtg0000000; Wed, 23 May 2007 14:06:24 -0400
In-Reply-To: <Pine.LNX.4.64.0705231153000.4113@racer.site> (Johannes
	Schindelin's message of "Wed, 23 May 2007 12:13:21 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48166>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Default for ref-packed repositories is to pack only the tags, 
> 	therefore you usually do not need this patch. However, it looks 
> 	obviously correct to me. A cursory test also showed that it does 
> 	not break anything.
>
> 	> Maybe you want to use this or a similar solution to be 
> 	> integrated in stock git.
> 	
> 	Unfortunately your patch is white-space corrupted (it has an extra 
> 	space on all lines starting with a space, it seems). Therefore I 
> 	redid it with this email.
>
> 	It would be nice to follow Documentation/SubmittingPatches next 
> 	time. For example, I guess that you want to sign off on it...

Thanks both.
