From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use standard -t option for touch.
Date: Fri, 19 Jan 2007 08:58:15 -0800
Message-ID: <7vfya7hs2g.fsf@assigned-by-dhcp.cox.net>
References: <20070118102814.0C32FA914@diphong.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 17:58:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7x4d-0000gO-Or
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 17:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbXASQ6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 11:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbXASQ6R
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 11:58:17 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57865 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662AbXASQ6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 11:58:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119165816.LEKE26900.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 11:58:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id D4yZ1W00a1kojtg0000000; Fri, 19 Jan 2007 11:58:34 -0500
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37190>

Hhmmmmm.

This still does not seem to fix the breakage I am seeing on
OpenBSD.

But thanks anyway for trying.
