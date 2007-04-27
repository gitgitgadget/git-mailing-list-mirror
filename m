From: Junio C Hamano <junkio@cox.net>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch content
Date: Fri, 27 Apr 2007 14:28:50 -0700
Message-ID: <7vk5vxmrql.fsf@assigned-by-dhcp.cox.net>
References: <ps5qyry4.fsf@cante.net> <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
	<87y7kdo6pn.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 23:28:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhXzr-00046X-Qu
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 23:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334AbXD0V2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 17:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbXD0V2w
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 17:28:52 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55486 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757334AbXD0V2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 17:28:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427212851.ZZUQ1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 17:28:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sMUq1W0041kojtg0000000; Fri, 27 Apr 2007 17:28:50 -0400
In-Reply-To: <87y7kdo6pn.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	27 Apr 2007 14:20:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45756>

Carl Worth <cworth@cworth.org> writes:

> My MUA doesn't have support (that I know of) for piping a sequence of
> messages to a command. Do your MUAs? If not, how do people generally
> handle long sequences of [n/N] patch emails?

Are you asking _me_ specifically?  Assuming so,

Yes, my MUA does allow "next N messages" or "selected messages"
to be given to an external program.

But I typically save them in a separate mailbox for reviewing
and in-editor fixups before applying, so "next N messages" are
useful to me for saving but not applying.
