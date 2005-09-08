From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb feature request: tarball for each commit
Date: Thu, 8 Sep 2005 13:32:07 +0200
Message-ID: <20050908113207.GA30178@vrfy.org>
References: <46a038f905090721305dcbf61@mail.gmail.com> <20050908084545.GH15165MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 08 13:32:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDKdZ-0007QG-Vw
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 13:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVIHLcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 07:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVIHLcK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 07:32:10 -0400
Received: from soundwarez.org ([217.160.171.123]:27103 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932449AbVIHLcJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 07:32:09 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 7B0205F353; Thu,  8 Sep 2005 13:32:07 +0200 (CEST)
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050908084545.GH15165MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8198>

On Thu, Sep 08, 2005 at 10:45:45AM +0200, Sven Verdoolaege wrote:
> On Thu, Sep 08, 2005 at 04:30:22PM +1200, Martin Langhoff wrote:
> > Actually... should get it done. I'll see if I can sneak it in sometime soon... 
> 
> This has been done at least twice already.
> See e.g., http://www.liacs.nl/~sverdool/gitweb.cgi?p=gitweb.git;a=summary
> Check the archives for the other implementation.

Yes, this is nice for smaller projects. But I don't think, that we want
to do such a thing on the kernel.org servers. We already have the daily
snapshots and individual patches can be downloaded from gitweb. Anybody
else should use git/cogito instead of letting the server packaging a huge
tree for every requested revison, I think.

Kay
