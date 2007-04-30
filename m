From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] v2: Checklist clarifications: added "Commits", "Patch:" headings
Date: Mon, 30 Apr 2007 16:35:35 -0700
Message-ID: <7vejm1bflk.fsf@assigned-by-dhcp.cox.net>
References: <r6q2xgws.fsf@cante.net>
	<Pine.LNX.4.64.0704301333400.29859@racer.site>
	<abwqxe6t.fsf@cante.net>
	<Pine.LNX.4.64.0704301306340.2279@reaper.quantumfyre.co.uk>
	<y7k9x306.fsf_-_@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:35:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HifPA-00074h-8c
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946134AbXD3Xfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946098AbXD3Xfh
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:35:37 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:58763 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946895AbXD3Xfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:35:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070430233537.CZDG1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 19:35:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tbba1W00c1kojtg0000000; Mon, 30 Apr 2007 19:35:35 -0400
In-Reply-To: <y7k9x306.fsf_-_@cante.net> (Jari Aalto's message of "Mon, 30 Apr
	2007 19:04:25 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45900>

Jari Aalto <jari.aalto@cante.net> writes:

> From e65853b7bede747912a51fd77d5cf62fb255b116 Mon Sep 17 00:00:00 2001
> From: Jari Aalto <jari.aalto@cante.net>
> Date: Mon, 30 Apr 2007 18:57:25 +0300
> Subject: [PATCH] Checklist clarifications: added Commits, Patch: headings
>
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  This is version 2 of the orignal patch. Corrected according
>  to Julian Phillips's comments.

The first one was well formatted, but this one is not quite.

Do not have "v2" outside of "[PATCH ...]".

I'll apply it by hand as the text itself feels an improvement.

Thanks.
