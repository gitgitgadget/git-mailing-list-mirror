From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [RFC/PATCH] cvsexportcommit: per branch cvsdir config option
Date: Wed, 21 Apr 2010 08:32:25 +0200
Message-ID: <201004210832.25810.robin.rosenberg@dewire.com>
References: <1271810562-4196-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Trent Piepho <tpiepho@freescale.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 08:32:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4TU9-0003dg-5B
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 08:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab0DUGc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 02:32:28 -0400
Received: from mail.dewire.com ([83.140.172.130]:6404 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab0DUGc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 02:32:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9D1D713839D8;
	Wed, 21 Apr 2010 08:32:26 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kKm8I5JdjF2f; Wed, 21 Apr 2010 08:32:26 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 29A24800397;
	Wed, 21 Apr 2010 08:32:26 +0200 (CEST)
User-Agent: KMail/1.12.4 (Linux/2.6.31-21-generic; KDE/4.3.5; i686; ; )
In-Reply-To: <1271810562-4196-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145409>

onsdagen den 21 april 2010 02.42.41 skrev  Bert Wesarg:
> This lets the user of git cvsexportcommit specify a cvs working dir on a
>  per branch basis.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> 
> ---
> 
> The config variable name is currently cvsexportcommit.<branch>.cvsdir, but
> could also be branch.<branch>.cvsdir. Or whatever is prefereable.

Your suggested names are fine and the idea is sound. 

-- robin
