From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Mon, 9 Jun 2008 21:39:58 +0200
Message-ID: <200806092139.58485.robin.rosenberg@dewire.com>
References: <20080526044640.GB30245@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Dave Watson <dwatson@mimvista.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org,
	Philippe Ombredanne <philippe@easyeclipse.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 09 21:44:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5nHu-0004I3-0P
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 21:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbYFITnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 15:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbYFITnH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 15:43:07 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15362 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754088AbYFITnG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 15:43:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 44EC21434DE0;
	Mon,  9 Jun 2008 21:43:03 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ApqJbIgYU+F; Mon,  9 Jun 2008 21:43:02 +0200 (CEST)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id C0C3A800681;
	Mon,  9 Jun 2008 21:43:02 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080526044640.GB30245@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84412>

Hi, all

I've got confirmation from all needed parties and pushed the license changes to master. 
See http://repo.or.cz/w/egit.git?a=commit;h=2baa6eb54706926f74d8ca5a10c7f0448acb5fe6
and http://repo.or.cz/w/egit.git?a=commit;h=53a2cc3f6144ddcc10954d3abf68a5b90ed95248

The changes plus some fixes to the fetch code has been merged and pushed to master.

Philippe, It would be nice if you could check to see that the licensing looks ok. We can hand
over the complete e-mail messages separately from the commit comments.

I think we need to complement the UI for fetch plus and couple other fixes and do more testing befire
bumping the revision number. 

-- robin
