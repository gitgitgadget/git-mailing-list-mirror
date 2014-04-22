From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] git-svn: only look at the new parts of svn:mergeinfo
Date: Tue, 22 Apr 2014 18:47:17 +0000
Message-ID: <20140422184717.GA16766@dcvr.yhbt.net>
References: <1397717646-54248-1-git-send-email-stoklund@2pi.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>
To: Jakob Stoklund Olesen <stoklund@2pi.dk>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:47:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcfj7-0001ta-A8
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 20:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbaDVSrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 14:47:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47068 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbaDVSrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 14:47:17 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1B320F72;
	Tue, 22 Apr 2014 18:47:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1397717646-54248-1-git-send-email-stoklund@2pi.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246767>

Thanks!  I still haven't gotten around to looking at svn:mergeinfo
things, but this passes tests so I'm inclined to merge this unless
somebody disagrees.
