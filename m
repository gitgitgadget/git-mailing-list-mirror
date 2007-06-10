From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Please pull mergetool.git
Date: Sun, 10 Jun 2007 19:29:51 -0400
Message-ID: <26568045-F443-415E-A250-29C7DD3998A9@silverinsanity.com>
References: <E1HxPt7-0007jV-6V@candygram.thunk.org> <7v1wgj8tzy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:30:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWrF-0005Iq-4n
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759821AbXFJX35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759847AbXFJX35
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:29:57 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46455 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759096AbXFJX34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:29:56 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 5B6A61FFC042;
	Sun, 10 Jun 2007 23:29:56 +0000 (UTC)
In-Reply-To: <7v1wgj8tzy.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49792>


On Jun 10, 2007, at 3:55 PM, Junio C Hamano wrote:

> I do not see problems in the mergetool part, other than that I
> mildly suspect that opendiff -- actually FileMerge -- might want
> to be in the test -n "$DISPLAY" section, but that is inherited
> from the previous iteration so in that sense leaving outside is
> a sane thing to do.

Actually, opendiff (as FileMerge.app) is available under OS X, where  
$DISPLAY is not set.

~~ Brian
