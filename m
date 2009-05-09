From: Junio C Hamano <gitster@pobox.com>
Subject: Re: can we allow -t abbreviation for --track in 'git branch'
Date: Sat, 09 May 2009 08:15:52 -0700
Message-ID: <7vab5m9ujb.fsf@alter.siamese.dyndns.org>
References: <slrnh0agtv.4rv.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 09 17:16:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2oHR-0000lm-MI
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 17:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbZEIPPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 11:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbZEIPPw
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 11:15:52 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50980 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbZEIPPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 11:15:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090509151552.CVII17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 May 2009 11:15:52 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id pTFs1b00G4aMwMQ03TFsA3; Sat, 09 May 2009 11:15:52 -0400
X-Authority-Analysis: v=1.0 c=1 a=-Feqs4N-suwA:10 a=k1pRcjExh4sA:10
 a=pGLkceISAAAA:8 a=PAJz7xfDAAAA:8 a=_3vE32J9SKxtd6udsuAA:9
 a=RQebVFb5u2Ee3YJxay5GEQY_zR8A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <slrnh0agtv.4rv.sitaramc@sitaramc.homelinux.net> (Sitaram Chamarty's message of "Sat\, 9 May 2009 08\:50\:07 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118659>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Would it make sense to teach "git branch" the short option
> "-t" the same way that "git checkout" knows it, (ie., as an
> abbreviation for "--track")?
>
> I use both frequently, and often forget that in "git branch"
> the short option does not work.
>
> If people think it's OK I'll submit a patch (code and doc).

I have <20090428152119.GA18935@atc.tcs.com> (aka $gmane/117790) in my
inbox.
