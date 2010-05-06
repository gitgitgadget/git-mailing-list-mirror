From: Dave Abrahams <dave@boostpro.com>
Subject: Re: Instead of rebasing, etc....?
Date: Thu, 6 May 2010 22:50:30 +0000 (UTC)
Message-ID: <loom.20100507T004928-336@post.gmane.org>
References: <loom.20100507T003055-527@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 00:50:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA9u3-00045o-D2
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab0EFWul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:50:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:42079 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab0EFWuk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:50:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OA9tt-00041z-4Z
	for git@vger.kernel.org; Fri, 07 May 2010 00:50:37 +0200
Received: from 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com ([207.172.223.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 May 2010 00:50:37 +0200
Received: from dave by 207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 May 2010 00:50:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 207.172.223.249 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-US) AppleWebKit/533.2 (KHTML, like Gecko) Chrome/5.0.342.9 Safari/533.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146509>

Dave Abrahams <dave <at> boostpro.com> writes:

> 
> I often find myself pursuing a development branch ...

Sorry, my ASCII art was messed up in the previous message.  
Here's what I meant:

o-o-o-o origin/dev
   \
    o-o-o dev


o-o-o-o - -o origin/dev dev
   \      / 
    o-o-o 
