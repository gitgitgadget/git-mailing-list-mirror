From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 24 Dec 2005 09:58:12 -0800
Message-ID: <7vwthus7gr.fsf@assigned-by-dhcp.cox.net>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 18:58:20 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqDet-00044T-1d
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 18:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVLXR6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 12:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVLXR6O
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 12:58:14 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:22478 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932144AbVLXR6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 12:58:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224175638.BHRM17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 12:56:38 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43AD1E63.4040103@op5.se> (Andreas Ericsson's message of "Sat, 24
	Dec 2005 11:09:39 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14028>

Andreas Ericsson <ae@op5.se> writes:

> The fact that there are 39 bash'ish shell-scripts does little to help a 
> native port...

Can you defend that "bash'ism" comment for all 39?  The one I
know of and would want to get rid of its bashism by rewriting is
git-grep, but most of them I thought was plain POSIX.
