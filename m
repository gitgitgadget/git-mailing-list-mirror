From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 01/12] Add data structures and basic functions for
 commit trailers
Date: Thu, 27 Mar 2014 08:55:08 +0100 (CET)
Message-ID: <20140327.085508.680223484876168176.chriscool@tuxfamily.org>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
	<20140326221531.11352.50524.chriscool@tuxfamily.org>
	<xmqqwqfgftl0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 27 08:55:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT59j-0004XJ-2n
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 08:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbaC0HzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 03:55:12 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:53437 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166AbaC0HzL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 03:55:11 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 8DF3773;
	Thu, 27 Mar 2014 08:55:09 +0100 (CET)
In-Reply-To: <xmqqwqfgftl0.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245263>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 01/12] Add data structures and basic functions for commit trailers
Date: Wed, 26 Mar 2014 16:06:35 -0700

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>>> Subject: Re: [PATCH v8 01/12] Add data structures and basic functions for commit trailers
> 
> As pointed out many times for GSoC microprojects students, limit the
> scope with "area:" prefix for the commit title, e.g.
> 
>     Subject: trailers: add data structures and basic functions

Ok, I will fix that.
 
> Please also refer to what has already been queued on 'pu' to avoid
> wasting review bandwidth and mark patches that are unchanged as such
> (but do send them to the list for review, so that people who haven't
> seen the previous round can also comment).

Yeah, I forgot to do that for this version of the series, sorry.

> As far as I can tell, this is the same as 8d1c70e5 (trailers: add
> data structures and basic functions, 2014-03-06), so I'll queue the
> remainder on top of that commit already on 'pu', which incidentally
> will preserve the original author timestamp from the previous
> incarnation.

Ok.

Thanks,
Christian.
