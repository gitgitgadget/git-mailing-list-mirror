From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff --check: use colour
Date: Sat, 17 Feb 2007 17:06:03 -0800
Message-ID: <7vodnsp950.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vejpi63py.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701262214420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy94qplg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180146260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 02:06:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIaVE-0004sj-Fj
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 02:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbXBRBGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 20:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXBRBGF
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 20:06:05 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52758 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbXBRBGE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 20:06:04 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218010603.CVPB1300.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 20:06:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qp621W0081kojtg0000000; Sat, 17 Feb 2007 20:06:03 -0500
In-Reply-To: <Pine.LNX.4.63.0702180146260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 18 Feb 2007 01:47:40 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40044>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I _thought_ I could clean it up a little more, but then realized a thinko 
> on my part: I misread a NUL for a NULL.
>
> Should I resend?

No need.  I think you have unused variable 'message' but I'll
manage.
