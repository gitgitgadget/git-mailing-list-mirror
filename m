From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [FILE] GNU BIT
Date: Mon, 25 Apr 2005 11:37:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504251134090.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504242308460.6454@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 17:33:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ5Z9-0007AZ-P4
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 17:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVDYPhA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 11:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVDYPhA
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 11:37:00 -0400
Received: from iabervon.org ([66.92.72.58]:8964 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262639AbVDYPg4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 11:36:56 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQ5dt-00010V-00; Mon, 25 Apr 2005 11:37:01 -0400
To: Andreas Gal <gal@uci.edu>
In-Reply-To: <Pine.LNX.4.58.0504242308460.6454@sam.ics.uci.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005, Andreas Gal wrote:

> http-pull -a `cat .git/HEAD` \
>     http://nil.ics.uci.edu/~gal/public/bit

Don't forget the slash at the end... (one of us should probably fix that
at some point; just stick a slash at the end of any URL without one)

Also, it has become customary to have URLs like .../public/bit.git/, since
the contents match a .git directory.

	-Daniel
*This .sig left intentionally blank*

