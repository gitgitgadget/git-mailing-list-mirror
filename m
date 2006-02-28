From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Tue, 28 Feb 2006 00:38:35 -0800
Message-ID: <7v64mzq3n8.fsf@assigned-by-dhcp.cox.net>
References: <11404323692193-git-send-email-ryan@michonline.com>
	<20060220234054.GA7903@c165.ib.student.liu.se>
	<7vlkw57f63.fsf@assigned-by-dhcp.cox.net>
	<20060228082736.GA4593@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 09:38:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE0NW-0000cN-3f
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 09:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWB1Iij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 03:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWB1Iij
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 03:38:39 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17366 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750794AbWB1Iii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 03:38:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228083843.PTSH25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Feb 2006 03:38:43 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060228082736.GA4593@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Tue, 28 Feb 2006 09:27:36 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16923>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> On Mon, Feb 20, 2006 at 04:01:56PM -0800, Junio C Hamano wrote:
>> 
>> BTW, these days I always compile things with 
>> 
>> 	-Wall -Wdeclaration-after-statement
>> 
>> which caught quite a many.
>
> Just out of curiosity, why do you prefer declarations before
> statements?

Inertia, IOW, mostly being used to read code written that way.
