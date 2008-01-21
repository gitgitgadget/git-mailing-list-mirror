From: Mark Junker <mjscod@web.de>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to
   UTF8
Date: Mon, 21 Jan 2008 12:49:02 +0100
Message-ID: <fn20ra$c4e$2@ger.gmane.org>
References: <fn1nl6$ek5$1@ger.gmane.org> <alpine.LSU.1.00.0801211121440.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 12:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGv9n-00037r-5E
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 12:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbYAULtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 06:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbYAULtJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 06:49:09 -0500
Received: from main.gmane.org ([80.91.229.2]:50263 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbYAULtI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 06:49:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JGv9G-0008GU-5K
	for git@vger.kernel.org; Mon, 21 Jan 2008 11:49:06 +0000
Received: from 80.146.179.234 ([80.146.179.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 11:49:06 +0000
Received: from mjscod by 80.146.179.234 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 11:49:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80.146.179.234
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
In-Reply-To: <alpine.LSU.1.00.0801211121440.5731@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71273>

Johannes Schindelin schrieb:

> - it is too specific to the MacOSX filesystem issues (and better 
>   alternatives have _already_ been proposed),

I know that there were proposed alternatives but I like to use git on 
MacOSX now and not in XY months.

> - it is a new feature and not a bug fix, very, _very_ late in the rc 
>   cycle,

It was never meant for inclusion now. I know that this is post-1.5.4 stuff.

Regards,
Mark
