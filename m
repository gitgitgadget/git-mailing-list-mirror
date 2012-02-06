From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] bash-completion: add --edit-description to choices for branch
Date: Tue, 7 Feb 2012 00:25:56 +0100
Message-ID: <871uq7sfwb.fsf@thomas.inf.ethz.ch>
References: <1328547807-3374-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 00:26:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuXwk-0005vQ-NL
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 00:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab2BFX0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 18:26:00 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:44603 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217Ab2BFX0A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 18:26:00 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 7 Feb
 2012 00:25:56 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (84.73.49.17) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 7 Feb
 2012 00:25:56 +0100
In-Reply-To: <1328547807-3374-1-git-send-email-paul.gortmaker@windriver.com>
	(Paul Gortmaker's message of "Mon, 6 Feb 2012 12:03:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [84.73.49.17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190121>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> Support was recently added to allow storing a branch description,
> so teach bash completion about it.

See 48c07d8 (completion: --edit-description option for git-branch,
2012-01-29) which is already in next.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
