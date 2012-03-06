From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] Documentation update for 'git branch'
Date: Tue, 6 Mar 2012 10:00:42 +0100
Message-ID: <871up66r45.fsf@thomas.inf.ethz.ch>
References: <1331023866-5658-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 10:00:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4qGI-00057S-3b
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 10:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027Ab2CFJAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 04:00:45 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:6708 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964952Ab2CFJAo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 04:00:44 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 10:00:45 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 10:00:42 +0100
In-Reply-To: <1331023866-5658-1-git-send-email-vfr@lyx.org> (vfr@lyx.org's
	message of "Tue, 6 Mar 2012 09:51:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192320>

Hi Vincent,

vfr@lyx.org writes:

> Changes:
> - add a period to a sentence,
> - correct 'tag' into 'branch',
> - unify the use of backticks,
> - indicate that the commit parameter of --contains defaults to HEAD.

First off, please read Documentation/SubmittingPatches.  I think this
should be split into at least two commits, one for the cleanups and one
for the actual change.

As for

> - unify the use of backticks,

nice catch, and note that this is a pretty common problem across the
docs.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
