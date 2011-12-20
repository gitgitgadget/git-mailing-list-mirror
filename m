From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Tue, 20 Dec 2011 23:15:01 +0100
Message-ID: <87k45qriu2.fsf@thomas.inf.ethz.ch>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 23:15:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd7xo-00038Q-Er
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 23:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab1LTWPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 17:15:08 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:30015 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab1LTWPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 17:15:07 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 23:15:03 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.211.99) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 23:15:04 +0100
In-Reply-To: <20111220220754.GC21353@llunet.cs.wisc.edu> (Nathan W. Panike's
	message of "Tue, 20 Dec 2011 16:07:54 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.211.99]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187533>

"Nathan W. Panike" <nathan.panike@gmail.com> writes:

> This is useful when one is working on a system where the pager is lousy.

I'm curious.  Are you saying your less does not have -S (or you do not
even have less), or do you have a reason not to use it?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
