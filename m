From: Chris Wedgwood <cw@f00f.org>
Subject: Re: Humble request of 'git' developers
Date: Sat, 23 Apr 2005 13:18:58 -0700
Message-ID: <20050423201858.GB5448@taniwha.stupidest.org>
References: <426AA8E2.60403@pobox.com> <20050423200246.GA5448@taniwha.stupidest.org> <426AAB65.2060401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 22:14:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPR17-0004IY-R6
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 22:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVDWUTC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVDWUTC
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:19:02 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:34995 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261763AbVDWUTA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 16:19:00 -0400
Received: from pimout3-ext.prodigy.net (pimout3-ext.prodigy.net [207.115.63.102])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j3NKIwcm013885
	for <git@vger.kernel.org>; Sat, 23 Apr 2005 16:18:58 -0400
X-ORBL: [67.124.119.21]
Received: from taniwha.stupidest.org (adsl-67-124-119-21.dsl.snfc21.pacbell.net [67.124.119.21])
	by pimout3-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j3NKIw5Y385242;
	Sat, 23 Apr 2005 16:18:59 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 644C1115C859; Sat, 23 Apr 2005 13:18:58 -0700 (PDT)
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <426AAB65.2060401@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2005 at 04:09:09PM -0400, Jeff Garzik wrote:

> * flat namespaces grow cumbersome

agreed

> * if everybody uses the 'git' command, which does all the internal
> execution, then it's just namespace pollution.

sure, but not everyone body is

i agree everybody *should* and then it can go into <prefix>/libexec or
similar
