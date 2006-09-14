From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Historical kernel repository size
Date: Thu, 14 Sep 2006 16:38:29 +0100
Message-ID: <45097775.4040005@shadowen.org>
References: <20060914142249.GK23891@pasky.or.cz> <46900.194.138.39.52.1158244729.squirrel@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 17:39:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNtJA-0002Yp-RR
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 17:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWINPjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 11:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWINPjK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 11:39:10 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:5643 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750849AbWINPjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 11:39:09 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GNtIM-0000du-Ua; Thu, 14 Sep 2006 16:38:31 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: tglx@linutronix.de
In-Reply-To: <46900.194.138.39.52.1158244729.squirrel@www.tglx.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27002>

tglx@linutronix.de wrote:
> Petr,
> 
>>   just to test the packing improvements we had achieved over the last
>> year, I have repacked the historical kernel repository and achieved a
>> significant improvement:
>> ....
>>   Since it's a nice place for people to check about how efficient we are
>> with compressing the repository, perhaps it would be a good idea to
>> repack the historical repository on kernel.org?
> 
> I'll do once I'm back home.

Is there any reason this isn't a live history.  ie that we don't
constantly pull linus' master branch into this history to make it a real
complete history?

Perhaps that isn't possible ... hmmm.  I guess it might only work if
linus' repo was actually a grafted version of this history?

/me watches his head explode.

-apw
