From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make gitk save and restore the user set window position.
Date: Sun, 11 Feb 2007 13:49:15 -0800
Message-ID: <7vodo0cqlg.fsf@assigned-by-dhcp.cox.net>
References: <11712040401127-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 22:49:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGMZw-0000uP-1P
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 22:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbXBKVtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 16:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbXBKVtR
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 16:49:17 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:45003 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932563AbXBKVtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 16:49:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211214915.COSC1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 16:49:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NMpF1W00Q1kojtg0000000; Sun, 11 Feb 2007 16:49:15 -0500
In-Reply-To: <11712040401127-git-send-email-mdl123@verizon.net> (Mark
	Levedahl's message of "Sun, 11 Feb 2007 09:27:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39310>

Mark Levedahl <mdl123@verizon.net> writes:

> I sent these patches to Junio and Paul last week, mistyped the git mailing list
> address so they didn't get to the list so am resending for the record.

Thanks.  Will apply them, short-circuitting Paul.
