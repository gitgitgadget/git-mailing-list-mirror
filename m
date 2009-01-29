From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: do you recommend "git" (over svn) for a 1-person team???
Date: Wed, 28 Jan 2009 22:27:50 -0500
Message-ID: <49812236.9010201@tedpavlic.com>
References: <d30068860901281718x363348caya2dc94e798cc8091@mail.gmail.com>  <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>  <885649360901281815q42199468v8658d864386efe2d@mail.gmail.com> <46a038f90901281828t16ace3bdocc897eb5235d7c30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: James Pickens <jepicken@gmail.com>,
	Greg Hauptmann <greg.hauptmann.ruby@gmail.com>,
	git <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 04:29:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSNar-0007CL-HP
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 04:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbZA2D2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 22:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbZA2D2B
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 22:28:01 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:59240 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753588AbZA2D2A (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 22:28:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 2850880D804F;
	Wed, 28 Jan 2009 22:21:51 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BSQPjpciq3IE; Wed, 28 Jan 2009 22:21:51 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id A625E80D8018;
	Wed, 28 Jan 2009 22:21:49 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <46a038f90901281828t16ace3bdocc897eb5235d7c30@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107621>

>   - "git stash"

Not to mention StGit, which can achieve many of the same things as "git 
stash" while also letting you toy with your changeset history (which is 
definitely permissible on personal repos).

>   - visualise things with gitk
>   - search with gitk for specific bits of code, changes (pickaxe), etc

Not to mention tig, the wonderful ncurses (i.e., Terminal-based) tool 
recently announced on this mailing list.

(and "git grep", of course)

--Ted


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
