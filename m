From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: How to reorganize git tree
Date: Thu, 26 Jan 2012 13:57:16 -0500
Message-ID: <1327604128-sup-1697@pinkfloyd.chass.utoronto.ca>
References: <20120126133505.it34vehs0044o848@webmail.xnet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Alan Edwards <kae@xnet.com>
X-From: git-owner@vger.kernel.org Thu Jan 26 19:57:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqUVf-00024I-Cb
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 19:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab2AZS5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 13:57:18 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:42355 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab2AZS5R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 13:57:17 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:44417 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RqUVY-0000nv-QG; Thu, 26 Jan 2012 13:57:16 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1RqUVY-0001m0-PM; Thu, 26 Jan 2012 13:57:16 -0500
In-reply-to: <20120126133505.it34vehs0044o848@webmail.xnet.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189159>

Excerpts from Alan Edwards's message of Thu Jan 26 13:35:05 -0500 2012:

Hi Alan,

> Any one have any suggestions?

I think that git filter-branch is going to be your friend here.  I
won't prescribe the details as you should definitely read and
understand the docs for this one, but things like
--subdirectory-filter and/or --tree-filter will be of great use to
you, I think.

Hope this helps.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
