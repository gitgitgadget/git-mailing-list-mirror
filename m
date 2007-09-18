From: Ben Konrath <bkonrath@redhat.com>
Subject: Re: [EGIT PATCH] Add feature and plugin.
Date: Tue, 18 Sep 2007 17:20:16 -0400
Message-ID: <1190150416.21540.0.camel@plug>
References: <20070917185310.GA6042@toast.toronto.redhat.com>
	 <46EF81BD.7010609@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 18 23:21:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXkVk-0000yQ-NF
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 23:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbXIRVUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 17:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbXIRVUq
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 17:20:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37907 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbXIRVUp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 17:20:45 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8ILKevF007921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Sep 2007 17:20:40 -0400
Received: from pobox.toronto.redhat.com (pobox.toronto.redhat.com [172.16.14.4])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8ILKQWr021259;
	Tue, 18 Sep 2007 17:20:40 -0400
Received: from [127.0.0.1] (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.toronto.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l8ILKOwK022943;
	Tue, 18 Sep 2007 17:20:25 -0400
In-Reply-To: <46EF81BD.7010609@op5.se>
X-Mailer: Evolution 2.10.3 (2.10.3-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58634>

On Tue, 2007-09-18 at 09:43 +0200, Andreas Ericsson wrote:
> Ben Konrath wrote:
> > Hi,
> > 
> > I made a feature and associated branding plugin for Egit. Including
> > these two plugins allows us to build Egit for Fedora but it also makes
> > it easy to create an update site for Egit.
> 
> 
> 
> > These two plugins also add an
> > entry for Egit in Help -> About Eclipse -> Feature Details. 
> > 
> 
> When you start writing "also" in your commit messages, it's a pretty good
> sign that you should have made many smaller commits rathern than one large.

Ok thanks. I think that I could have split this up into two commits.
I'll take that into consideration for future work.

Cheers, Ben
