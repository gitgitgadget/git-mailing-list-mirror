From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Pack several linear commits into one
Date: Mon, 3 Dec 2007 10:28:59 +0100
Message-ID: <20071203092859.GA6259@xp.machine.xx>
References: <c0d4c9e90712030106u40b871ecjd5f7b8d078c8be36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacob Kroon <jacob.kroon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 10:29:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz7cE-0007kS-AB
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 10:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbXLCJ3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 04:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXLCJ3E
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 04:29:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:54333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750954AbXLCJ3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 04:29:03 -0500
Received: (qmail invoked by alias); 03 Dec 2007 09:29:00 -0000
Received: from p54AABA0D.dip0.t-ipconnect.de (EHLO localhost) [84.170.186.13]
  by mail.gmx.net (mp058) with SMTP; 03 Dec 2007 10:29:00 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19DiKEh6zRDaGDC1VeE1MZKVATHwcu5G2oxqbeEM1
	3SJdJ03pAswGbv
Content-Disposition: inline
In-Reply-To: <c0d4c9e90712030106u40b871ecjd5f7b8d078c8be36@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66893>

On Mon, Dec 03, 2007 at 10:06:11AM +0100, Jacob Kroon wrote:
> Hi,
> 
> Is there a tool for repacking several linear commits into one single ?
> 
> Please CC me since I'm not a subscriber to the list.
> 

Look for git merge --squash  or  git cherry-pick --no-commit

-Peter
