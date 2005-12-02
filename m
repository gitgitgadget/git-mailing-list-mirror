From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Using sticky directories to control access to branches.
Date: Thu, 01 Dec 2005 17:13:20 -0800
Message-ID: <7vwtio9u8f.fsf@assigned-by-dhcp.cox.net>
References: <20051117170129.GA14013@hpsvcnb.fc.hp.com>
	<7vfypumlu3.fsf@assigned-by-dhcp.cox.net>
	<20051121180133.GA28171@hpsvcnb.fc.hp.com>
	<20051201154222.GB18993@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 02:14:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhzUN-0000d6-Fp
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 02:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbVLBBNY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 20:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbVLBBNY
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 20:13:24 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:16052 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932704AbVLBBNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 20:13:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202011251.VYHV3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 20:12:51 -0500
To: git@vger.kernel.org
In-Reply-To: <20051201154222.GB18993@hpsvcnb.fc.hp.com> (Carl Baldwin's
	message of "Thu, 1 Dec 2005 08:42:22 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13095>

Carl Baldwin <cnb@fc.hp.com> writes:

> I have tweaked the script a little.  I thought I'd send to the list in
> case anyone was following this.  If not, then safely ignore this.

It _might_ make sense to have a contrib/examples subdirectory in
git.git project and keep a collection of examples like this.

Anybody else interested?
