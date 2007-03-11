From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in bundle
Date: Sun, 11 Mar 2007 12:58:46 -0700
Message-ID: <7vps7fwo09.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
	<45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45F2D955.8050800@gmail.com>
	<Pine.LNX.4.63.0703101749270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45F2F934.8060407@gmail.com>
	<Pine.LNX.4.63.0703110201450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy7m4y3cn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703110244130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45F41787.4080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 20:58:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUBv-0001lY-9U
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 20:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbXCKT6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 15:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbXCKT6s
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 15:58:48 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43564 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbXCKT6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 15:58:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311195846.OHEX1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Mar 2007 15:58:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZXym1W00B1kojtg0000000; Sun, 11 Mar 2007 15:58:46 -0400
In-Reply-To: <45F41787.4080506@gmail.com> (Mark Levedahl's message of "Sun, 11
	Mar 2007 10:51:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41965>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Bottom line, I strongly advocate Dscho's last patch + what is on next
> be promoted to master.

I agree that is a very sensible thing to do.  Let's do that.
