From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Mon, 15 Aug 2005 01:08:44 -0400
Message-ID: <20050815050844.GB7001@mythryan2.michonline.com>
References: <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org> <20050811202410.GB5411@kiste.smurf.noris.de> <42FBCD73.3090507@chandlerfamily.org.uk> <pan.2005.08.12.08.34.45.679778@smurf.noris.de> <Pine.LNX.4.62.0508120139230.19902@qynat.qvtvafvgr.pbz> <20050812103555.GG5411@kiste.smurf.noris.de> <20050813235716.GB6844@mythryan2.michonline.com> <20050814001148.GV5411@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 07:09:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4XDc-0004Us-Oc
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 07:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVHOFIx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 01:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVHOFIx
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 01:08:53 -0400
Received: from mail.autoweb.net ([198.172.237.26]:17363 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1750994AbVHOFIx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 01:08:53 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E4XDK-0004dK-Um; Mon, 15 Aug 2005 01:08:47 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E4XDJ-0005J9-00; Mon, 15 Aug 2005 01:08:45 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E4XDI-0000x6-Gz; Mon, 15 Aug 2005 01:08:44 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050814001148.GV5411@kiste.smurf.noris.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 14, 2005 at 02:11:50AM +0200, Matthias Urlichs wrote:
> Hi,
> 
> Ryan Anderson:
> > 
> > 	#!/bin/sh
> > 	echo "Don't get a git - use gt!
> Ouch.

:)  I meant it as a joke, obviously.  I also thinkoed the sentence I was
aiming for, thus losing the humor.  Oh well.

> > 	echo "Don't get a git - use gt!" >&2
> if at all.

True.

On this same topic, cogito seems to be consistently using the long forms
of the names (i.e, git-*-script), so renaming "git" in the core Debian
package should not be a problem, other than for the canned recipes
people are writing constantly to demonstrate the power of git.

-- 

Ryan Anderson
  sometimes Pug Majere
