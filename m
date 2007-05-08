From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/6] gitweb: Add combined diff support
Date: Mon, 07 May 2007 18:31:20 -0700
Message-ID: <7vvef45cev.fsf@assigned-by-dhcp.cox.net>
References: <11784930091585-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 03:31:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEY3-0002ge-8E
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934290AbXEHBbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934383AbXEHBbW
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:31:22 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:36922 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934290AbXEHBbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:31:21 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508013122.GFLK1318.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 7 May 2007 21:31:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wRXL1W00E1kojtg0000000; Mon, 07 May 2007 21:31:20 -0400
In-Reply-To: <11784930091585-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Mon, 7 May 2007 01:10:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46503>

I've minimally tried this on my private machine.  Looks pretty
nice for simple merges, but I think we would want --cc not -c
most of the time.

Pushed out in 'next'.  Thanks.
