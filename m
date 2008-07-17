From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Fri, 18 Jul 2008 00:24:37 +0200
Message-ID: <200807180024.37766.robin.rosenberg.lists@dewire.com>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com> <200807172331.18059.robin.rosenberg.lists@dewire.com> <20080717214520.GB2798@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 00:31:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJbzy-0000Ck-Ua
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 00:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbYGQW34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 18:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759890AbYGQW34
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 18:29:56 -0400
Received: from av6-1-sn3.vrr.skanova.net ([81.228.9.179]:38410 "EHLO
	av6-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758879AbYGQW3z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 18:29:55 -0400
Received: by av6-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id BCBC83A824; Fri, 18 Jul 2008 00:29:51 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av6-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id F30473830C; Fri, 18 Jul 2008 00:29:50 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id CC67C37E42;
	Fri, 18 Jul 2008 00:29:50 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080717214520.GB2798@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88932>

torsdagen den 17 juli 2008 23.45.20 skrev Shawn O. Pearce:
> Looking at the code further its fairly simple.  I don't think it
> would be difficult for us to tweak what we need, and try to push
> patches upstream.  Well worthwhile actually.  The parser made our pgm
> package shorter, and we didn't have to waste time writing our own.
> Its well built, and was (mostly) easily extended to handle fully
> transparent String->RevCommit or String->RevTree parsing.  So its
> worth the few minutes to improve it further.

Ok, then. Go ahead.

-- robin
