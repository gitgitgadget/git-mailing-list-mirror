From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Wed, 31 Jan 2007 19:22:47 -0800
Message-ID: <7vk5z2r27s.fsf@assigned-by-dhcp.cox.net>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
	<Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45C14563.8060707@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 04:23:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCSXN-0003or-MU
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 04:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161296AbXBADWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 22:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbXBADWu
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 22:22:50 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:63908 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161296AbXBADWt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 22:22:49 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070201032248.SZZQ4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 31 Jan 2007 22:22:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id J3No1W0081kojtg0000000; Wed, 31 Jan 2007 22:22:48 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38322>

I am not in X right now and won't be able to look at it myself
tonight.  Could folks on MacOS comment on Mark's patch?
