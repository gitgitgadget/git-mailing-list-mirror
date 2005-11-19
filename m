From: Junio C Hamano <junkio@cox.net>
Subject: Re: git --exec-path conversion
Date: Sat, 19 Nov 2005 04:05:12 -0800
Message-ID: <7vu0e86dxj.fsf@assigned-by-dhcp.cox.net>
References: <20051119111444.82122.qmail@web26309.mail.ukl.yahoo.com>
	<Pine.LNX.4.63.0511191218370.27986@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@yahoo.it>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 13:05:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdRT5-0001lH-Tf
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 13:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVKSMFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 07:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVKSMFP
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 07:05:15 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64914 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751295AbVKSMFO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 07:05:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119120446.JMOU15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 07:04:46 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511191218370.27986@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 19 Nov 2005 12:20:26 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12331>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Little nit: Test for "git-", because "git" and "gitk" will stay in the 
> PATH.

Heh, he is writing QGit; why should he run gitk ;-)?
