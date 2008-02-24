From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Refresh history when "Refresh" is clicked in the history viewer.
Date: Sun, 24 Feb 2008 23:40:08 +0100
Message-ID: <200802242340.09606.robin.rosenberg@dewire.com>
References: <1203895097-3742-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:50:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTPft-0003ax-3T
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 23:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbYBXWtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 17:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbYBXWtt
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 17:49:49 -0500
Received: from [83.140.172.130] ([83.140.172.130]:15018 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbYBXWtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 17:49:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 6B19A802677;
	Sun, 24 Feb 2008 23:49:47 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nKCLo4nNxw2d; Sun, 24 Feb 2008 23:49:46 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 52C818006BB;
	Sun, 24 Feb 2008 23:49:46 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1203895097-3742-1-git-send-email-rogersoares@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74973>

m=C3=A5ndagen den 25 februari 2008 skrev Roger C. Soares:
> ---
>  .../src/org/spearce/egit/ui/GitHistoryPage.java    |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

Looks ok, but what is the effect of refresh, besides possibly working a=
round
other bugs? I would expect to to refresh with the selected resource as =
"filter",
but it doesn't.

-- robin
