From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: requirements to compile git-svn support
Date: Thu, 2 Jul 2009 13:55:55 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.0907021352300.24169@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:57:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMQX8-0007SO-4z
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 19:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbZGBR5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 13:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbZGBR5I
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 13:57:08 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:35770 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750874AbZGBR5H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 13:57:07 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n62Htuub016218;
	Thu, 2 Jul 2009 13:55:56 -0400 (EDT)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n62HttNq018735;
	Thu, 2 Jul 2009 13:55:55 -0400 (EDT)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122661>

On Thu, 2009-07-02 at 16:02 +0200, Graeme Geldenhuys wrote:
> I'm running Ubuntu 8.04 and compiled Git 1.6.2.2 and previously some 
> other 1.6.x release and every time git-svn is nowhere to be found. What 
> do I need to do / install to get git-svn available?

I maintain up-to-date Git packages for Ubuntu 8.04, 8.10, and 9.04 at
https://launchpad.net/~git-core/+archive/ppa
including a git-svn package.

Note that the command you actually need to run is `git svn`, not 
`git-svn`.

Anders
