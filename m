From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/8] git-apply: work from subdirectory.
Date: Sun, 27 Nov 2005 14:12:39 -0800
Message-ID: <7voe45agfc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net>
	<7viruf68bz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511260932080.13959@g5.osdl.org>
	<7v4q5yohta.fsf@assigned-by-dhcp.cox.net>
	<m364qef93a.fsf@quimbies.gnus.org>
	<7vy839dfzk.fsf@assigned-by-dhcp.cox.net>
	<m3fyph7q14.fsf@quimbies.gnus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 23:13:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgUlI-0003lH-Ph
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 23:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVK0WMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 17:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVK0WMm
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 17:12:42 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:35227 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751162AbVK0WMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 17:12:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051127221242.QZBZ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 17:12:42 -0500
To: Lars Magne Ingebrigtsen <larsi@gnus.org>
In-Reply-To: <m3fyph7q14.fsf@quimbies.gnus.org> (Lars Magne Ingebrigtsen's
	message of "Sun, 27 Nov 2005 22:13:27 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12830>

Lars Magne Ingebrigtsen <larsi@gnus.org> writes:

> Egads!  It's all my fault -- there's some code in the mail-to-news
> script that's truncating long header lines, and nobody's noticed up
> 'till now.  I've now twiddled it slightly; it should stop mangling
> References headers now...

Thanks, it looks good now --- checked with your message I am
responding to ;-).
