From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] link in gitweb rss feed
Date: Wed, 22 Jun 2005 11:25:13 +0200
Message-ID: <20050622092513.GA7629@vrfy.org>
References: <20050615174148.C3099@banaan.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 22 11:22:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dl1Q9-0008EN-QC
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 11:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVFVJ0R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVFVJ0Q
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 05:26:16 -0400
Received: from soundwarez.org ([217.160.171.123]:45484 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262921AbVFVJZR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 05:25:17 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 28364423DA; Wed, 22 Jun 2005 11:25:13 +0200 (CEST)
To: Erik van Konijnenburg <ekonijn@xs4all.nl>
Content-Disposition: inline
In-Reply-To: <20050615174148.C3099@banaan.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2005 at 05:41:48PM +0200, Erik van Konijnenburg wrote:
> The following patch makes the site name in an RSS
> feedreader for a gitweb project refer to the summary
> page for the the project, the same place where you picked
> up the feed in the first place.  This seems more consistent
> than linking to the overview of all projects where the
> link used to up.  Changed the link in OPML feed accordingly;
> this used to end up in the full log rather than the summary.
> 
> Patch was made against version 220 as shipped in Debian,
> and applies (with offset) to your version 221.

Should be installed with the last update on kernel.org.

Thanks,
Kay
