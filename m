From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Thu, 02 Jun 2011 15:36:32 -0400
Message-ID: <1307043315-sup-5292@pinkfloyd.chass.utoronto.ca>
References: <loom.20110601T161508-689@post.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Randy Brandenburg <randy.brandenburg@woh.rr.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 22:25:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSESX-0005LQ-TJ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 22:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab1FBUZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 16:25:33 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:41865 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab1FBUZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 16:25:32 -0400
X-Greylist: delayed 2939 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jun 2011 16:25:32 EDT
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:46948 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1QSDh2-0006Hp-Ks; Thu, 02 Jun 2011 15:36:32 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1QSDh2-0003wF-Jv; Thu, 02 Jun 2011 15:36:32 -0400
In-reply-to: <loom.20110601T161508-689@post.gmane.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174975>

Excerpts from Randy Brandenburg's message of Wed Jun 01 10:16:32 -0400 2011:

Hi Randy,

> This is a Solaris 9 installation (git-1.7.5-sol9-sparc-local.gz
> obtained from Sunfreeware.com) including all of the required package
> dependencies listed.  I followed the same install on a Solaris 10
> box and have no issues. Not sure if this is a permissions issue or
> something not configured correctly.

Have you considered the OpenCSW git[1] packages?  I'm a little stale
at 1.7.3 right now but I have 1.7.5 ready to go...

It's built with thread support and should work on both 9 and 10.

Thanks
-Ben

[1] http://opencsw.org/packages/git
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
