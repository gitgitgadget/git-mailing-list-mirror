From: Junio C Hamano <junkio@cox.net>
Subject: Re: confusion over the new branch and merge config
Date: Thu, 21 Dec 2006 16:39:24 -0800
Message-ID: <7vzm9g932b.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	<7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	<20061221182102.906ad046.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:39:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYS1-0001qX-Jg
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423153AbWLVAjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423151AbWLVAjt
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:39:49 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53739 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423153AbWLVAjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:39:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222003925.KXTH18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Dec 2006 19:39:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1cfd1W00x1kojtg0000000; Thu, 21 Dec 2006 19:39:38 -0500
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <20061221182102.906ad046.seanlkml@sympatico.ca>
	(seanlkml@sympatico.ca's message of "Thu, 21 Dec 2006 18:21:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35096>

Sean <seanlkml@sympatico.ca> writes the value of
branch.<me>.merge being the name at the remote site, saying:

> This seems inconsistent and confusing.

Check the archive for messages on this issue that talks about
the case without tracking branches.
