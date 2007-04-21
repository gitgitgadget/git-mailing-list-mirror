From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] WTF did we change in git-fsck recently?
Date: Fri, 20 Apr 2007 19:17:09 -0700
Message-ID: <7v7is6wjx6.fsf@assigned-by-dhcp.cox.net>
References: <7vps5ywouw.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704201823310.9964@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704201826350.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 21 04:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf5AJ-0005zT-C9
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 04:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbXDUCRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 22:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbXDUCRL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 22:17:11 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62110 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbXDUCRK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 22:17:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421021710.TAUP1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 22:17:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id peH91W00P1kojtg0000000; Fri, 20 Apr 2007 22:17:10 -0400
In-Reply-To: <alpine.LFD.0.98.0704201826350.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 20 Apr 2007 18:30:06 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45148>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 20 Apr 2007, Linus Torvalds wrote:
>> 
>> Hmm. Probably something broken in my "object decorator" thing then. 
>
> Duh.

Thanks.
