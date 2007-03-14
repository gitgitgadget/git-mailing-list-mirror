From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH(amend)] core.workdir config variable
Date: Wed, 14 Mar 2007 00:48:18 -0700
Message-ID: <7vfy88fepp.fsf@assigned-by-dhcp.cox.net>
References: <20070311043250.GA21331@moooo.ath.cx>
	<fcaeb9bf0703110542t49bb3e77kb164ba7bfee1a6ed@mail.gmail.com>
	<20070311155649.GA29663@moooo.ath.cx>
	<20070311212906.GA18208@moooo.ath.cx>
	<20070313231004.GA15058@moooo.ath.cx>
	<20070313235755.GA25013@moooo.ath.cx>
	<20070314060145.GB20978@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 08:48:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRODe-00048q-9F
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 08:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933855AbXCNHsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 03:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933873AbXCNHsU
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 03:48:20 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50815 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933855AbXCNHsT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 03:48:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314074818.LTPG28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 03:48:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aXoJ1W00B1kojtg0000000; Wed, 14 Mar 2007 03:48:19 -0400
In-Reply-To: <20070314060145.GB20978@spearce.org> (Shawn O. Pearce's message
	of "Wed, 14 Mar 2007 02:01:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42181>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Matthias Lederhofer <matled@gmx.net> wrote:
>> core.workdir is used as default value for $GIT_WORK_DIR
> ...
>> -- 
>> gitgui.0.6.3.g4bccd
>
> Really?  gitgui generates emails now?  ;-)

It might not be a bad idea actually.  You let people make
commits.  Why not let them pick commits, run format-patch and
drive send-email for them from the UI?
