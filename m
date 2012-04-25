From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking (incremental)
Date: Wed, 25 Apr 2012 11:06:23 +0200
Message-ID: <87r4vcqiy8.fsf@thomas.inf.ethz.ch>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
	<xmqqobqgeex1.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 11:06:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMyBG-0002T9-2Z
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 11:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430Ab2DYJG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 05:06:28 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:34289 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755113Ab2DYJG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 05:06:27 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Wed, 25 Apr
 2012 11:06:24 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 25 Apr
 2012 11:06:24 +0200
In-Reply-To: <xmqqobqgeex1.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 24 Apr 2012 19:14:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196303>

Junio C Hamano <gitster@pobox.com> writes:

> I've merged the following topics to 'next':
>
>   * tr/xdiff-fast-hash (2012-04-09) 1 commit
>   * cb/daemon-test-race-fix (2012-04-19) 1 commit
>   * ld/git-p4-tags-and-labels (2012-04-24) 6 commits
>   * nh/empty-rebase (2012-04-24) 4 commits
>   * pw/t5800-import-race-fix (2012-04-24) 1 commit
>   * nd/i18n (2012-04-24) 10 commits
>
> Some of them are scary and somewhat iffy (I had to apply a last minute
> fix and rebuild 'next' to one of them), so please test them throughly to
> help us avoid breakages on 'master'.

Umm, which one?

As the author of the first, I'm kind of curious whether I need to
scramble to fix (or at least further test) something :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
