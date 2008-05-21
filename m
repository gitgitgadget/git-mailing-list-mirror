From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: [PATCH] Add format.date config variable
Date: Thu, 22 May 2008 02:27:35 +0300
Message-ID: <20080521232735.GB10527@jolt.modeemi.cs.tut.fi>
References: <20080518171306.GA12948@zakalwe.fi> <7vtzgr347p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 01:41:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyxvY-0003on-Vc
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 01:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760879AbYEUXjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 19:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760514AbYEUXjx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 19:39:53 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:65090 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761204AbYEUXjw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 19:39:52 -0400
X-Greylist: delayed 696 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 May 2008 19:39:52 EDT
Received: from amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69])
	by mail.cs.tut.fi (Postfix) with ESMTP id 517401574;
	Thu, 22 May 2008 02:28:11 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69]) (amavisd-maia, port 10024)
 with ESMTP id 02930-03-8; Thu, 22 May 2008 02:28:10 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 31C8A156E;
	Thu, 22 May 2008 02:28:05 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id DA67D22200;
	Thu, 22 May 2008 02:27:35 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id AB81A50563; Thu, 22 May 2008 02:27:35 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7vtzgr347p.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82587>

On Wed, May 21, 2008 at 11:24:42AM -0700, Junio C Hamano wrote:
> > Also, add missing "short" alternative to --date in rev-list-options.txt.
> 
> Good change but is a separate issue.  Please make it a [PATCH 1/2].

Will do that a separate patch.

> Lacking Sign-off.

OK. Thanks.

> The patch itself is good, especially that you made sure that format-patch
> output is not affected.
> 
> As to the configuration variable name, I'd suggest "log.date" instead.

OK.

Will submit a patch later today.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
