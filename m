From: Adam Roben <aroben@apple.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Mon, 3 Sep 2007 22:47:54 -0700
Message-ID: <EFDB3AF7-E250-4816-AD4A-B580E3C902C1@apple.com>
References: <20070831000149.GK1219@pasky.or.cz> <7v8x7n7zqn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v902)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org, jnareb@gmail.com,
	ltuikov@yahoo.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 07:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRGm-0002Gw-NZ
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 07:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbXIDFsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 01:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXIDFsG
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 01:48:06 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49317 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbXIDFsF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 01:48:05 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 44B34102E2C3;
	Mon,  3 Sep 2007 22:48:03 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 251D628051;
	Mon,  3 Sep 2007 22:48:03 -0700 (PDT)
X-AuditID: 11807134-a0b61bb0000066ad-78-46dcf19342e4
Received: from [17.151.70.3] (unknown [17.151.70.3])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay14.apple.com (Symantec Mail Security) with ESMTP id A60822802B;
	Mon,  3 Sep 2007 22:48:02 -0700 (PDT)
In-Reply-To: <7v8x7n7zqn.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.902)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57524>


On Sep 3, 2007, at 10:42 PM, Junio C Hamano wrote:

> * Incremental blame
>
>  It does not seem to break the blame, but at least from where I
>  sit accessing repo.or.cz this does not look incremental to me.
>  The entire browser session freezes until the blame page
>  displays in full.  My local installation behaves the same way.

    For me, [1] loads incrementally as expected in Safari 3.0.3 on OS X.

-Adam

[1] http://repo.or.cz/w/alt-git.git?a=blame_incremental;f=git-svn.perl;h=d3c8cd0b8e3cfb97c6deb2453097c6f2e16e3bcf;hb=1e61b7640d09015213dbcae3564fa27ac6a8c151
