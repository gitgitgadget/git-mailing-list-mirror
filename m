From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Wed, 11 Feb 2009 09:19:47 -0500
Message-ID: <4992DE83.6080803@tedpavlic.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com>  <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>  <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>  <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com> <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Karpinski <stefan.karpinski@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Feb 11 15:21:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXFxr-0002nK-9c
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 15:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbZBKOT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 09:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755061AbZBKOT4
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 09:19:56 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:34333 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754496AbZBKOTz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 09:19:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id BFEE980D8036;
	Wed, 11 Feb 2009 09:13:24 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SiHwVuG-ruDx; Wed, 11 Feb 2009 09:13:24 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id A89F380D8005;
	Wed, 11 Feb 2009 09:13:24 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109420>

> Looks like there might be a pattern and I might have an excuse to go
> knock on the door of one of my "Mac" friends. ;) However, first I
> would kindly ask if one of you have time to test the attached patch.

It fixes it for me.

As noted, the highlight in the changesets does not go to the end of the 
line (where there is a cursor displayed) as it did before. I can see how 
some people might view this as a feature (i.e., having the whole line 
highlighted).

--Ted


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
