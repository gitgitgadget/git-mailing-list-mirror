From: Junio C Hamano <junkio@cox.net>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 09:06:21 -0700
Message-ID: <7vll1trqiq.fsf@assigned-by-dhcp.cox.net>
References: <20050919134838.GC2903@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 18:07:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHOAN-0002T9-MG
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVISQGt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVISQGt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:06:49 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52359 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932481AbVISQGs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 12:06:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919160621.NAST25410.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 12:06:21 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050919134838.GC2903@pasky.or.cz> (Petr Baudis's message of
	"Mon, 19 Sep 2005 15:48:38 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8878>

Petr Baudis <pasky@suse.cz> writes:

>   Well, I have to say that from the GECOS fields I saw, none use that
> format, but a lot of them used the realname,phone,something,phone,...
> format.

>   Opinions?

If the real world GECOS were either only plain and
name,room,blah,... format as you say and assume I think a
heuristics like you suggested would be better than the
current heuristics of assuming everything is a name, but I
haven't seen what "angry mob" actually has so cannot judge.

What do popular MUAs do to come up with the real-name fields?
Don't they face the same problem, trying to using GECOS?
