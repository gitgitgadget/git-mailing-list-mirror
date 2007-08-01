From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 01 Aug 2007 01:48:32 -0700
Message-ID: <7vzm1b7i8v.fsf@assigned-by-dhcp.cox.net>
References: <200708010216.59750.jnareb@gmail.com>
	<alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	<200708011033.00873.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 10:48:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG9sj-0005k8-So
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 10:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbXHAIse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 04:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbXHAIse
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 04:48:34 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43114 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXHAIsd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 04:48:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801084833.MGTR14885.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 1 Aug 2007 04:48:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WYoY1X00H1kojtg0000000; Wed, 01 Aug 2007 04:48:33 -0400
In-Reply-To: <200708011033.00873.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 1 Aug 2007 10:33:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54417>

Jakub Narebski <jnareb@gmail.com> writes:

> About clone: there was "pack loose, copy existing packs" idea.

Can you give more details --- I do not recall such an "idea"
discussed.
