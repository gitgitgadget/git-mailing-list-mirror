From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCHES] Assorted minor fixes
Date: Tue, 10 Jun 2008 08:29:50 +0200
Message-ID: <200806100829.50793.robin.rosenberg.lists@dewire.com>
References: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com> <20080610003144.GD4389@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 08:35:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5xSC-0003NH-SC
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 08:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbYFJGen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 02:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbYFJGen
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 02:34:43 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:53199 "EHLO
	pne-smtpout2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062AbYFJGen (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 02:34:43 -0400
Received: from shx250sn1.teliamobile.net (192.71.148.164) by pne-smtpout2-sn2.hy.skanova.net (7.3.129)
        id 47A02DB90285907E; Tue, 10 Jun 2008 08:34:41 +0200
Received: from [10.145.100.134] ([10.145.100.134])
	by shx250sn1.teliamobile.net (8.13.1/8.13.1) with ESMTP id m5A6YZCu029300;
	Tue, 10 Jun 2008 08:34:38 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080610003144.GD4389@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84476>

tisdagen den 10 juni 2008 02.31.44 skrev Shawn O. Pearce:
> How did you you send this series?  Its not format-patch output.
> The diff-stat is missing from each commit, and there's no ---
> to split message from diff.  I didn't bother trying to run them
> through git-am yet as I assume I can just fetch from you, I'm
> just saying the patches look "odd".

It was git format-patch --binary. Seems that option drops the diffstat
in that case. Yes you can just pull and get the same series. I mostly
sent it as patches for review purposes. It is much easier in e-mail.
Using gtik for reviiew isn't optimal. A nice tool for reviewing and
commenting directly from a repo would be nice.

-- robin
