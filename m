From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: git-fast-export hg mutt (24M vs 184M)
Date: Thu, 3 May 2007 21:17:16 +0200
Message-ID: <20070503191716.GB11817@cip.informatik.uni-erlangen.de>
References: <20070503185623.GA11817@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 03 21:17:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjgnp-0003yn-Rp
	for gcvg-git@gmane.org; Thu, 03 May 2007 21:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766543AbXECTRS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 15:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767739AbXECTRS
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 15:17:18 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:62306 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1766543AbXECTRS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 15:17:18 -0400
X-Greylist: delayed 1252 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 May 2007 15:17:18 EDT
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id DDCD63F319; Thu,  3 May 2007 21:17:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070503185623.GA11817@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.14 (2007-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46096>

Hello,
git-repack -a -d -f got it down to 19M. I missed the -f parameter
before. Sorry for the noise.

        Thomas
