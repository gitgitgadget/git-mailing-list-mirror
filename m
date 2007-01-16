From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 02:45:39 -0800
Message-ID: <7vwt3nxnak.fsf@assigned-by-dhcp.cox.net>
References: <200701150144.56793.jnareb@gmail.com>
	<200701151003.44498.jnareb@gmail.com>
	<20070115095613.GA4037@localdomain>
	<200701151132.00971.jnareb@gmail.com>
	<20070115112635.GA5134@localdomain>
	<Pine.LNX.4.63.0701151313050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<dbfc82860701150734j7322de15v30dc6822b456ea66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Eric Wong" <normalperson@yhbt.net>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 11:45:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6lp2-0005uN-Fq
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 11:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXAPKpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 05:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbXAPKpm
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 05:45:42 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61963 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbXAPKpl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 05:45:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070116104540.FMEO29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Tue, 16 Jan 2007 05:45:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Bmlw1W00s1kojtg0000000; Tue, 16 Jan 2007 05:45:57 -0500
To: "Nikolai Weibull" <now@bitwi.se>
In-Reply-To: <dbfc82860701150734j7322de15v30dc6822b456ea66@mail.gmail.com>
	(Nikolai Weibull's message of "Mon, 15 Jan 2007 16:34:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36924>

"Nikolai Weibull" <now@bitwi.se> writes:

> If we're going down this slippery slope, why not just give up and add
> a --xml switch instead?  Readable by all...

Perhaps all except humans.

At least YAML, please...
