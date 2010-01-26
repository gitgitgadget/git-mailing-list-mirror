From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Modern Git GUI
Date: Tue, 26 Jan 2010 12:35:57 +0100
Message-ID: <4B5ED39D.1020804@drmicha.warpmail.net>
References: <e39c1dcf1001231340p67448584pfdbc453cc8fb9ca7@mail.gmail.com>	 <vpq636resro.fsf@bauges.imag.fr>	 <alpine.DEB.1.00.1001251524190.8733@intel-tinevez-2-302> <43d8ce651001250630p51761f6eyce8b89da6ffcd7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	andre.harms@kuhlsolutions.de, Matthieu Moy <Matthieu.Moy@imag.fr>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 12:38:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZjkK-0007M7-Oq
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 12:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab0AZLiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 06:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272Ab0AZLiA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 06:38:00 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57757 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754Ab0AZLh7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 06:37:59 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AB75FCD70F;
	Tue, 26 Jan 2010 06:37:58 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 26 Jan 2010 06:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+TiyGvMVyWnz13e36LEH6vc1EWI=; b=RCNUPnl+2I9T1IXYeWwaK+ojuw1ZkQZo2TkdpVGzv0KywApQqE9XrKNS1NAgOhl200uttcBmF9NYLKzTxNghZUWgvEYsLIWhUYTO61Cd4reaVqqBwcBcLBamkFjKihVYW8hZvBOiFe4zviHI4/pLTwy/rCuLGuhxAf9GlWDWcs8=
X-Sasl-enc: LwXWVnQL7VVb3xM1pmQcIp1mF5hpTXTsF1wWXpOiVKhC 1264505878
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B77193A977D;
	Tue, 26 Jan 2010 06:37:57 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8pre) Gecko/20100121 Lightning/1.0b2pre Shredder/3.0.2pre
In-Reply-To: <43d8ce651001250630p51761f6eyce8b89da6ffcd7b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138031>

[Re-adding cc culled by John. Bad boy :) ]
John Tapsell venit, vidit, dixit 25.01.2010 15:30:
> 2010/1/25 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> Hi,
>>
>> On Sun, 24 Jan 2010, Matthieu Moy wrote:
>>
>>> If you decide to go on with your project, either you want to carry it
>>> out alone, or you'll have to convince other developers to join. In the
>>> second case, a good starting point would be to explain why the other GUI
>>> are not good enough, and why you can't just contribute to them.
>>
>> Actually, a much better way would be to be positive, not negative.  I.e.
>> to show something you did, which hopefully entices others to use your
>> project (and maybe contribute to it).
> 
> Actually in this case, I don't think that would be good enough.  My
> first thought would be "why didn't he just add this feature to an
> existing GUI rather than reinventing the wheel yet again".  So there
> would really have to be good reasons why the other GUIs aren't a good
> enough starting point

A first step may be making the feature matrix in the wiki more honest -
I've been meaning to do this for ages... For example, a gui which simply
calls "gitk" for history view simply does not support history view
according to my books, at least not on the same level (gui
*integration*) as guis doing this natively. Or else gitk would have all
git-gui features and vice versa... or even plain git, for that matter.

Michael
