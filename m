From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git-push segfault
Date: Wed, 24 Feb 2010 11:49:11 +0100
Message-ID: <20100224104911.GA24765@inner.home.ulmdo.de>
References: <loom.20100224T043557-954@post.gmane.org> <20100224063606.GB12796@coredump.intra.peff.net> <20100224082214.GA31559@inner.home.ulmdo.de> <20100224092356.GA28959@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dale Rowley <ddrowley3@juno.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:49:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkEo4-00012d-CK
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 11:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613Ab0BXKtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 05:49:22 -0500
Received: from continuum.iocl.org ([213.146.114.200]:63645 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561Ab0BXKtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 05:49:22 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o1OAnBu25958;
	Wed, 24 Feb 2010 11:49:11 +0100
Content-Disposition: inline
In-Reply-To: <20100224092356.GA28959@coredump.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140925>

On Wed, 24 Feb 2010 04:23:57 +0000, Jeff King wrote:
> On Wed, Feb 24, 2010 at 09:22:14AM +0100, Andreas Krey wrote:
...
> > How about 'set -xe' instead of all the &&?
...
> At any rate, this is not even code for inclusion in git.

That was why I was asking. In throwaway scripts -e as well as -x is
rather practical (esp. the latter); I wouldn't use that in 'real'
scripts. Probably it's better not to set a bad example in posted
throwaway scripts, though. :-)

Andreas
