From: Kay Sievers <kay.sievers@suse.de>
Subject: Re: [PATCH] gitweb: allow working in repositories with textual symref HEAD
Date: Mon, 9 Jan 2006 13:27:22 +0100
Message-ID: <20060109122722.GA14187@vrfy.org>
References: <7vslrytcw7.fsf@assigned-by-dhcp.cox.net> <7v7j99ssfy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 13:27:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evw7a-0002zT-7P
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 13:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWAIM1b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 07:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWAIM1b
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 07:27:31 -0500
Received: from soundwarez.org ([217.160.171.123]:33161 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751214AbWAIM1a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 07:27:30 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id A308D75F1C; Mon,  9 Jan 2006 13:27:22 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7j99ssfy.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14372>

On Mon, Jan 09, 2006 at 12:42:41AM -0800, Junio C Hamano wrote:
> There is a change to git-core, proposed by Pavel and cooking for
> the last 6 weeks, to use textual symref to represent HEAD even
> on filesystems that support symbolic links.  It would break
> gitweb without this even on UNIX.

Applied and installed on kernel.org.

Thanks,
Kay
