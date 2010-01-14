From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 15:41:54 +0900
Message-ID: <20100114154154.6117@nanako3.lavabit.com>
References: <op.u6g8jnixg402ra@nb-04>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Rudolf Polzer" <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 07:42:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVJPj-0000Lo-B6
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 07:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab0ANGmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 01:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755603Ab0ANGmd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 01:42:33 -0500
Received: from karen.lavabit.com ([72.249.41.33]:48770 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753Ab0ANGmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 01:42:32 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 4EBB311B8E6;
	Thu, 14 Jan 2010 00:42:32 -0600 (CST)
Received: from 2992.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 5N1GX6BS1NF9; Thu, 14 Jan 2010 00:42:32 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ac/2OBlZUZVdG5lKYgv4UJZFQXRaIjodJEnThGDReVftalmIVjEtbmZSDqNToXFS5U6FNnZtrak7hirzOZaMR1nTAAwckEbSbg7U/oNOZ+Yc+B89+LFdtoPM7FTMJVQvo5XQ/lY0F49zqb/izu+6vdM+mqDDQ0PR5Nmqs28eMWY=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <op.u6g8jnixg402ra@nb-04>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136954>

Quoting Rudolf Polzer <divVerent@alientrap.org>

> I'd like a feature to automatically "transform" a non-tracking local
> branch into a tracking branch on push. A patch to do that is attached.

How well does this take earlier discussions on the same topic into account? For example, did you study the design discussion in
  http://thread.gmane.org/gmane.comp.version-control.git/135325/focus=135390

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
