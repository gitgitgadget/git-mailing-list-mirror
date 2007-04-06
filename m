From: Geert Bosch <bosch@gnat.com>
Subject: Re: [PATCH] Fix renaming branch without config file
Date: Fri, 6 Apr 2007 07:33:39 -0400
Message-ID: <F686C01F-FC5B-4644-812D-749960F8F3BA@gnat.com>
References: <20070405144359.4B8832A7C67@potomac.gnat.com> <Pine.LNX.4.63.0704051728400.4045@wbgn013.biozentrum.uni-wuerzburg.de> <B0C79D8E-07A8-4178-B0A6-698EB2BB5A2A@gnat.com> <Pine.LNX.4.63.0704051951170.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 06 13:42:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZmhM-0001kL-9N
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 13:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767588AbXDFLdl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 07:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767590AbXDFLdl
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 07:33:41 -0400
Received: from nile.gnat.com ([205.232.38.5]:61600 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767588AbXDFLdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 07:33:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 4128D48CFA0;
	Fri,  6 Apr 2007 07:33:40 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 22386-01-4; Fri,  6 Apr 2007 07:33:40 -0400 (EDT)
Received: from [172.16.1.99] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 845DE48CFA9;
	Fri,  6 Apr 2007 07:33:38 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.63.0704051951170.4045@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43908>


On Apr 5, 2007, at 13:51, Johannes Schindelin wrote:
> Ah, yes. You are completely right!
>
>> The proposed patch makes the behavior of an absent config file the  
>> same
>> as the behavior of an empty one, which seems sane to me. There  
>> should be
>> no warning, as it is perfectly fine to have no config file. Could you
>> elaborate on why you believe my patch is not correct?
>
> I elaborate by taking my objections back. Fair enough?

Sure ;-)

Thanks for commenting on my patch.

   -Geert
