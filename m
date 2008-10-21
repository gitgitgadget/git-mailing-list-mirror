From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] git property page for project properties.
Date: Tue, 21 Oct 2008 21:13:30 +0200
Message-ID: <200810212113.30414.robin.rosenberg.lists@dewire.com>
References: <1224529604-42397-1-git-send-email-tomi.pakarinen@iki.fi> <200810211950.50540.robin.rosenberg.lists@dewire.com> <f299b4f30810211109q7f2919f2r1d5cd8faf0048154@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: tomi.pakarinen@iki.fi
X-From: git-owner@vger.kernel.org Tue Oct 21 21:15:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsMh5-0003xN-AG
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 21:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbYJUTNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 15:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbYJUTNk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 15:13:40 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:54206 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472AbYJUTNj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 15:13:39 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id CFE6F380D3; Tue, 21 Oct 2008 21:13:36 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id B6D6238056; Tue, 21 Oct 2008 21:13:36 +0200 (CEST)
Received: from sleipner.dewire.com (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id A0D0037E46;
	Tue, 21 Oct 2008 21:13:36 +0200 (CEST)
Received: from dewire.com (unknown [10.9.0.1])
	by sleipner.dewire.com (Postfix) with ESMTP id AD65B1943;
	Tue, 21 Oct 2008 21:13:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 38363802E07;
	Tue, 21 Oct 2008 21:13:36 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F7MRB88TTVTm; Tue, 21 Oct 2008 21:13:35 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id A5A9080284E;
	Tue, 21 Oct 2008 21:13:35 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <f299b4f30810211109q7f2919f2r1d5cd8faf0048154@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98806>

tisdagen den 21 oktober 2008 20.09.13 skrev Tomi Pakarinen:
>  That is ok. I just didn't notice that method before. But, what if
> someone wants localize this plugin, he'll propably have to explode
> this back to switch statement.

No, we'd localize getDescription().

-- robin
