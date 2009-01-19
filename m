From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Mon, 19 Jan 2009 12:54:32 +0100
Organization: private
Message-ID: <864ozvv7d3.fsf@broadpark.no>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 12:56:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOsju-00009u-Gt
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 12:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759598AbZASLyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 06:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758385AbZASLyg
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 06:54:36 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:65498 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbZASLyf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 06:54:35 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDP003T7VQY1GB0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 19 Jan 2009 12:54:34 +0100 (CET)
Received: from localhost ([80.203.29.59]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDP00F29VQXGN60@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 19 Jan 2009 12:54:34 +0100 (CET)
In-reply-to: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106347>

Junio C Hamano <gitster@pobox.com> writes:
<snipp>
> ----------------------------------------------------------------
> [Actively cooking]
>
> * kb/lstat-cache (Sun Jan 18 16:14:54 2009 +0100) 5 commits
>  + lstat_cache(): introduce clear_lstat_cache() function
>  + lstat_cache(): introduce invalidate_lstat_cache() function
>  + lstat_cache(): introduce has_dirs_only_path() function
>  + lstat_cache(): introduce has_symlink_or_noent_leading_path()
>    function
>  + lstat_cache(): more cache effective symlink/directory detection
>
> This is the tenth round, now in 'next'.

  Thanks!!  Nice to see that the patch is going forward.  And I have to
  admit that it was very fun to make that patch.

  How long is the 'merge window' in Linux Kernel terms for this round
  (to the next release of GIT)?

  I have a second idea to an improvement, which also looks quite good
  for the moment, and I am sort of wondering how fast I must work.  :-)

  -- kjetil
