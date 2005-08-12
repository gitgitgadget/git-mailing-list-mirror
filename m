From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Fri, 12 Aug 2005 01:41:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0508120139230.19902@qynat.qvtvafvgr.pbz>
References: <pan.2005.08.10.22.11.25.242201@smurf.noris.de>
 <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de>
 <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com>
 <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com>
 <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com>
 <20050811201558.GA2874@mars.ravnborg.org> <20050811202410.GB5411@kiste.smurf.noris.de>
 <42FBCD73.3090507@chandlerfamily.org.uk> <pan.2005.08.12.08.34.45.679778@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 10:41:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3V6t-0007La-FW
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 10:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVHLIlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 04:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVHLIlk
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 04:41:40 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:6019 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S1750811AbVHLIlj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 04:41:39 -0400
Received: from sacims01.digitalinsight.com by warden3.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Fri, 12 Aug 2005 01:41:38 -0700
Received: by sacexc01.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <Q3B978A8>; Fri, 12 Aug 2005 01:41:16 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id QT8MT61M; Fri, 12 Aug 2005 01:40:07 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
X-X-Sender: dlang@dlang.diginsite.com
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <pan.2005.08.12.08.34.45.679778@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

after so many years of software development (and with the policy of never 
having conflicting command names) what three letter combinations are still 
avilable?

I'm assuming that the much smaller pool of two letter commands was long 
since exhausted, but if not what two letter commands are available?

David Lang

  On Fri, 12 Aug 2005, Matthias Urlichs wrote:

> Date: Fri, 12 Aug 2005 10:34:45 +0200
> From: Matthias Urlichs <smurf@smurf.noris.de>
> To: git@vger.kernel.org
> Subject: Re: [PATCH] Debian packaging for 0.99.4
> 
> Hi, Alan Chandler wrote:
>> Not sure I understand the proper use of dpkg-divert in Debian, but could
>> _this_ git-core package perhaps ask the user which set of the two
>> packages he wish to keep as git command and use dpkg-divert to change
>> the other to another name to some other name?
>
> IIRC, that's against Policy too, because different users on the system
> might have different expectations WRT which git is git.
>
> -- 
> Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
> Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
> - -
> You have a strong appeal for members of the opposite sex.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
