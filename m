From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: [PATCH] Support diff.autorefreshindex=true in `git-diff --quiet'
Date: Tue, 02 Sep 2008 10:59:47 -0700
Message-ID: <quack.20080902T1059.lthsksil97w@roar.cs.berkeley.edu>
References: <quack.20080901T0129.lth8wuci80o@roar.cs.berkeley.edu>
	<7vskskw41j.fsf@gitster.siamese.dyndns.org>
	<quack.20080901T0350.lthzlmsgmx6@roar.cs.berkeley.edu>
	<7vy72bnk5x.fsf_-_@gitster.siamese.dyndns.org>
	<quack.20080902T1039.lthabeqmopo_-_@roar.cs.berkeley.edu>
	<7v4p4ymocc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 20:01:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaaBf-0004OZ-84
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 20:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbYIBR7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 13:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbYIBR7s
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 13:59:48 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:36447 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604AbYIBR7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 13:59:48 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 8750D34518; Tue,  2 Sep 2008 10:59:47 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <7v4p4ymocc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 02 Sep 2008 10\:47\:47 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94688>

>>>>> On 2008-09-02 10:47 PDT, Junio C Hamano writes:

    Junio> If somebody's depending on the behaviour, it is this
    Junio> new behaviour of doing everything asked without
    Junio> shortcut that needs to become a new option.

Do you agree that the old behavior is at odds with the
documentation and expectations of new users like me, and
inconsistent?
