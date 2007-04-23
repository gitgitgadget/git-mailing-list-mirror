From: Junio C Hamano <junkio@cox.net>
Subject: Re: Anybody using git-send-pack?
Date: Mon, 23 Apr 2007 11:36:02 -0700
Message-ID: <7vr6qbey5p.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704231321550.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:36:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg3OU-0003Lz-RL
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 20:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161306AbXDWSgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 14:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161232AbXDWSgG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 14:36:06 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62152 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161306AbXDWSgF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 14:36:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423183603.FFNY1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 14:36:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qic21W00J1kojtg0000000; Mon, 23 Apr 2007 14:36:02 -0400
In-Reply-To: <Pine.LNX.4.64.0704231321550.28708@iabervon.org> (Daniel
	Barkalow's message of "Mon, 23 Apr 2007 13:29:43 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45347>

Fwiw, I use a custom script that directly calls send-pack.
