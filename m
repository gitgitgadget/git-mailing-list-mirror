From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Enhanced git branch list (proposal)
Date: Mon, 23 Jul 2012 20:32:49 +0200
Message-ID: <87eho2tjji.fsf@thomas.inf.ethz.ch>
References: <500D954B.4090007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: John Bartholomew <jpa.bartholomew@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:33:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNRF-0004O2-2z
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab2GWScx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:32:53 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:14776 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab2GWScw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:32:52 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 23 Jul
 2012 20:32:49 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 23 Jul
 2012 20:32:49 +0200
In-Reply-To: <500D954B.4090007@gmail.com> (John Bartholomew's message of "Mon,
	23 Jul 2012 19:17:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201954>

John Bartholomew <jpa.bartholomew@gmail.com> writes:

> I find the output of `git branch' to be quite bare, and would like to
> see more information; most importantly, what the state of the branch
> is in relation to its upstream.

That is already present: just run git branch -vv.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
