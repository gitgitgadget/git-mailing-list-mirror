From: Andrew Myers <asm198@gmail.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Mon, 19 Mar 2012 16:11:10 +0000 (UTC)
Message-ID: <loom.20120319T170700-42@post.gmane.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr> <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 17:15:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9fFD-0003yf-Jn
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 17:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161643Ab2CSQPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 12:15:17 -0400
Received: from plane.gmane.org ([80.91.229.3]:51506 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161624Ab2CSQPP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 12:15:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S9fEh-0003ch-2n
	for git@vger.kernel.org; Mon, 19 Mar 2012 17:15:13 +0100
Received: from 38.102.20.68 ([38.102.20.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 17:15:07 +0100
Received: from asm198 by 38.102.20.68 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 17:15:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 38.102.20.68 (Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20100101 Firefox/11.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193435>

I would like to register my vote to change the default behavior of git push
to either current (preferred) or upstream.  I'm the git admin on my team which
uses a shared repository with many branches.  The current default behavior
has caused confusion and problems for inexperienced users (or users who refuse
to self educate).  While the optimum solution would be users who learn the
system but this change would make (at least) my job easier.
