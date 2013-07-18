From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v4 2/2] git-svn: allow git-svn fetching to work using serf
Date: Thu, 18 Jul 2013 23:40:47 +0000
Message-ID: <20130718234047.GA17346@dcvr.yhbt.net>
References: <8a6adfae744011599e410da7a46808b@f74d39fa044aa309eaea14b9f57fe79>
 <ac83ba2812aee248275a0760bb39a00@f74d39fa044aa309eaea14b9f57fe79>
 <20130718192943.GT14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	David Rothenberger <daveroth@acm.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 01:49:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzxwy-0008Oz-Nt
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 01:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934911Ab3GRXt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 19:49:27 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47477 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933467Ab3GRXt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 19:49:26 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2013 19:49:26 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5501F5BD;
	Thu, 18 Jul 2013 23:40:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130718192943.GT14690@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230769>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> (cc-ing Eric Wong, who maintains git-svn and knows both it and
> the libsvn perl bindings much better than I do)

I doubt that's the case anymore.  I've hardly looked at SVN in many
years, now.

Anyways, if the patches:

1) do not introduce regressions
2) fixes real problems

I'm inclined to think they're OK...

I'm sorry I can't help more, I had access to better drugs back then.
