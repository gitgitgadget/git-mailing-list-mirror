From: Junio C Hamano <junkio@cox.net>
Subject: Re: [FILES] core-git documentation update
Date: Sun, 08 May 2005 12:30:20 -0700
Message-ID: <7vpsw15xdf.fsf@assigned-by-dhcp.cox.net>
References: <427E4AED.9050702@dgreaves.com>
	<20050508173109.GZ9495@pasky.ji.cz> <427E4F6C.6090302@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 21:28:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUrRT-0002bB-DB
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVEHTdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbVEHTbz
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:31:55 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:64436 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262973AbVEHTaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 15:30:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508193022.ZHKD22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 15:30:22 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <427E4F6C.6090302@dgreaves.com> (David Greaves's message of
 "Sun, 08 May 2005 18:42:04 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

DG> it just makes across the board changes easier and at the minute the
DG> stuff I've been doing is systemic.
DG> I have no problems with breaking it up - hence the script...

Monolithic version is easier to work with when there is only one
or very few people working on it but when the document matures
enough to describe the current state of affairs accurately
enough, further changes would come almost solely from changing
the programs the document describes.  At that point having
separate files describing each program is easier to work with,
and I think that point is now.


