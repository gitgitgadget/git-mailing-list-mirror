From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [COGITO] make cg-tag use git-check-ref-format
Date: Tue, 13 Dec 2005 10:41:27 -0800
Message-ID: <7vu0dcalgo.fsf@assigned-by-dhcp.cox.net>
References: <11344712912199-git-send-email-matlads@dsmagic.com>
	<7vy82p9rnb.fsf@assigned-by-dhcp.cox.net>
	<20051213170015.GD22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 19:42:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmF5k-0005GZ-HG
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 19:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVLMSld (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 13:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbVLMSld
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 13:41:33 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31470 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030202AbVLMSld (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 13:41:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213183951.LIXP17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Dec 2005 13:39:51 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051213170015.GD22159@pasky.or.cz> (Petr Baudis's message of
	"Tue, 13 Dec 2005 18:00:15 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13584>

Petr Baudis <pasky@suse.cz> writes:

> Thank you both for the patch, but I'd be much more comfortable if at
> least quotes (both ' and "), backslashes, ? and * would be prohibited in
> the names as well.

I second that, and thanks for pointing it out.  Any objections?
