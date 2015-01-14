From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Big repo not shrinking on repack or gc?
Date: Wed, 14 Jan 2015 17:00:33 +0100
Message-ID: <20150114160033.GG13247@inner.h.apk.li>
References: <20150114115130.GA5677@inner.h.apk.li> <20150114124936.GC30383@peff.net> <20150114143946.GE13247@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 17:00:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBQNE-0002OW-Md
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 17:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbbANQAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 11:00:44 -0500
Received: from continuum.iocl.org ([217.140.74.2]:55775 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbbANQAn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 11:00:43 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t0EG0Yf14270;
	Wed, 14 Jan 2015 17:00:34 +0100
Content-Disposition: inline
In-Reply-To: <20150114143946.GE13247@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262390>

On Wed, 14 Jan 2015 15:39:46 +0000, Andreas Krey wrote:
...
> This is not the case. :-( (Done only with 1.8.2 due to
> lack of compilers for this box.)

Neither for current git (copied repo to other machine)
There is one new pack file of a plausible size (25G),
and 65G worth of old packfiles.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
