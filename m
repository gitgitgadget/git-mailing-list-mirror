From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: CFT: merge-recursive in C
Date: Wed, 28 Jun 2006 08:37:48 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060628063747.GA983@informatik.uni-freiburg.de>
References: <20060626233838.GA3121@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 08:37:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvTgQ-0003Ql-CN
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 08:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423153AbWF1Ghv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 02:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423184AbWF1Ghv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 02:37:51 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:46495 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1423153AbWF1Ghu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 02:37:50 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FvTgL-0004Hj-Df; Wed, 28 Jun 2006 08:37:49 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k5S6bm5x001235;
	Wed, 28 Jun 2006 08:37:48 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k5S6bmHi001234;
	Wed, 28 Jun 2006 08:37:48 +0200 (MEST)
To: Alex Riesen <raa.lkml@gmail.com>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060626233838.GA3121@steel.home>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22774>

Hello Alex,

> +// does not belong here
Some C compiler (e.g. Sun Forte) don't like C++-style comments.

(So the line could read:

  /* "//" does not belong here :-) */

)

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=1+degree+celsius+in+kelvin
