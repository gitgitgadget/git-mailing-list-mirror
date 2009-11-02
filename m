From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git pull --rebase and losing commits
Date: Tue, 03 Nov 2009 06:34:48 +0900
Message-ID: <20091103063448.6117@nanako3.lavabit.com>
References: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se>
	<200911021604.24066.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Nov 02 22:35:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N54YJ-0007sF-CO
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 22:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbZKBVes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 16:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756001AbZKBVes
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 16:34:48 -0500
Received: from karen.lavabit.com ([72.249.41.33]:33746 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755784AbZKBVes (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 16:34:48 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 599AD16F4C4;
	Mon,  2 Nov 2009 15:34:53 -0600 (CST)
Received: from 1392.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 7UZ3VISE9G0L; Mon, 02 Nov 2009 15:34:53 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=usJCNkP4OvpHZgy2aZpLXih50ESfse04PTiAEmVKhS3sodvCo+g4+IzuiTaBfZGFn+FklXvaCBDhzULHNDuqillQf5Gc6MMJ90uCfMAUzrb72wnQXXqTT2zCE7hGjHhOrN36Bvb/Mou5qud/Sk+7y4G1ZWzZQIsqK9wT+fBgzac=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <200911021604.24066.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131935>

Quoting Thomas Rast <trast@student.ethz.ch>

> It is *not*
> the often requested (but ill-defined and hence never implemented)
> "resolve all conflict hunks in favour of ours" strategy.

This was implemented and posted here quite some time ago.

  http://thread.gmane.org/gmane.comp.version-control.git/85163/focus=85602

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
