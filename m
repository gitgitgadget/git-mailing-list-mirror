From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Colorize 'commit' lines in log ui
Date: Mon, 24 Jul 2006 00:06:22 -0700
Message-ID: <7vwta3eb2p.fsf@assigned-by-dhcp.cox.net>
References: <20060723092417.GA7547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 09:06:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4uWO-0002ka-Ug
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 09:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWGXHGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 03:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWGXHGa
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 03:06:30 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:57590 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751427AbWGXHG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 03:06:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060724070629.JWWT27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 03:06:29 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060723092417.GA7547@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 23 Jul 2006 05:24:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24129>

Jeff King <peff@peff.net> writes:

> I think the visual cue makes the git-whatchanged -p output much easier
> to read.

Although I personally do not do much colors (instead I do
"/^commit [0-9a-f]*" under less), I think this makes sense and I
do not think of any obvious downside.
