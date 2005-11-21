From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Using sticky directories to control access to branches.
Date: Mon, 21 Nov 2005 11:29:12 -0800
Message-ID: <7vacfxsstz.fsf@assigned-by-dhcp.cox.net>
References: <20051117170129.GA14013@hpsvcnb.fc.hp.com>
	<7vfypumlu3.fsf@assigned-by-dhcp.cox.net>
	<20051121180133.GA28171@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 20:32:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeHLq-0005s3-AO
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 20:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVKUT3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 14:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVKUT3P
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 14:29:15 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:24815 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932183AbVKUT3O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 14:29:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121192914.HODN25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 14:29:14 -0500
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20051121180133.GA28171@hpsvcnb.fc.hp.com> (Carl Baldwin's
	message of "Mon, 21 Nov 2005 11:01:33 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12470>

Carl Baldwin <cnb@fc.hp.com> writes:

> To follow-up on this.  Here is a final version of this script that was
> started by Junio.  I polished it and made it work the way I want it.
> Hopefully, someone on the list will find it useful.

Looking good.  We might want to have collections of user
contributed hooks, maybe a new directory examples/ perhaps?
