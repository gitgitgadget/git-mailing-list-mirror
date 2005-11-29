From: Junio C Hamano <junkio@cox.net>
Subject: [OT] Activision (Re: use binmode(STDOUT) in git-status)
Date: Tue, 29 Nov 2005 14:44:31 -0800
Message-ID: <7vwtir846o.fsf_-_@assigned-by-dhcp.cox.net>
References: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com>
	<438B2859.6060109@zytor.com>
	<Pine.LNX.4.63.0511281700100.11362@wbgn013.biozentrum.uni-wuerzburg.de>
	<438B2B90.9010500@zytor.com>
	<Pine.LNX.4.63.0511281756001.11697@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051129221221.GC3033@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:48:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhEDW-0007RU-Et
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVK2Woe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVK2Woe
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:44:34 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13976 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932444AbVK2Wod (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 17:44:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129224324.PFVF17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 17:43:24 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051129221221.GC3033@steel.home> (Alex Riesen's message of
	"Tue, 29 Nov 2005 23:12:21 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12968>

Alex Riesen <raa.lkml@gmail.com> writes:

> Johannes Schindelin, Mon, Nov 28, 2005 17:56:58 +0100:
>> > if you're running Cygwin, wouldn't Cygwin's Perl make a lot more sense?
>> 
>> I thought so, too, but I guess there's a reason that Activision's perl was 
>> used.
>
> the reason were incompatible scripts (notably, the ones expecting crlf).

I wonder why people keep saying Activision ;-).  Taken with my
use of frotz and nitfol in the examples [*1*], somebody might
confuse us with a group of old Infocom [*2*] fans.

[1] http://en.wikipedia.org/wiki/Nitfol
[2] http://web.mit.edu/6.933/www/Fall2000/infocom/
