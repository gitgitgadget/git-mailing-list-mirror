From: Junio C Hamano <junkio@cox.net>
Subject: Re: HTTP redirection with git-clone/git-fetch ?
Date: Fri, 11 Nov 2005 09:38:00 -0800
Message-ID: <7vu0ejnkzr.fsf@assigned-by-dhcp.cox.net>
References: <200511092331.36421.Josef.Weidendorfer@gmx.de>
	<20051110002419.GB4051@reactrix.com>
	<200511101409.48618.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 18:40:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eacqm-0003Yn-9B
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 18:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVKKRiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 12:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVKKRiE
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 12:38:04 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:60044 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750956AbVKKRiD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 12:38:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111173658.YUHC2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 12:36:58 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <200511101409.48618.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Thu, 10 Nov 2005 14:09:48 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11621>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

>> This should fix it, although it still tries every GET with the original
>> URL which is a bit inefficient.
>
> Thanks, I just sent a patch for git-clone, including your patch, to
> Junio.

Thank you both.
