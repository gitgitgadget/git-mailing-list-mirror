From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] gitweb(1) Fixed English issues
Date: Fri, 23 Mar 2012 10:52:54 -0400
Message-ID: <1332514314-sup-412@pinkfloyd.chass.utoronto.ca>
References: <0316A9BA-627B-4B43-8BF1-392DD7408146@bbn.com> <1332509111-sup-2763@pinkfloyd.chass.utoronto.ca> <53140318-34FA-4EF1-80F9-CFAD8828B3A1@bbn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: David Waitzman <djw@bbn.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 15:53:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB5rP-0000Hb-SW
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 15:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756506Ab2CWOwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 10:52:55 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:41903 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab2CWOwz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 10:52:55 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:59515 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SB5rK-0002kw-Bt; Fri, 23 Mar 2012 10:52:54 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SB5rK-0005ek-Ay; Fri, 23 Mar 2012 10:52:54 -0400
In-reply-to: <53140318-34FA-4EF1-80F9-CFAD8828B3A1@bbn.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193764>

Excerpts from David Waitzman's message of Fri Mar 23 10:49:55 -0400 2012:

Hi David,

> +The name of repository in gitweb is the path to its `$GIT_DIR` (its object
>  database) relative to `$projectroot`.  Therefore the repository $repo can be
>  found at "$projectroot/$repo".

Two _the_'s were missing in the original.  This should read:

The name of _the_ repository in gitweb is _the_ path to its...

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
