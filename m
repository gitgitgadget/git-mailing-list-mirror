From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH 2/2] completion: Get rid of tabbed indentation in comments.
 Replace with spaces.
Date: Fri, 06 Feb 2009 11:19:20 -0500
Message-ID: <498C6308.1000700@tedpavlic.com>
References: <20090206155823.GO26880@spearce.org> <1233936338-10679-1-git-send-email-ted@tedpavlic.com> <1233936338-10679-2-git-send-email-ted@tedpavlic.com> <20090206161303.GP26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, gitster <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 17:21:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTRn-0001Ii-9Z
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbZBFQTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbZBFQT3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:19:29 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:47252 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751212AbZBFQT2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 11:19:28 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id B048E80D8067;
	Fri,  6 Feb 2009 11:13:05 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u5lRHQ4BhR21; Fri,  6 Feb 2009 11:13:05 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 9B87780D8063;
	Fri,  6 Feb 2009 11:13:05 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <20090206161303.GP26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108757>

> I expected Junio to use my TAB line as-is.  I find them amusing.

Oops. :( In the future, I'll leave such things as is. I just figured the 
"Trivially" was a side comment, but the function was still the same.

> Thanks for fixing that ${X-} thing.  I clearly missed it on the
> review of the ps1 stuff.

I would have missed it myself... but then after I did a git pull, I was 
getting a bash error on every single prompt. That was annoying. :)

Thanks --
Ted


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
