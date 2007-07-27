From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff with add/modified codes
Date: Fri, 27 Jul 2007 16:22:17 -0700
Message-ID: <7vir85whxy.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910707271505x4eac928axe639308afed20cb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 01:22:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEZ8X-0007yl-P7
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 01:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764667AbXG0XWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 19:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761020AbXG0XWT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 19:22:19 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64796 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760904AbXG0XWS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 19:22:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727232217.JKHP14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 19:22:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UnNH1X00i1kojtg0000000; Fri, 27 Jul 2007 19:22:18 -0400
In-Reply-To: <9e4733910707271505x4eac928axe639308afed20cb3@mail.gmail.com>
	(Jon Smirl's message of "Fri, 27 Jul 2007 18:05:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53975>

Would --stat --summary be satisfactory?
