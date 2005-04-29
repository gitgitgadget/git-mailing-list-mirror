From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: Val Henson's critique of hash-based content storage systems
Date: Fri, 29 Apr 2005 16:41:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504291639590.32145@cag.csail.mit.edu>
References: <200504292037.NAA28344@emf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, robj@unrealities.com
X-From: git-owner@vger.kernel.org Fri Apr 29 22:38:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcFZ-0008Up-Qz
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVD2Umk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVD2Umk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:42:40 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:50870 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S262967AbVD2Ulk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:41:40 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DRcIr-0008EU-00; Fri, 29 Apr 2005 16:41:37 -0400
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504292037.NAA28344@emf.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Apr 2005, Tom Lord wrote:

> My point is simply that blob-db implementations should assume that the
> mathemeticians will succeed and take the small steps necessary to make
> sure that those bitstrings can't be used to crash a distributed
> blob-db infrastructure.

And my point is that you haven't *begun* to describe how one might use an 
arbitrary hash collision to "crash a distributed blob-db infrastructure".

Remember, first you've got to get some reference to your collision into 
the db...  (and if you can do that, why are you mucking around with hash 
collisions?)
   --scott

Philadelphia PBPRIME STANDEL for Dummies milita Richard Tomlinson 
ESSENCE SUMAC Nader KUCLUB WSHOOFS QKENCHANT AK-47 AMQUACK supercomputer
                          ( http://cscott.net/ )
