From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 22:24:31 +0200
Message-ID: <20080911202431.GH1451@cuci.nl>
References: <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu> <20080911190335.GB1451@cuci.nl> <alpine.LFD.1.10.0809111527030.23787@xanadu.home> <20080911194447.GD1451@cuci.nl> <alpine.LFD.1.10.0809111601280.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:26:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdsjT-0001ce-Hg
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbYIKUYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 16:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYIKUYc
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:24:32 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:34524 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbYIKUYc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 16:24:32 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 286475465; Thu, 11 Sep 2008 22:24:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809111601280.23787@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95641>

Nicolas Pitre wrote:
>On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
>> Well, the principle of least surprise dictates that they should be kept
>> by gc as described above, however...
>> I can envision an option to gc say "--drop-weak-links" which does
>> exactly what you describe.

>Don't you think this starts to look silly at that point?

No, it's the developers vote controlling his own repository saying:
Ok, I expressed interest in the other branches and their
backport/forwardport relationships, but I changed my mind.  Drop all
backport/forwardport information on branches I don't explicitly have.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
