From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: How to embed a hash, tag or branch name?
Date: Fri, 31 Jul 2009 11:17:23 +0300
Message-ID: <20090731081723.GE29909@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 10:22:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWnNZ-0008G1-Hx
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 10:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbZGaIWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 04:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbZGaIWH
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 04:22:07 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:54150 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZGaIWH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 04:22:07 -0400
Received: from nalle.dyndns.tv (84.251.89.185) by kirsi1.inet.fi (8.5.014)
        id 49F6055A033084AD for git@vger.kernel.org; Fri, 31 Jul 2009 11:22:05 +0300
Received: from mcfrisk by nalle.dyndns.tv with local (Exim 4.63)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1MWnIp-0007rW-Pa
	for git@vger.kernel.org; Fri, 31 Jul 2009 11:17:23 +0300
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124510>

How do I embed a hash, tag or branch name into source code managed by
git?

I've tried searching the net, git manuals etc but haven't found a
replacement for the old '$Id: $' strings from svn. What I need is a way to
map compiled binaries and flash images to git tree heads, tags and
branches.

Thanks,

-Mikko
