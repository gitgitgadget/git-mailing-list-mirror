From: bdowning@lavos.net (Brian Downing)
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 09:03:44 -0600
Message-ID: <20071119150344.GG6212@lavos.net>
References: <1195477504.8093.15.camel@localhost> <20071119150209.GF6212@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Juselius <jonas.juselius@chem.uit.no>
X-From: git-owner@vger.kernel.org Mon Nov 19 16:04:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu8AQ-0003vR-LD
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 16:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbXKSPDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 10:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755993AbXKSPDr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 10:03:47 -0500
Received: from mxsf00.insightbb.com ([74.128.0.70]:49300 "EHLO
	mxsf00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965AbXKSPDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 10:03:46 -0500
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="116381922"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf00.insightbb.com with ESMTP; 19 Nov 2007 10:03:45 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAHM0QUdKhvkY/2dsb2JhbACBWA
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="162239322"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 19 Nov 2007 10:03:45 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id F1FC9309F21; Mon, 19 Nov 2007 09:03:44 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20071119150209.GF6212@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65452>

On Mon, Nov 19, 2007 at 09:02:09AM -0600, Brian Downing wrote:
> The default, -1, is the zlib default, which is probably something like 3-6.
> Setting these to 1 will probably result in less compression, not more.

It's 6:

>  Z_DEFAULT_COMPRESSION requests a default compromise between speed and
>  compression (currently equivalent to level 6).

-bcd
