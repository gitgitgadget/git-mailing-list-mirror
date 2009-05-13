From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [git-svn] howto select a part of the tree
Date: Wed, 13 May 2009 14:51:10 +0200
Message-ID: <4A0AC23E.2040503@drmicha.warpmail.net>
References: <4A09D4EC.6050002@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Gaber <Michael.Gaber@gmx.net>
X-From: git-owner@vger.kernel.org Wed May 13 14:51:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Dvz-00083A-C0
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 14:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070AbZEMMvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 08:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbZEMMvT
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 08:51:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44224 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753016AbZEMMvS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 08:51:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7A27734418F;
	Wed, 13 May 2009 08:51:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 13 May 2009 08:51:19 -0400
X-Sasl-enc: q7EzRCKigZE7swrcQOkd7S8PA9JilYX3Ov+R+nD3FYJb 1242219079
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DCDA824BA8;
	Wed, 13 May 2009 08:51:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A09D4EC.6050002@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119045>

Michael Gaber venit, vidit, dixit 12.05.2009 21:58:
> Hi,
> 
> I have the following setup and would like to know it my thought workflow 
> would be easily doable with git-svn.
> 
> I have a repository which contains at the moment 5 eclipse projects. two 
> of them are directly in the svn root and i'm not interested in them. the 
> other three are mine and I'd like to use them as separate eclipse 
> projects as i currently do when i check them out as seperate projects 
> into the workspace with subversive.
> 
> is this possible or should i just forget it.
> 
> Regards Michael

It is possible. I you want more detailed answers we would need more
detailed info (structure of the svn repo).

Cheers,
Michael
