From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Add feature and plugin.
Date: Tue, 18 Sep 2007 21:06:46 +0200
Message-ID: <200709182106.46649.robin.rosenberg.lists@dewire.com>
References: <20070917185310.GA6042@toast.toronto.redhat.com> <46EF81BD.7010609@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Ben Konrath <bkonrath@redhat.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:06:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXiOK-0007HK-9e
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 21:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbXIRTEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 15:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755628AbXIRTEw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 15:04:52 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14028 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755130AbXIRTEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 15:04:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0E3F58028AE;
	Tue, 18 Sep 2007 20:56:41 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14485-10; Tue, 18 Sep 2007 20:56:40 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 95982802868;
	Tue, 18 Sep 2007 20:56:40 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46EF81BD.7010609@op5.se>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58629>

tisdag 18 september 2007 skrev Andreas Ericsson:
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

Seems it is a hint about what can be done later. That's generally something to
put in cover messages. 

The ability to create an update site encouraged me to create one too. It makes
updating all my eclipses much easier. Thanks Ben.

I've merged and pushed the earlier version before receiving this version whose
content comes as a follow up commit.

-- robin
