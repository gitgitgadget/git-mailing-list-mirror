From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Print a sane error message if an alias expands to an invalid git command
Date: Sat, 10 Feb 2007 08:50:53 -0800
Message-ID: <7vireaj6s2.fsf@assigned-by-dhcp.cox.net>
References: <20070209014852.GA13207@thunk.org>
	<1171123504783-git-send-email-tytso@mit.edu>
	<11711235041527-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>,
	Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 10 17:50:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFvRC-00035Z-9t
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 17:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbXBJQuz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 11:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXBJQuz
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 11:50:55 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42321 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbXBJQuz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 11:50:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210165054.HLJL21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Feb 2007 11:50:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Msqu1W0081kojtg0000000; Sat, 10 Feb 2007 11:50:54 -0500
In-Reply-To: <11711235041527-git-send-email-tytso@mit.edu> (Theodore Ts'o's
	message of "Sat, 10 Feb 2007 11:05:03 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39242>

Thanks for your alias and diff patches.

I'll be away from the keyboard for most of today, so if the list
can do distributed QA (and debugging if necessary) before I
return that would be very appreciated ;-).
