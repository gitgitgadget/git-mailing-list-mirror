From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: merge smart enough to adapt to renames?
Date: Sat, 21 Feb 2009 13:12:37 +0200
Message-ID: <499FE1A5.9020301@dawes.za.net>
References: <81bfc67a0902182212h578e677ck6029c56cb86f7bce@mail.gmail.com>	 <slrngpqquq.j03.sitaramc@sitaramc.homelinux.net>	 <81bfc67a0902191158x5f0f92d1p7e4af2f9cda50a12@mail.gmail.com>	 <slrngprunn.hbo.sitaramc@sitaramc.homelinux.net>	 <81bfc67a0902191817u11361d0bw1f2215a53e284f8f@mail.gmail.com>	 <499E5A9C.6090900@dawes.za.net> <e51f4f550902202048g9a210f0t8fefaee4d8376f6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Caleb Cushing <xenoterracide@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Kris Shannon <kris@shannon.id.au>
X-From: git-owner@vger.kernel.org Sat Feb 21 12:27:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laq0h-0004iy-Vc
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 12:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbZBULMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 06:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbZBULMq
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 06:12:46 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:52372 "EHLO
	spunkymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751193AbZBULMq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Feb 2009 06:12:46 -0500
X-Greylist: delayed 100106 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Feb 2009 06:12:46 EST
Received: from [192.168.201.113] (unknown [41.246.11.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a2.g.dreamhost.com (Postfix) with ESMTP id 97F74870C7;
	Sat, 21 Feb 2009 03:12:41 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <e51f4f550902202048g9a210f0t8fefaee4d8376f6c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110938>

Kris Shannon wrote:
> Rogan Dawes wrote:
>> It seems to me that git is smart enough to figure out where contents get
>> moved to, once. Of course, if you have conflicting moves in the same
>> repo, git's automation falls down. So, if you need to move the "same"
>> file in different repositories to different places, you need to do it
>> via an intermediate repo that will be able to "remember" which movement
>> you chose.
> 
> You don't need a whole different repo,  branches are good enough.
> 

Yes, of course.

Rogan
