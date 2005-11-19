From: Junio C Hamano <junkio@cox.net>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Fri, 18 Nov 2005 16:00:36 -0800
Message-ID: <7vzmo1ecbf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
	<7v1x1eubpr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
	<Pine.LNX.4.64.0511171520390.13959@g5.osdl.org>
	<20051118121210.GA19714@abridgegame.org>
	<Pine.LNX.4.63.0511181419340.28109@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0511180806550.25159@shark.he.net>
	<Pine.LNX.4.64.0511180857170.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:25:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdG9p-0003tj-2z
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 01:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVKSAAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 19:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVKSAAi
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 19:00:38 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:9867 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751120AbVKSAAh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 19:00:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051119000038.XLCE25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 19:00:38 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511180857170.13959@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 18 Nov 2005 09:00:38 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12305>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 18 Nov 2005, Randy.Dunlap wrote:
>>
>> ~Randy  [who would just use ISO standard date format]
>
> That actually _does_ work, and has done so since the beginning:
>
>    [torvalds@g5 git]$ ./test-date "2005-11-02 14:45:00"

Doesn't ISO spell that as "2005-11-02T14:45:00"?
