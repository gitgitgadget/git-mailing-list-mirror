From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 08 May 2007 22:05:36 -0700
Message-ID: <7v4pmmzivz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
	<20070509031803.GA27980@fieldses.org>
	<7vps5azlm1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed May 09 07:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HleN2-0003hi-I7
	for gcvg-git@gmane.org; Wed, 09 May 2007 07:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967303AbXEIFFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 01:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754909AbXEIFFi
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 01:05:38 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62825 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbXEIFFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 01:05:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509050538.JSDW22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 01:05:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wt5c1W00R1kojtg0000000; Wed, 09 May 2007 01:05:37 -0400
In-Reply-To: <7vps5azlm1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 08 May 2007 21:06:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46662>

Junio C Hamano <junkio@cox.net> writes:

> "J. Bruce Fields" <bfields@fieldses.org> writes:
>
>> The organization of the next bit is slightly confusing: we're set up to
>> expect a longer lecture on the revision walker, but instead there's just
>> the historical note on git-rev-list, a mention of 'revision.c',
>> 'revision.h', and 'struct rev_info', and then it rapidly digresses into
>> discussing builtins.
>
> I had the same impression.
>
> I was meaning to write a "code walkthru for git hackers and
> wannabes" with target audience quite different from the
> user-manual.  My idea of which areas to cover in what order
> seems to match with what Johannes started.

Having said that, I do not think the patch belongs to the "git
USER'S manual".  It is a very good introductory material for a
separate "git hackers manual", though.
