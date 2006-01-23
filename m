From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 00:00:54 -0800
Message-ID: <7vy817z83t.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 23 09:01:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0wdK-00012h-5B
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 09:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWAWIA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 03:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWAWIA7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 03:00:59 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41641 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751407AbWAWIA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2006 03:00:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060123080100.BMJP25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 Jan 2006 03:01:00 -0500
To: git@vger.kernel.org
In-Reply-To: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 22 Jan 2006 17:35:14 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15079>

Junio C Hamano <junkio@cox.net> writes:

> This is still a draft/WIP, but "release early" is a good
> discipline, so...

Tentatively I'm placing this document in the 'todo' branch, so
that people interested in the changes can ask gitweb to show
diffs, until I can find a better way and location to manage it.

I do not think it is suitable to be in the Documentation/ area,
due to its being an early draft and its just-one-ofthe-proposals
status.
