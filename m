From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Checklist clarifications: added "Commits", "Patch:" headings
Date: Mon, 30 Apr 2007 21:11:41 -0700
Message-ID: <7vslah89oi.fsf@assigned-by-dhcp.cox.net>
References: <r6q2xgws.fsf@cante.net>
	<Pine.LNX.4.64.0704301333400.29859@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 01 06:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HijjB-00031b-MS
	for gcvg-git@gmane.org; Tue, 01 May 2007 06:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933464AbXEAEMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 00:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933455AbXEAEMG
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 00:12:06 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:53369 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933454AbXEAELn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 00:11:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501041142.LJJY1318.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 1 May 2007 00:11:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tgBg1W00j1kojtg0000000; Tue, 01 May 2007 00:11:41 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45907>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, my impression was that many people had problems when first 
> sending patches with send-email. There should be _at least_ a word of 
> caution, that you should test the operation on something different than 
> the Git list first.

Also an EXAMPLES section to Documentation/git-send-email.txt
would be useful.
