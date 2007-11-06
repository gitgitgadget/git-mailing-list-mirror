From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Tue, 6 Nov 2007 22:21:56 +0100
Message-ID: <200711062221.58475.robin.rosenberg.lists@dewire.com>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <200711062106.57083.robin.rosenberg.lists@dewire.com> <20071106201324.GA30262@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 22:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpVqq-00070p-Op
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbXKFVU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 16:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755058AbXKFVU2
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:20:28 -0500
Received: from [83.140.172.130] ([83.140.172.130]:29403 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754468AbXKFVU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 16:20:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 86C19802661;
	Tue,  6 Nov 2007 22:11:28 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03289-06; Tue,  6 Nov 2007 22:11:28 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3BDC480265C;
	Tue,  6 Nov 2007 22:11:28 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20071106201324.GA30262@glandium.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63730>

tisdag 06 november 2007 skrev Mike Hommey:
> Maybe the documentation could emphasise on how to undo things when the
> user makes mistakes.
> Sometimes, saving your repo can be as simple as git reset --hard HEAD@{1}.
> This is not, unfortunately, a works-for-all-cases command.

Yea, git-undo(7). 

-- robin
