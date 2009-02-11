From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Wed, 11 Feb 2009 09:12:49 -0500
Message-ID: <4992DCE1.60008@tedpavlic.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com> <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com> <4992DA9E.4040107@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Feb 11 15:15:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXFrH-0007wg-Gu
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 15:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbZBKOM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 09:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbZBKOM5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 09:12:57 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:38654 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754701AbZBKOM5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 09:12:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 4CE8780D8036;
	Wed, 11 Feb 2009 09:06:26 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U3n97gZEjkvO; Wed, 11 Feb 2009 09:06:26 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 378AD80D8005;
	Wed, 11 Feb 2009 09:06:26 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <4992DA9E.4040107@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109419>

>> No upgrade should be necessary. Could you give me some information
>> about what terminal application you are using. Also, have you added
>> any specific color settings to ~/.tigrc?
>
> OS X 10.4.11
> iTerm 0.9.6.1201
> TERM=xterm-color
>
> I have no ~/.tigrc

Perhaps not surprisingly, when I ssh into a Linux machine and run tig, I 
have the same problem.

That is, "tig" is being run on the Linux machine, but the terminal is on 
my Mac.

It might be interesting that although several people with this problem 
use a Mac, we do not use the same terminal program.

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
