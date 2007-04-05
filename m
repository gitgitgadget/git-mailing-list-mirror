From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix passing of TCLTK_PATH to git-gui
Date: Thu, 05 Apr 2007 01:44:43 -0700
Message-ID: <7v8xd7tdl0.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0704050049u746842ebn270998c5732927d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Eygene Ryabinkin" <rea-git@codelabs.ru>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 10:44:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZNaN-0002Fl-Sm
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 10:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbXDEIop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 04:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbXDEIop
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 04:44:45 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60779 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964959AbXDEIoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 04:44:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405084444.MJNK28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 04:44:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jLkj1W00N1kojtg0000000; Thu, 05 Apr 2007 04:44:44 -0400
In-Reply-To: <81b0412b0704050049u746842ebn270998c5732927d3@mail.gmail.com>
	(Alex Riesen's message of "Thu, 5 Apr 2007 09:49:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43810>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> GNU make does not include environment variables by default
> in its namespace.

Shouldn't this be part of proposed commit log message?

Also I'd appreciate if you did not attach the format-patch
output, but send a properly formatted e-mail.  I would not be so
picky to non-regulars, but I expect I'd be getting many more
patches from you, so...
