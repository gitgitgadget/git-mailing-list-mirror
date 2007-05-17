From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Commit ID in exported Tar Ball
Date: Thu, 17 May 2007 19:48:07 +0200
Message-ID: <20070517174807.GM5272@planck.djpig.de>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu May 17 19:48:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hok5r-0001BH-Dv
	for gcvg-git@gmane.org; Thu, 17 May 2007 19:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519AbXEQRsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 13:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759413AbXEQRsL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 13:48:11 -0400
Received: from planck.djpig.de ([85.10.192.180]:3634 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759688AbXEQRsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 13:48:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 440C688060;
	Thu, 17 May 2007 19:48:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCIeQQEgaggu; Thu, 17 May 2007 19:48:07 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id A05C688061; Thu, 17 May 2007 19:48:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200705171857.22891.johan@herland.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47546>

On Thu, May 17, 2007 at 06:57:22PM +0200, Johan Herland wrote:
> Hmm, doesn't seem like git-tar-tree (or git-archive for that matter) 
> supports this out of the box. Maybe it's possible to achieve in combination 
> with the $Id$ construct?

$Id$ contains the blob id, not the commit id.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
