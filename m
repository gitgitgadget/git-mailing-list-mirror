From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 11:11:53 +0200
Message-ID: <200707261111.54439.robin.rosenberg.lists@dewire.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com> <7v6447bxc1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707260614500.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 11:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDzMv-00063u-Jv
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 11:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759324AbXGZJKq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 05:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759186AbXGZJKq
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 05:10:46 -0400
Received: from [83.140.172.130] ([83.140.172.130]:1111 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758539AbXGZJKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 05:10:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E0E1880266C;
	Thu, 26 Jul 2007 11:03:26 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18229-04; Thu, 26 Jul 2007 11:03:26 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 5614B80264B;
	Thu, 26 Jul 2007 11:03:26 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0707260614500.14781@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53810>

torsdag 26 juli 2007 skrev Johannes Schindelin:
> Hi,
> 
> On Wed, 25 Jul 2007, Junio C Hamano wrote:
> 
> > If that is the case, "Git for Windows" probably should package MSYS as 
> > part of it, I would think, to match the expectation of the users there.  
> > I know two Johannes'es and Han-Wen spent quite a lot of effort on 
> > Windows port and packaging, but perhaps that little (well, I should not 
> > be judging if that is a little or huge, as I do not do Windows) 
> > finishing touch would make Windows users much happier?
> 
> Windows users are only happy when they can bug developers.
> 
> Seriously again, the biggest problem with Han-Wen's installer was that it 
> insists on cross-compiling _all_ the packages.  This makes it easy for 
> Han-Wen to upgrade packages and compile the thing on Linux in one go.  
> However, it never worked with bash, and I could not fix it: I can read 
> Python, but not _that_ Python.

Will windows developers need to get Linux just in order to do a two line fix,
or will the build process work on Windows too (provided the developer gets
a number of extra packages).

-- robin
