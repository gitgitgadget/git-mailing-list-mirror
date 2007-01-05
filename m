From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-remote
Date: Thu, 04 Jan 2007 19:07:38 -0800
Message-ID: <7vodpejhmt.fsf@assigned-by-dhcp.cox.net>
References: <7vfyarokk7.fsf@assigned-by-dhcp.cox.net>
	<20070105030245.GC14042@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 04:07:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2fQk-00089a-LN
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 04:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbXAEDHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 22:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbXAEDHk
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 22:07:40 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:52777 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030276AbXAEDHj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 22:07:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105030739.QOJR18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jan 2007 22:07:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7F7t1W00Z1kojtg0000000; Thu, 04 Jan 2007 22:07:54 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070105030245.GC14042@spearce.org> (Shawn O. Pearce's message
	of "Thu, 4 Jan 2007 22:02:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35974>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> It might be handy to have a single command that helps you manage
>> your configuration that relates to downloading from remote
>> repositories.  This currently does only about 20% of what I want
>> it to do.
>> 
>> 	$ git remote
>
> This is pretty cool.  It would be nice if something like it was
> in 1.5.0.  ;-)

Hmph.

By the way, do you have comments on my counterproposal for
lockfile fix?
