From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: introduce --parents parameter for commands
 branch and tag
Date: Mon, 20 May 2013 22:13:40 +0000
Message-ID: <20130520221340.GA8781@dcvr.yhbt.net>
References: <1368476549-17886-1-git-send-email-tobias.schulte@gliderpilot.de>
 <1368648883-9412-1-git-send-email-tobias.schulte@gliderpilot.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tobias Schulte <tobias.schulte@gliderpilot.de>
X-From: git-owner@vger.kernel.org Tue May 21 00:13:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYKw-0005F8-KG
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139Ab3ETWNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:13:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46044 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757246Ab3ETWNl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:13:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09FEA1F42C;
	Mon, 20 May 2013 22:13:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1368648883-9412-1-git-send-email-tobias.schulte@gliderpilot.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224986>

Tobias Schulte <tobias.schulte@gliderpilot.de> wrote:
> This parameter is equivalent to the parameter --parents on svn cp commands
> and is useful for non-standard repository layouts.
> 
> Signed-off-by: Tobias Schulte <tobias.schulte@gliderpilot.de>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

Applied and pushed, thanks.
