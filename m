From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/4] win32: Improve the conditional inclusion of WIN32
 API   code
Date: Wed, 04 Nov 2009 19:40:41 +0000
Message-ID: <4AF1D8B9.9040603@ramsay1.demon.co.uk>
References: <4AE746C6.9060409@ramsay1.demon.co.uk> <4AEFDE9D.6060200@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:22:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5mNQ-0008NR-Ux
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 21:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbZKDUWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 15:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbZKDUWY
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 15:22:24 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:43172 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932330AbZKDUWY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 15:22:24 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1N5mNA-0001j3-i5; Wed, 04 Nov 2009 20:22:29 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4AEFDE9D.6060200@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132143>

Johannes Sixt wrote:
> It may be that I understand something incorrectly; but then I blame the
> justification that you gave. In this case, it would be helpful to reword
> the commit message, and perhaps add some results from your experiments.
> 

The discussion which lead to this patch, including the experiments, can be
found in the email thread starting here:

    http://thread.gmane.org/gmane.comp.version-control.git/129403

(along with some other unrelated stuff; but it's not a long read :)

In the above thread, Marius suggested API_WIN32, but I switched it around, since
I thought it sounded better! I also thought about GIT_WIN32. Suggestions?

ATB,
Ramsay Jones
