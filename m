From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Wed, 11 Feb 2009 12:47:06 -0500
Message-ID: <49930F1A.6030509@tedpavlic.com>
References: <20090205204436.GA6072@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:48:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJCU-0000Jf-7i
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbZBKRrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbZBKRrP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:47:15 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:39818 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754378AbZBKRrO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 12:47:14 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 4CAAF80D8088;
	Wed, 11 Feb 2009 12:40:43 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2N2-IYwfcLGk; Wed, 11 Feb 2009 12:40:43 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 337D880D8036;
	Wed, 11 Feb 2009 12:40:43 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <20090205204436.GA6072@diku.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109456>

> What is tig?


*) Is there any way for "tig" to emulate "less -R"?

That is, if an output is already colorized, can tig just pass through 
the ANSI?


*) When doing "git diff|tig" when there directory is clean, tig should 
probably exit immediately, right?


*) Also, is there a way to configure "tig" to colorize and *exit* if the 
piped text doesn't fill a page?


(in other words, I'd like "tig" to be able to replace my current "less 
-FRX" pager)

Thanks --
Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
