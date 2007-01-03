From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Assorted small changes to runstatus
Date: Tue, 02 Jan 2007 18:51:18 -0800
Message-ID: <7v8xgkstzt.fsf@assigned-by-dhcp.cox.net>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 03:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1wDs-0000Da-43
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 03:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbXACCvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 21:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbXACCvU
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 21:51:20 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41024 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbXACCvU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 21:51:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103025119.WBGV2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 21:51:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6SqX1W0111kojtg0000000; Tue, 02 Jan 2007 21:50:32 -0500
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <1167765983316-git-send-email-j.ruehle@bmiag.de> (Juergen
	Ruehle's message of "Tue, 2 Jan 2007 20:26:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35840>

Thanks.  3 and 4 are obviously good, 1 is probably good although
I do not have much preference either way myself.  The part that
adds helpful messages of 2 is nice but I am not sure about the
wording "Cached changes".

Maybe people who were in the update-index and git-add discussion
have better input than I can give.
