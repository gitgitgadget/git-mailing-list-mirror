From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Mark http-fetch without -a as deprecated
Date: Tue, 23 Aug 2011 09:05:55 -0400
Message-ID: <1314104698-sup-1594@pinkfloyd.chass.utoronto.ca>
References: <1314060703-24265-1-git-send-email-bwalton@artsci.utoronto.ca> <vpqvcto391x.fsf@bauges.imag.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, gitster <gitster@pobox.com>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 23 15:06:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvqgh-0004qN-6U
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 15:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab1HWNG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 09:06:29 -0400
Received: from jerry.cquest.utoronto.ca ([192.82.128.5]:57230 "EHLO
	jerry.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996Ab1HWNGD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 09:06:03 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:51171 ident=93)
	by jerry.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Qvqfz-0002tU-6Y; Tue, 23 Aug 2011 09:05:55 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Qvqfz-000266-5l; Tue, 23 Aug 2011 09:05:55 -0400
In-reply-to: <vpqvcto391x.fsf@bauges.imag.fr>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179936>

Excerpts from Matthieu Moy's message of Tue Aug 23 03:02:02 -0400 2011:

Hi Matthieu,

> Bad indentation. Git indents with tabs, not spaces. Also, you can break
> the line to make both the error message and the source code fit on 80
> characters.

Yes, sorry.  Too much dependence on emacs 'doing the right thing' I
guess.  I'll fix both of these issues and resubmit.

> No opinion on whether the deprecation is sensible, though. If it is,
> add something in the documentation, not just in the code.

Yes, good point.  I'll include this documentation change as well.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
