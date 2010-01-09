From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: For real now: bug tracking and secretary tasks in git
Date: Fri, 08 Jan 2010 17:54:40 -0800
Message-ID: <4B47E1E0.7040600@eaglescrag.net>
References: <20100109013850.16f82412@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Jan 09 02:57:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTQXh-0008HW-GN
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 02:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab0AIBys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 20:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369Ab0AIByr
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 20:54:47 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:52936 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab0AIByr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 20:54:47 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id o091seT8022279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jan 2010 17:54:41 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <20100109013850.16f82412@perceptron>
X-Enigmail-Version: 1.0
X-Virus-Scanned: ClamAV 0.88.7/10275/Fri Jan  8 17:06:46 2010 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Fri, 08 Jan 2010 17:54:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136509>

> The proposal goes like this:
> 
> * Set up bug tracker (done; it's at http://gitbugs.jk.gs/).
> * Optionally make it an official public bug tracker.

Is there a reason that the bug tracker should live outside of
kernel.org?  I mean pretty much everything official, the official source
tree for instance, already lives on kernel.org - wouldn't having the bug
tracker under the same domain make more sense?

I also thought there was some discussion about a distributed bug tracker
a while back for this, what ever came of that?  If I've been living
under a rock about those issues please pardon my ignorance.

- John 'Warthog9' Hawley
