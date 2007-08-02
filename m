From: Allan Wind <allan_wind@lifeintegrity.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Thu, 2 Aug 2007 00:02:01 -0400
Message-ID: <20070802040201.GI23484@lifeintegrity.com>
References: <200708010216.59750.jnareb@gmail.com> <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org> <7vodhrby6f.fsf@assigned-by-dhcp.cox.net> <20070801092428.GB28106@thunk.org> <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net> <20070801220350.GD28106@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 02 06:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGSFl-0003Jx-CX
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 06:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbXHBEZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 00:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbXHBEZX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 00:25:23 -0400
Received: from vs690.rosehosting.com ([209.135.157.90]:56125 "EHLO
	lifeintegrity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbXHBEZV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 00:25:21 -0400
X-Greylist: delayed 1397 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Aug 2007 00:25:21 EDT
Received: from viento.lifeintegrity.com (pool-71-184-95-212.bstnma.fios.verizon.net [71.184.95.212])
	by submission.lifeintegrity.com (Postfix) with ESMTP id B5DB8D5C927;
	Thu,  2 Aug 2007 04:02:02 +0000 (UTC)
Received: by viento.lifeintegrity.com (Postfix, from userid 1000)
	id 5379B24821B; Thu,  2 Aug 2007 00:02:01 -0400 (EDT)
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070801220350.GD28106@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54511>

On 2007-08-01T18:03:50-0400, Theodore Tso wrote:
> Yeah, essentially, with a git-config option (and comand-line option)
> to override the default for those people who are "squeamish" about git
> clone -l.  Linus's suggestion of using file:// as a way to indicate
> non-local also makes a lot of sense to me.

I would expect /something and file:///something to behave exactly the 
same way (the latter just having bit extra syntax sugar).


/Allan
