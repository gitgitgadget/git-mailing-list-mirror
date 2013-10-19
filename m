From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH] git-svn documentation: Use tabs consistently within the ascii doc
Date: Fri, 18 Oct 2013 20:37:52 -0500
Message-ID: <87ob6mxcpb.fsf@gmail.com>
References: <1382126170-8907-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 03:38:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXLUe-0005iW-01
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 03:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab3JSBiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 21:38:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:55643 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602Ab3JSBiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 21:38:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VXLUU-0005dy-84
	for git@vger.kernel.org; Sat, 19 Oct 2013 03:38:06 +0200
Received: from cpe-72-179-6-119.austin.res.rr.com ([72.179.6.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 03:38:06 +0200
Received: from keshav.kini by cpe-72-179-6-119.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 03:38:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-72-179-6-119.austin.res.rr.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:6snrGiRtpz/5ViZJM95RZaE06+4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236382>

Stefan Beller <stefanbeller@googlemail.com> writes:

> While I can understand 4 or 7 white spaces are fancy, we'd rather want
> to use tabs throughout the whole document.

You missed lines 278 and 833.  There are also some spaces around line
488, but maybe those are layout-relevant and so shouldn't be converted
to tabs.

-Keshav
