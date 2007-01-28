From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Sun, 28 Jan 2007 12:06:31 -0800
Message-ID: <7vd54yex14.fsf@assigned-by-dhcp.cox.net>
References: <7vps90nbbv.fsf@assigned-by-dhcp.cox.net>
	<17852.64183.371967.470683@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sun Jan 28 21:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBGIQ-00054W-BS
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 21:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbXA1UGd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 15:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932806AbXA1UGd
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 15:06:33 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44628 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805AbXA1UGc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 15:06:32 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128200632.LOPG29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 15:06:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Gk5Z1W00T1kojtg0000000; Sun, 28 Jan 2007 15:05:34 -0500
In-Reply-To: <17852.64183.371967.470683@lisa.zopyra.com> (Bill Lear's message
	of "Sun, 28 Jan 2007 13:34:15 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38046>

Bill Lear <rael@zopyra.com> writes:

> On Saturday, January 27, 2007 at 00:05:56 (-0800) Junio C Hamano writes:
>>I am hoping that we can declare -rc3 and go into a deep freeze
>>after merging Shawn's "describe with accumulated commits since"
>>and Nico's "reflog on HEAD", perhaps by end of the month.
>
> Was there any final decision on allowing pushes through git-daemon?

Not really.  I personally think it is Ok as long as the default
stays disabled as Linus posted.
