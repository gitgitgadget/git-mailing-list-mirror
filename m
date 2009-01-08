From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 7/7] Create an automatic UI test for the Git Import Wizard
Date: Thu, 8 Jan 2009 19:57:20 +0100
Message-ID: <200901081957.20591.robin.rosenberg.lists@dewire.com>
References: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com> <1231433791-9267-7-git-send-email-robin.rosenberg@dewire.com> <1231433791-9267-8-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jan 08 20:04:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL05e-00021l-Nj
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 19:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759233AbZAHS5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 13:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759192AbZAHS5Z
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 13:57:25 -0500
Received: from mail.dewire.com ([83.140.172.130]:26389 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759129AbZAHS5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 13:57:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AC2081484F73;
	Thu,  8 Jan 2009 19:57:22 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IS7I-SQM7jQN; Thu,  8 Jan 2009 19:57:22 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 48CCE1484F72;
	Thu,  8 Jan 2009 19:57:22 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <1231433791-9267-8-git-send-email-robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104949>


We could hold onto this patch. It might be better if we start the built in git daemon and clone
from it, or from file, instread of jgit.org, but please try it out and see if it looks like a good a approach to
use SWTBot for UI tests.

-- robin
