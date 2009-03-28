From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git Download/Bootstrap Suggestion
Date: Sat, 28 Mar 2009 17:09:54 +0100
Message-ID: <49CE4BD2.4060808@drmicha.warpmail.net>
References: <49CD0841.9000602@gmail.com> <fabb9a1e0903271621g392eefdeu85b46c655c1ad067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 17:11:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnb8Q-00068V-Hc
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 17:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbZC1QKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 12:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbZC1QKE
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 12:10:04 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40343 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752885AbZC1QKD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 12:10:03 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 8B3DE301629;
	Sat, 28 Mar 2009 12:10:00 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 28 Mar 2009 12:10:00 -0400
X-Sasl-enc: HXKFS06C88tr0BdO8cSduNz/ofJ6rO+4EDJbv88eWWh5 1238256600
Received: from localhost.localdomain (p4FC6280C.dip0.t-ipconnect.de [79.198.40.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BECA329777;
	Sat, 28 Mar 2009 12:09:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090328 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <fabb9a1e0903271621g392eefdeu85b46c655c1ad067@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114964>

Sverre Rabbelier venit, vidit, dixit 28.03.2009 00:21:
> Heya,
> 
> On Fri, Mar 27, 2009 at 18:09, Mike Gaffney <mr.gaffo@gmail.com> wrote:
>> I have to do is
>> - download the source tarball (or the rpm)
>> - make it
>> - install it
> 
> Nah, you don't need to do all that ;).
> 
> 
>> It'd be a lot cooler if I could just wget a full get repo on the latest tag
> 
> You mean like, this?
> 
> http://repo.or.cz/w/git.git?a=snapshot;h=master;sf=tgz
> 

No, I think he meant repo, not work tree.

Michael
