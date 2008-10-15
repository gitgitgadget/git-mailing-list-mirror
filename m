From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git graph on GitHub
Date: Wed, 15 Oct 2008 10:24:44 +0200
Message-ID: <48F5A8CC.1000904@drmicha.warpmail.net>
References: <530345950810150047v75bfbf9clebbb8a406b172c4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tom Werner <pubsub@rubyisawesome.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 10:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq1hu-0004Fo-5g
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 10:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbYJOIYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 04:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbYJOIYt
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 04:24:49 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46586 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750999AbYJOIYs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 04:24:48 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 41E5F17D76B;
	Wed, 15 Oct 2008 04:24:47 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 15 Oct 2008 04:24:47 -0400
X-Sasl-enc: GWy4vh3JKkHh4Y2MXdCxxAJL7aGjim+stsVQrdzYzT7Z 1224059086
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ADD591F664;
	Wed, 15 Oct 2008 04:24:46 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <530345950810150047v75bfbf9clebbb8a406b172c4c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98259>

Tom Werner venit, vidit, dixit 15.10.2008 09:47:
> We've just pushed out an update to the Network Graph on GitHub this
> evening that finally allows us to draw very large repositories
> (including Git). We're mirroring the Git repo on the site and I
> thought it might be interesting for people to see this visualization.
> Enjoy!
> 
> http://github.com/git/git/network
> 
> Let me know if you have any ideas for improvements on the graph. I'm
> always looking for ways to enhance it.

Nice graph. The numbers in the grey bar are cut off around the middle,
though (FF 3 on Kubuntu Linux). Is there a way to display branch labels
other than master? Maybe the commit overlays could list all branches a
commit belongs to (like gitk does).

One nitpick regarding your git.git mirror: I doubt that people here
("the community") consider git-scm.com to be "the git homepage". I don't
want to go into the reasons and start a pointless thread, but since
git-scm.com is a fork of git.or.cz pointing to the latter (the root)
should make everyone happy.

Michael
