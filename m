From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Branch bar in resource history.
Date: Mon, 10 Mar 2008 01:00:28 +0100
Message-ID: <200803100100.28927.robin.rosenberg@dewire.com>
References: <1204954828-3937-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dave Watson <dwatson@mimvista.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 01:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYVS4-0003yN-Vh
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 01:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbYCJAAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 20:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYCJAAd
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 20:00:33 -0400
Received: from [83.140.172.130] ([83.140.172.130]:28799 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbYCJAAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 20:00:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 30284802671;
	Mon, 10 Mar 2008 01:00:31 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PCx0q4MQM9Hh; Mon, 10 Mar 2008 01:00:29 +0100 (CET)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id B9486802655;
	Mon, 10 Mar 2008 01:00:29 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1204954828-3937-1-git-send-email-rogersoares@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76687>

Den Saturday 08 March 2008 06.40.28 skrev Roger C. Soares:
> Adds a bar to show the current branch in resource history.
> Because other programs can change the current branch, the branch bar
> helps the user to remember what is being displayed in resource history.
> The bar can be disabled through a local menu preference.

Good idea, but I wonder if we wouldn't be better off trying too keep compact
and do this decoration in the first bar instead, either as an icon or just 
text. I only have 15 inches of preciousss screen space. Compare to what you 
did with the compare view in removing those unnecessary directory levels that
really only wasted space. That was very good.

Another idea would be to allow the user to filter which branches and I think
one could combine this indicator with that functionality through e.g. a poup 
menu. 

The green color on the indicator sugests something is "ok"?

-- robin
