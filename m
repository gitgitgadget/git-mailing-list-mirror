From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT RFC] Mavenized JGit
Date: Fri, 6 Jun 2008 13:59:15 +0200
Message-ID: <200806061359.16568.robin.rosenberg.lists@dewire.com>
References: <7bfdc29a0806030742r77b79786n92a5ce6a0aba7726@mail.gmail.com> <20080604195934.GU12896@spearce.org> <7bfdc29a0806052228s2fe764d1pe5d2b8e129115c77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Nigel Magnay" <nigel.magnay@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4aev-0007vI-5j
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbYFFMCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754583AbYFFMCL
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:02:11 -0400
Received: from [83.140.172.130] ([83.140.172.130]:20985 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754260AbYFFMCK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:02:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B8AC18006B6;
	Fri,  6 Jun 2008 14:02:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id REwzuUvs4F85; Fri,  6 Jun 2008 14:02:08 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 40861800681;
	Fri,  6 Jun 2008 14:02:08 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7bfdc29a0806052228s2fe764d1pe5d2b8e129115c77@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84051>

fredagen den 6 juni 2008 07.28.59 skrev Imran M Yousuf:
> I have just tested it and it works fine. Now maven is configured to
> use the existing locations for source and it builds fine.

I squashed the two commits involving pom.xml into a new branchy and it works here to. 
Still you have  a duplicate of the test directory. Can that be fixed too?

-- robin
