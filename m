From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 17:56:09 -0700
Message-ID: <7vpsjecriu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 02:56:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW0zP-00010E-LE
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 02:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWDSA4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 20:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDSA4M
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 20:56:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:25296 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750936AbWDSA4L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 20:56:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419005610.OAQH18566.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 20:56:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Apr 2006 16:45:16 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18895>

Linus Torvalds <torvalds@osdl.org> writes:

> 	git diff v0.99.6:git-commit-script..v1.3.0:git-commit.sh

This is interesting.

Yet to be born "internal diff".  Should I start one, or are you
already hacking on it?
