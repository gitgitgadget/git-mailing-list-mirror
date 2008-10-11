From: Paul Mackerras <paulus@samba.org>
Subject: Re: [Gitk Patch 0/6]
Date: Sat, 11 Oct 2008 13:44:30 +1100
Message-ID: <18672.4878.128010.174357@cargo.ozlabs.ibm.com>
References: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 04:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoUVr-0002d4-Oi
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 04:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbYJKCqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 22:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753896AbYJKCqN
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 22:46:13 -0400
Received: from ozlabs.org ([203.10.76.45]:41068 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753734AbYJKCqL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 22:46:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 77010DE188; Sat, 11 Oct 2008 13:46:08 +1100 (EST)
In-Reply-To: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97964>

Robin Rosenberg writes:

> (This is a resend to include gitk maintainer Paul Mackerras)

Thanks.

> I finally got tired of pressing Alt and some letter to activate menus in Gitk. 
> For example in "any" program you can press Alt-F to have the File menu drop 
> down and then select the underscored character to select the wanted menu.
> 
> This series makes it possible. Friends of TCL may think my solution is too
> hack-ish. It doesn't fix all of the similary problem (mostly button) but 
> that is the subject of later patches as it looks like it requires other
> means.

It'll do for a first cut, but there would be a nicer way to do it, I
think.

Also, I think patches 2 and 4 should be combined into one, as should
patches 5 and 6.  I'll do that and apply the series as 4 commits,
unless you have an objection.

Paul.
