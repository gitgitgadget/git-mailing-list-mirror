From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Corrected copy-and-paste thinko in ignore executable bit test case.
Date: Wed, 27 Sep 2006 12:43:45 -0700
Message-ID: <7vr6xx9jta.fsf@assigned-by-dhcp.cox.net>
References: <20060927151849.GF20705@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 21:44:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSfJv-0006hh-1p
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 21:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030677AbWI0Tnr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 15:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030718AbWI0Tnr
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 15:43:47 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:46263 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030677AbWI0Tnq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 15:43:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927194346.RIPV6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Sep 2006 15:43:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TXjo1V0011kojtg0000000
	Wed, 27 Sep 2006 15:43:48 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060927151849.GF20705@spearce.org> (Shawn Pearce's message of
	"Wed, 27 Sep 2006 11:18:49 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27926>

Shawn Pearce <spearce@spearce.org> writes:

> This test should be testing update-index --add, not git-add as these
> are two completely different implementations of what is essentially
> the same task.

Thanks -- I'd rephrase the last sentence, though.
