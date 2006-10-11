From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] paginate git-diff by default
Date: Tue, 10 Oct 2006 17:57:58 -0700
Message-ID: <7vwt77y8h5.fsf@assigned-by-dhcp.cox.net>
References: <20061010181337.GE8612@admingilde.org>
	<20061010181558.GB16972@spearce.org>
	<20061010191625.GF8612@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 02:58:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXSQB-0006wG-82
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 02:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWJKA6A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 20:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWJKA6A
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 20:58:00 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34194 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965067AbWJKA57 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 20:57:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011005759.BMXX28934.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 20:57:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yoy11V00c1kojtg0000000
	Tue, 10 Oct 2006 20:58:02 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20061010191625.GF8612@admingilde.org> (Martin Waitz's message of
	"Tue, 10 Oct 2006 21:16:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28687>

Martin Waitz <tali@admingilde.org> writes:

> On Tue, Oct 10, 2006 at 02:15:58PM -0400, Shawn Pearce wrote:
>> Martin Waitz <tali@admingilde.org> wrote:
>> > I always find myself typing "git -p diff".
>> > Should we paginate git-diff output by default?
>>
>> I agree.  I'm very used to git log automatically running my $PAGER;
>> I'm always surprised that git diff doesn't do the same when attached
>> to my tty.

Hmm.  So close to 1.4.3...  Will take it.
