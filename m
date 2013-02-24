From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: Load testing of git
Date: Sun, 24 Feb 2013 11:54:28 -0600
Message-ID: <20130224175427.GA4691@unpythonic.net>
References: <CAGjB8pR+uByiJJikBXbaxUZO4rDgyfvJ31agxaQuWrMwSS1N7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yuri Mikhailov <yuri.mikhaylov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 18:54:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9fmq-0000Pa-HT
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 18:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758486Ab3BXRyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 12:54:32 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:43583 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758025Ab3BXRyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 12:54:31 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id 737BE114579; Sun, 24 Feb 2013 11:54:28 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <CAGjB8pR+uByiJJikBXbaxUZO4rDgyfvJ31agxaQuWrMwSS1N7Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216996>

In 2012 there was a thread about git's performance on large
repositories.  One archive of the discussion begins here:
http://mid.gmane.org/CB5074CF.3AD7A%25joshua.redstone%40fb.com

> The test repo has 4 million commits, linear history and about 1.3
> million files.

I'm not sure to what extent git performance may have changed since then,
e.g., by improving the index format.

Jeff
