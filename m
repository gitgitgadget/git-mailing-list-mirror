From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] ProgramError: merge ... .merge_file_4CPoEQ: No such file
Date: Tue, 06 Dec 2005 08:51:06 -0800
Message-ID: <7v64q241ad.fsf@assigned-by-dhcp.cox.net>
References: <E1EjdPu-00034z-Hu@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 17:55:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejg25-0007pf-Ae
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 17:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVLFQvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 11:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbVLFQvK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 11:51:10 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28915 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932312AbVLFQvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 11:51:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206164926.KWWF20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 11:49:26 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EjdPu-00034z-Hu@jdl.com> (Jon Loeliger's message of "Tue, 06
	Dec 2005 08:03:38 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13278>

Jon Loeliger <jdl@freescale.com> writes:

> So, I was surprised by this display this morning.
> (I swear I'm trying to help! :-)

Thanks.  I actually saw this myself yesterday.

I have this strange feeling that you do not have "merge"
installed on your cygwin box.  It is part of "rcs".
