From: Pavel Roskin <proski@gnu.org>
Subject: Re: Problem upgrading to 1.4.0
Date: Mon, 12 Jun 2006 23:02:39 -0400
Message-ID: <1150167759.4297.95.camel@dv>
References: <93c3eada0606101707t5eb35a4du3ebd0fd17737943f@mail.gmail.com>
	 <7v1wtwh246.fsf@assigned-by-dhcp.cox.net> <1150165982.4297.88.camel@dv>
	 <20060612224818.383b13ee.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 13 05:03:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpzBY-0002jy-JU
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 05:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805AbWFMDCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 23:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932803AbWFMDCp
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 23:02:45 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:58263 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932805AbWFMDCp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 23:02:45 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FpzAy-0000YI-5X
	for git@vger.kernel.org; Mon, 12 Jun 2006 23:02:44 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FpzAt-0003w1-Nt; Mon, 12 Jun 2006 23:02:39 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <20060612224818.383b13ee.seanlkml@sympatico.ca>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21757>

Hi, Sean!

On Mon, 2006-06-12 at 22:48 -0400, Sean wrote:
> Hi Pavel,
> 
> You can get a list of the remote branches whenever you want:
> 
> $ git ls-remote -h <remote>

I heard of that command.  But git-clone only uses it for local and rsync
protocols.  If it's so good, shouldn't it be used unconditionally or at
least with minimal exceptions (some kinds of local clones)?

-- 
Regards,
Pavel Roskin
