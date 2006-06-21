From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH (fixed)] rebase: Allow merge strategies to be used when rebasing
Date: Wed, 21 Jun 2006 03:04:40 -0700
Message-ID: <11508842824018-git-send-email-normalperson@yhbt.net>
References: <20060621100138.GA15748@localdomain>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 21 12:05:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FszZt-0006Ob-GZ
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 12:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWFUKEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 06:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWFUKEp
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 06:04:45 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8092 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751420AbWFUKEo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 06:04:44 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 131967DC022;
	Wed, 21 Jun 2006 03:04:43 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 21 Jun 2006 03:04:42 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0.g65f3
In-Reply-To: <20060621100138.GA15748@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22252>

1 - is fixed for --onto usage.
2 - in the series is the test from Junio, so I'm not resending it:
	Subject: [PATCH] Add renaming-rebase test.
3 - keeps the NO_PYTHON people happy

-- 
Eric Wong
