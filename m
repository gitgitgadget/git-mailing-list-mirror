From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 1.5.0-rc2 compiler warning
Date: Sun, 21 Jan 2007 17:13:15 -0800
Message-ID: <7vy7nvyic4.fsf@assigned-by-dhcp.cox.net>
References: <45B40E7E.3030706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 02:13:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8nkN-0005Ll-MH
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 02:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbXAVBNR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 20:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbXAVBNR
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 20:13:17 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47250 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbXAVBNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 20:13:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122011316.DTTE29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jan 2007 20:13:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E1DZ1W00w1kojtg0000000; Sun, 21 Jan 2007 20:13:34 -0500
To: SungHyun Nam <goweol@gmail.com>
In-Reply-To: <45B40E7E.3030706@gmail.com> (SungHyun Nam's message of "Mon, 22
	Jan 2007 10:08:14 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37376>

I know.  Imported code.

I do not think we can do much on a platform where wchar_t is too
narrow and BMP only anyway.
