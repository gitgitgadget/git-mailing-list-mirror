From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: fatal: serious inflate inconsistency
Date: Sun, 17 Jun 2007 10:01:43 +0200
Message-ID: <20070617080143.GG23473@cip.informatik.uni-erlangen.de>
References: <20070608110536.GD2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 17 10:01:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzphi-0006Of-G8
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 10:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbXFQIBp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 04:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbXFQIBp
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 04:01:45 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:39340 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753593AbXFQIBo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2007 04:01:44 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id DBFDC3F42C; Sun, 17 Jun 2007 10:01:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070608110536.GD2335@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50337>

Hello,
the machine came back with a new power supply. And guess what:

(tomcat-05) [/usr/src] git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Initialized empty Git repository in /usr/src/linux-2.6/.git/
remote: Generating pack...
remote: Done counting 499634 objects.
remote: Deltifying 499634 objects...
remote:  100% (499634/499634) done
Indexing 499634 objects...
remote: Total 499634 (delta 403845), reused 495761 (delta 400337)
100% (499634/499634) done
Resolving 403845 deltas...
100% (403845/403845) done
Checking 22411 files out...
100% (22411/22411) done

        Thomas
