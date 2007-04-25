From: Tim Ansell <mithro@mithis.com>
Subject: [Feature Request] Download transfer rate display
Date: Wed, 25 Apr 2007 17:53:22 +0930
Organization: MITHIS
Message-ID: <1177489402.12689.42.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 10:24:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgcnC-0002SU-7b
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 10:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423284AbXDYIXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 04:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423287AbXDYIXv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 04:23:51 -0400
Received: from lester.mithis.com ([69.60.120.93]:34078 "EHLO lester.mithis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423284AbXDYIXu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 04:23:50 -0400
Received: from [10.1.50.1] (ppp246-117.static.internode.on.net [203.122.246.117])
	by lester.mithis.com (Postfix) with ESMTP id 6A204B3A6
	for <git@vger.kernel.org>; Wed, 25 Apr 2007 04:23:26 -0400 (EDT)
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45511>

Hello,

Under normal conditions the progress reported via git is really good. As
single commits are normally very small downloading them is very fast.

However, our web repository has a few commits which are quite large
(around 35Mb each). This is where we have committed large binary files
to the repository (I know git wasn't designed for this).

When cloning this repository even on a reasonably fast link git appears
to have "gotten stuck".

It would be nice if when downloading git could report the download
progress (a kb/sec would be really cool). I can understand this probably
isn't a high priority as most of you wouldn't have this situation, I
just thought I would throw it out there. (I may even have a crack when I
am a bit less busy.)

Thanks for making such a cool RCS.

Tim Ansell

You can find the public repository at,
http://git.thousandparsec.net/git/web.git
git://git.thousandparsec.net/git/web.git
