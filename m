From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Interim "What's cooking"
Date: Fri, 12 Feb 2016 23:49:53 +0000
Message-ID: <20160212234953.GA8691@dcvr.yhbt.net>
References: <xmqqsi10xhbk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 00:49:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNTK-0007a5-N3
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbcBLXtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:49:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:56212 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbcBLXty (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:49:54 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE53202F1;
	Fri, 12 Feb 2016 23:49:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqsi10xhbk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286098>

Junio C Hamano <gitster@pobox.com> wrote:
> * ew/connect-verbose (2016-01-28) 1 commit
>   (merged to 'next' on 2016-02-03 at ceac37e)
>  + pass transport verbosity down to git_connect

Btw, I posted v2 of this with tests added to t/t5570-git-daemon.sh

  http://mid.gmane.org/20160130085056.GA20118@dcvr.yhbt.net

Can you replace it with my v2 or would you prefer a standalone
patch for just the test?  Thanks.
