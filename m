From: David Miller <davem@davemloft.net>
Subject: Re: [bug] first line truncated with `git log --oneline --decorate
 --graph`
Date: Thu, 16 Apr 2015 11:56:28 -0400 (EDT)
Message-ID: <20150416.115628.1228076242478955092.davem@davemloft.net>
References: <552F8B85.2000908@gmail.com>
	<xmqqwq1chz2s.fsf@gitster.dls.corp.google.com>
	<7139e45030c23bb642c5fe35e4074c6a@www.dscho.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, robin.moussu@gmail.com, git@vger.kernel.org,
	git-owner@vger.kernel.org
To: johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Thu Apr 16 17:56:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yim9l-0005U8-5x
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 17:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbbDPP4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 11:56:32 -0400
Received: from shards.monkeyblade.net ([149.20.54.216]:33185 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbbDPP4b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 11:56:31 -0400
Received: from localhost (cpe-66-108-87-106.nyc.res.rr.com [66.108.87.106])
	(Authenticated sender: davem-davemloft)
	by shards.monkeyblade.net (Postfix) with ESMTPSA id 14602581B73;
	Thu, 16 Apr 2015 08:56:29 -0700 (PDT)
In-Reply-To: <7139e45030c23bb642c5fe35e4074c6a@www.dscho.org>
X-Mailer: Mew version 6.6 on Emacs 24.4 / Mule 6.0 (HANACHIRUSATO)
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Apr 2015 08:56:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267302>


Hey folks, please remove git-owner from the CC: list, that goes
to me and not the list :-)
