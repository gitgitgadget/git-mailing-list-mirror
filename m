From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] gitweb(1): Fixed improper use of "it's" when it should be "its"
Date: Fri, 23 Mar 2012 09:27:02 -0400
Message-ID: <1332509111-sup-2763@pinkfloyd.chass.utoronto.ca>
References: <0316A9BA-627B-4B43-8BF1-392DD7408146@bbn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: David Waitzman <djw@bbn.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 15:41:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB5g0-000776-K8
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 15:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756178Ab2CWOlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 10:41:07 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:41870 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476Ab2CWOlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 10:41:06 -0400
X-Greylist: delayed 4442 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Mar 2012 10:41:06 EDT
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:59469 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SB4WE-00021N-H9; Fri, 23 Mar 2012 09:27:02 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SB4WE-00053U-G8; Fri, 23 Mar 2012 09:27:02 -0400
In-reply-to: <0316A9BA-627B-4B43-8BF1-392DD7408146@bbn.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193762>

Excerpts from David Waitzman's message of Fri Mar 23 09:13:44 -0400 2012:

Hi David,

> This is a trivial patch to correct the english in the man page.

Good catch!

> -The name of repository in gitweb is path to it's `$GIT_DIR` (it's object
> +The name of repository in gitweb is path to its `$GIT_DIR` (its object


Might I suggest that this be:

+The name of the repository in gitweb is the path to its `$GIT_DIR` (its object

Note the inserted _the_'s.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
