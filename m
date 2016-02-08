From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/2] enable "svn.pathnameencoding" on dcommit
Date: Mon, 8 Feb 2016 22:58:06 +0000
Message-ID: <20160208225806.GA3487@dcvr.yhbt.net>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alex.crezoff@gmail.com
To: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:58:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSul3-0003fe-Hi
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 23:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbcBHW6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 17:58:08 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:46153 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756909AbcBHW6H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 17:58:07 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0BB62018D;
	Mon,  8 Feb 2016 22:58:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56B8B1EA.5020901@f2.dion.ne.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285822>

Kazutoshi Satoda <k_satoda@f2.dion.ne.jp> wrote:
> I'm sorry not coming with test scripts, but I couldn't figure out how to
> write tests to reproduce problems happen only with non-UTF-8 paths while
> the tests seems to be run on UTF-8 locale.

Thank you.  I will try to work on some tests throughout the week
(help appreciated!) but will be willing to push these up to Junio
regardless.
