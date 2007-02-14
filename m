From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 11:06:29 -0800
Message-ID: <7vvei4o8y2.fsf@assigned-by-dhcp.cox.net>
References: <200702140909.28369.andyparkins@gmail.com>
	<slrnet5p5h.s9h.siprbaum@xp.machine.xx>
	<Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy98snus.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702141843190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vlkj0pqp5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702141901250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd54cpq0v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702141318060.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:06:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHPSc-0003mX-VX
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbXBNTGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbXBNTGc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:06:32 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49953 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbXBNTGb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:06:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214190630.MRCN1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 14:06:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PX6W1W0061kojtg0000000; Wed, 14 Feb 2007 14:06:31 -0500
In-Reply-To: <Pine.LNX.4.64.0702141318060.1757@xanadu.home> (Nicolas Pitre's
	message of "Wed, 14 Feb 2007 13:19:34 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39724>

Nicolas Pitre <nico@cam.org> writes:

> Why not simplifying the question to only:
>
> 	git config -l
>
> then?

Fair enough.
