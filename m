From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC PATCH v3 0/8] Remote helpers smart transport extensions
Date: Mon, 07 Dec 2009 21:06:08 +0900
Message-ID: <20091207210608.6117@nanako3.lavabit.com>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi> <7v7hsz9qxj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 13:06:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHcMI-0004Jm-Ft
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 13:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbZLGMGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 07:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbZLGMGS
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 07:06:18 -0500
Received: from karen.lavabit.com ([72.249.41.33]:44041 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589AbZLGMGS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 07:06:18 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id A362511B8FF;
	Mon,  7 Dec 2009 06:06:22 -0600 (CST)
Received: from 4719.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id WV9ENB7N7N8Y; Mon, 07 Dec 2009 06:06:22 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=cws95fKV9OobA2nH+6h3SaQNP4biSd3CQpaOYwwrPHI/PGsGuL1xyPXoxKpP2W53M0e75MrXvUNN4npJfQe0Py4HO+lX4HXD7+yPN0PNzAp4xZIWns75bp1S5uEUgLt3oVR3WbAnheHMayDMiFb62Bm3AsL3WMllr8jTK1Uc1eE=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v7hsz9qxj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134753>

Quoting Junio C Hamano <gitster@pobox.com>

> I queued to ease the discussion in 'pu'.  I had to fix-up some conflicts
> while doing so.  Please sanity check the result.

I see that you changed many "char* variable" to "char *variable", but
what is the reason for these changes?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
