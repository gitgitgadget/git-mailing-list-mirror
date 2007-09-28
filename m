From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Merge non-first refs that match first refspec
Date: Fri, 28 Sep 2007 02:34:27 -0700
Message-ID: <7vve9vp1zw.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709272351010.5926@iabervon.org>
	<20070928041509.GU3099@spearce.org>
	<Pine.LNX.4.64.0709280026240.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 11:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbCF3-0004OL-Uu
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 11:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbXI1Je3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 05:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755174AbXI1Je3
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 05:34:29 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43342 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbXI1Je2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 05:34:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070928093428.MOMT29469.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 28 Sep 2007 05:34:28 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id tlaT1X0091gtr5g0000000; Fri, 28 Sep 2007 05:34:27 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59383>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Beats me; Junio, what's your test case?

I can paste tomorrow (it is a clone of git.git at work).  I do
not use .git/config but .git/remotes/origin and explicit four
separate Pull: lines and going over http.
