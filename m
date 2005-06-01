From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] One-Git Part 2 (3 patches to follow)
Date: Wed, 1 Jun 2005 14:22:36 -0400
Message-ID: <20050601182236.GA2228@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 20:30:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdXxr-0003ul-I2
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 20:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVFASbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 14:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVFASbG
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 14:31:06 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:42959 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261534AbVFASWo
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 14:22:44 -0400
Received: by timesys.com (Postfix, from userid 623)
	id 00F1AEB2F; Wed,  1 Jun 2005 14:22:36 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The following set of patches add to the original 'one git'
patch series, and wrap the git-*-script scripts into the
one-git binary via zlib compression.

Have fun!

-- 
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation
