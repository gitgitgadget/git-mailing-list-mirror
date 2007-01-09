From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/6] Make merge-base a built-in.
Date: Tue, 09 Jan 2007 13:22:53 -0800
Message-ID: <7vd55nki8i.fsf@assigned-by-dhcp.cox.net>
References: <7vd55oo52e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701091202560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 22:23:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4OQs-00022R-Nx
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbXAIVWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbXAIVWz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:22:55 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:60487 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374AbXAIVWy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:22:54 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109212254.PHVV29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 16:22:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 99N31W00V1kojtg0000000; Tue, 09 Jan 2007 16:22:04 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701091202560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 9 Jan 2007 12:05:42 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36403>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Anyway, I think this series is sane (i.e. I did not find obvious flaws 
> reading them).

Heh, there were a few "easter eggs" in the one that are
currently sitting on 'pu', but don't waste your time go hunting
since I've fixed them up in my tree over lunch break.
