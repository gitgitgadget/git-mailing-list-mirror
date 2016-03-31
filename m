From: Theo Niessink <theo@taletn.com>
Subject: Re: Problem with Integrated Vim Editor on Win 10
Date: Thu, 31 Mar 2016 06:03:10 +0000 (UTC)
Message-ID: <loom.20160331T075527-999@post.gmane.org>
References: <CAAErz9i1=EOemq2qNijRwgY6MNmPJRhV+mFfeD1FZa5uPwvCJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 08:05:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alVjG-0005Lj-DB
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 08:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbcCaGFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 02:05:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:58871 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbcCaGFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 02:05:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1alVj5-0005I4-Hs
	for git@vger.kernel.org; Thu, 31 Mar 2016 08:05:03 +0200
Received: from ip4daa44b3.direct-adsl.nl ([77.170.68.179])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 08:05:03 +0200
Received: from theo by ip4daa44b3.direct-adsl.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 08:05:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.170.68.179 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/601.5.17 (KHTML, like Gecko) Version/9.1 Safari/601.5.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290372>

Zachary Turner <zturner <at> google.com> writes:

> Has anyone seen anything like this before, or have any ideas how I might
> better diagnose this?

Not before, but I can confirm this issue on Win10, and reportedly on Win7 as
well. Actually I thought this was a Git for Windows specific issue, so I
reported it on GitHub; it didn't occur to  me that it could be a VIM issue. So
I guess you have already diagnosed this better than I did...
