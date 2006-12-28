From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] xdl_merge(): fix a segmentation fault when refining conflicts
Date: Thu, 28 Dec 2006 14:09:58 -0800
Message-ID: <7vejqjvfih.fsf@assigned-by-dhcp.cox.net>
References: <20061227041644.GA22449@spearce.org>
	<Pine.LNX.4.63.0612271214120.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<87fyb11ouy.fsf@wine.dyndns.org>
	<Pine.LNX.4.63.0612281710350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 23:10:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H03S8-0005s2-3r
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 23:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWL1WKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 17:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWL1WKA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 17:10:00 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53651 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965005AbWL1WKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 17:10:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228220959.DTOQ15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 17:09:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4NAC1W00g1kojtg0000000; Thu, 28 Dec 2006 17:10:13 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612281710350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 28 Dec 2006 17:13:33 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35562>

Thank you, everybody.
