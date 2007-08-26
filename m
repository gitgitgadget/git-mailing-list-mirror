From: Junio C Hamano <gitster@pobox.com>
Subject: Re: user-manual patches
Date: Sun, 26 Aug 2007 14:26:27 -0700
Message-ID: <7vodgung1o.fsf@gitster.siamese.dyndns.org>
References: <20070826162050.GA28795@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Aug 26 23:26:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPPcw-0005Ak-6U
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 23:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbXHZV0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 17:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbXHZV03
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 17:26:29 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58816 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbXHZV02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 17:26:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070826212629.RJPL10742.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 26 Aug 2007 17:26:29 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id glSU1X0051gtr5g0000000; Sun, 26 Aug 2007 17:26:28 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56736>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Sun, Aug 26, 2007 at 12:16:56PM -0400, J. Bruce Fields wrote:
>> 
>> The following changes are available from the "maint" branch at:
>> 
>>   ssh://linux-nfs.org/~bfields/exports/git.git maint
>
> Um, sorry for the duplicates.  I'm clearly not competent to operation
> git-send-email.
>
> Also one chunk from David Kastrup's gitlink fixes only applied to
> master, so I applied the whole thing there, did a merge, and pushed the
> result to my master branch.  If that was the right thing to do, then I
> guess you can just pull from both of
>
> 	git://linux-nfs.org/~bfields/git	maint
> 	git://linux-nfs.org/~bfields/git	master
>
> ?

Thanks.  I'd imagined just I'd just merge your master and
everything would be fine, as your maint would be an ancestor of
your maint.  And it indeed went fine ;-)
