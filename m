From: Lars Sadau <lars@sadau-online.de>
Subject: Re: BUG?? INSTALL MAKEFILE
Date: Wed, 7 Jan 2009 10:44:31 +0000 (UTC)
Message-ID: <loom.20090107T104303-14@post.gmane.org>
References: <49635BF8.1010700@sadau-online.de> <vpqiqosa3fc.fsf@bauges.imag.fr> <49638625.3090109@tedpavlic.com> <vpqzli45p6q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 12:01:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKWAE-0000I6-Gw
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 12:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbZAGLAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 06:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbZAGLAH
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 06:00:07 -0500
Received: from main.gmane.org ([80.91.229.2]:60748 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbZAGLAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 06:00:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LKW8p-0004Zo-Ah
	for git@vger.kernel.org; Wed, 07 Jan 2009 11:00:03 +0000
Received: from brocken.mathematik.hu-berlin.de ([141.20.54.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 11:00:03 +0000
Received: from lars by brocken.mathematik.hu-berlin.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 11:00:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 141.20.54.102 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.5) Gecko/2008121300 SUSE/3.0.5-0.1 Firefox/3.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104785>

Matthieu Moy <Matthieu.Moy <at> imag.fr> writes:

> 
> Ted Pavlic <ted <at> tedpavlic.com> writes:
> 
> > According to the INSTALL doc, the default prefix should be ~.

I am the same opinion


> I didn't read that in INSTALL. What I read is that if I only run "make
> install", the prefix is $HOME, which is true. Now, ./configure uses a
> default value which is not the one of the Makefile, but that's another
> point.
> 

May be not, confuses newbies.

------
Lars
