From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 22:13:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601082212420.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
 <46a038f90601082208i95cd19fmda542da0da8cc9ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 07:14:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvqI5-00075p-7x
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 07:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWAIGN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 01:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWAIGN5
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 01:13:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751043AbWAIGNz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 01:13:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k096DoDZ018442
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Jan 2006 22:13:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k096DnNL021092;
	Sun, 8 Jan 2006 22:13:50 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601082208i95cd19fmda542da0da8cc9ef@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14355>



On Mon, 9 Jan 2006, Martin Langhoff wrote:
> 
> and if it does anything but a very trivial merge, backtrack and do a merge.

To be fair, backtracking a "git-rebase" isn't obvious. One of the 
downsides of rebasing.

		Linus
