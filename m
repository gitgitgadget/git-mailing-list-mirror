From: layer <layer@known.net>
Subject: how to find all changes since last push?
Date: Thu, 05 Feb 2009 09:29:08 -0800
Message-ID: <30903.1233854948@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 18:42:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8El-0001Se-R4
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 18:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbZBERkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 12:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbZBERkh
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 12:40:37 -0500
Received: from relay.known.net ([67.121.255.169]:58398 "HELO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752287AbZBERkg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 12:40:36 -0500
X-Greylist: delayed 688 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Feb 2009 12:40:36 EST
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.17) id 000000022636; Thu, 5 Feb 2009 09:29:08 -0800
X-Mailer: MH-E 8.1; nmh 1.3; GNU Emacs 22.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108589>

I'm a git noob, and I'm trying to move my organization to it from CVS
(which we've used since 1991).  Currently stuck on this:

I think a natural style of development using git would be to do a
series of commits to my local repo and when things are stable, do a
push somewhere or collect all the changes into a patch.

I have googled and looked at documentation, but I cannot figure out
how to find all changes since my last push.  To make this more
complex, I'd like intervening pull's not to interfere with my ability
to find all changes since the last push.

Thanks.

Kevin
