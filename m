From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Tue, 28 Feb 2006 09:27:36 +0100
Message-ID: <20060228082736.GA4593@c165.ib.student.liu.se>
References: <11404323692193-git-send-email-ryan@michonline.com> <20060220234054.GA7903@c165.ib.student.liu.se> <7vlkw57f63.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 09:27:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE0Cw-00068G-5t
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 09:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWB1I1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 03:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWB1I1n
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 03:27:43 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:31453 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1750902AbWB1I1m
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 03:27:42 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 306224119; Tue, 28 Feb 2006 09:42:38 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FE0Cm-0002Oy-00; Tue, 28 Feb 2006 09:27:36 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkw57f63.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16922>

On Mon, Feb 20, 2006 at 04:01:56PM -0800, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > I have also been working on a blame program.

...

> BTW, these days I always compile things with 
> 
> 	-Wall -Wdeclaration-after-statement
> 
> which caught quite a many.

Just out of curiosity, why do you prefer declarations before
statements?

- Fredrik
