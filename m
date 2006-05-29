From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/4] fix tests so they run without needing bash
Date: Sun, 28 May 2006 22:39:05 -0700
Message-ID: <20060529053905.GD24077@localdomain>
References: <1148609178788-git-send-email-normalperson@yhbt.net> <7vu07dqyk8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 07:39:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkaT8-0003t5-Od
	for gcvg-git@gmane.org; Mon, 29 May 2006 07:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWE2FjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 01:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWE2FjH
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 01:39:07 -0400
Received: from hand.yhbt.net ([66.150.188.102]:20395 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751206AbWE2FjG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 01:39:06 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 420937DC021;
	Sun, 28 May 2006 22:39:05 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 28 May 2006 22:39:05 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu07dqyk8.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20922>

Junio C Hamano <junkio@cox.net> wrote:
> You are my hero.

:)

You and Linus have already been my heroes for a while.

I was very pleasantly surprised that all the git-*.sh files work fine
(for me, at least) and only the tests needed modification.

-- 
Eric Wong
