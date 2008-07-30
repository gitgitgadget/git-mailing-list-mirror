From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Gitweb: Provide Git links in project list?
Date: Wed, 30 Jul 2008 08:49:30 -0700
Message-ID: <1217432970.2884.8.camel@localhost.localdomain>
References: <20080730125743.GY15356@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Richter <robert.richter@amd.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 17:50:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KODwn-0006vI-3w
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 17:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbYG3Ptk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 11:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbYG3Ptk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 11:49:40 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:53360 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbYG3Ptj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 11:49:39 -0400
Received: from [172.19.0.93] (c-67-188-226-86.hsd1.ca.comcast.net [67.188.226.86])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m6UFnZSK005403
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 08:49:36 -0700
In-Reply-To: <20080730125743.GY15356@erda.amd.com>
X-Mailer: Evolution 2.12.3 (2.12.3-4.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/7891/Wed Jul 30 03:03:53 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Wed, 30 Jul 2008 08:49:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90809>

Robert,

That is a kernel.org specific change - if the community at large wants
it I can dig the patch out (I likely didn't do it as it's own patch when
I did it, being young, naive and stupid at the time - I'm now slightly
older and slightly less naive now ;-)

But yeah - if people feel that's interesting I'm happy to rip it out
later today and submit it to the mailing list.

- John 'Warthog9' Hawley

On Wed, 2008-07-30 at 14:57 +0200, Robert Richter wrote:
> The Gitweb on git.kernel.org povides links to the Git repository for
> each project (git <git://...>). However, I did not find this feature
> in the current implementation of git_project_list_body(). Does
> somebody know if there is a patch available for this and if this could
> be added to gitweb?
> 
> Thanks,
> 
> -Robert
> 
