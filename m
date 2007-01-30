From: Junio C Hamano <junkio@cox.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 13:32:28 -0800
Message-ID: <7vwt34xksz.fsf@assigned-by-dhcp.cox.net>
References: <87odognuhl.wl%cworth@cworth.org> <epobn1$jv8$1@sea.gmane.org>
	<20070130212511.GA5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Carl Worth <cworth@cworth.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 22:32:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC0aj-0005y8-2e
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 22:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbXA3Vce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 16:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbXA3Vce
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 16:32:34 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44182 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbXA3Vcd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 16:32:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070130213233.KFQJ3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jan 2007 16:32:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HZYU1W0091kojtg0000000; Tue, 30 Jan 2007 16:32:28 -0500
In-Reply-To: <20070130212511.GA5362@nan92-1-81-57-214-146.fbx.proxad.net>
	(Yann Dirson's message of "Tue, 30 Jan 2007 22:25:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38207>

Yann Dirson <ydirson@altern.org> writes:

> On Tue, Jan 30, 2007 at 10:02:40PM +0100, Jakub Narebski wrote:
>> > I propose this warning be removed here. Otherwise, I either add text
>> > to my instructions telling the user to ignore the warning message they
>> > get, or else I go back to "-b build" and back to all the old problems
>> > it causes.
>> 
>> I rather leave warning, but (perhaps around 1.5.1) remove the
>> instructions. RTFM (err... I'm not sure we have one about detached HEAD).
>
> Or provide a "-q" flag to silence the warning ?

Or maybe make "-f" to mean "I know what I am doing, do not
warn".

P.S. Jakub, *please* do not break the thread.
