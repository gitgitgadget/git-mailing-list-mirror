From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Shoddy pack information tool
Date: Wed, 11 Jul 2007 14:55:26 -0700
Message-ID: <7vwsx61u7l.fsf@assigned-by-dhcp.cox.net>
References: <20070709044326.GH4087@lavos.net>
	<7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707090954550.26459@xanadu.home>
	<7vir8tv8dr.fsf@assigned-by-dhcp.cox.net>
	<20070709185353.GL4087@lavos.net> <20070709193017.GN4087@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:56:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8kAB-0005YC-SZ
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933018AbXGKVzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932979AbXGKVza
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:55:30 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47407 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910AbXGKVz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:55:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711215526.BSFJ1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:55:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMvS1X00A1kojtg0000000; Wed, 11 Jul 2007 17:55:27 -0400
In-Reply-To: <20070709193017.GN4087@lavos.net> (Brian Downing's message of
	"Mon, 9 Jul 2007 14:30:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52215>

I do not think this is particularlly Shoddy.  Care to move it
somewhere in contrib/ (say, contrib/stats/packinfo.pl) and sign
off the patch?
