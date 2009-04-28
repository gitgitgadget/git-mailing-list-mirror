From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add --reference option to git submodule
Date: Tue, 28 Apr 2009 15:12:40 +0200
Message-ID: <49F700C8.10200@drmicha.warpmail.net>
References: <20090428065237.GA5972@redhat.com> <49F6E419.1020308@drmicha.warpmail.net> <20090428112519.GB27513@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 15:12:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyn7J-0000uZ-HZ
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 15:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbZD1NMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 09:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753937AbZD1NMt
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 09:12:49 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59017 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753243AbZD1NMt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 09:12:49 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 237F032873C;
	Tue, 28 Apr 2009 09:12:48 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 28 Apr 2009 09:12:48 -0400
X-Sasl-enc: aRf+mt+DPow22ppPBjMoPDs7mLC2VKYhLeO8x2wHaF7b 1240924367
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5E661173B3;
	Tue, 28 Apr 2009 09:12:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090428112519.GB27513@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117772>

Michael S. Tsirkin venit, vidit, dixit 28.04.2009 13:25:
> On Tue, Apr 28, 2009 at 01:10:17PM +0200, Michael J Gruber wrote:
>>> +
>>>  <path>...::
>>>  	Paths to submodule(s). When specified this will restrict the command
>>
>> Either "Path(s) to submodule(s)" or "Paths to submodules". I prefer the
>> latter.
>>
>>>  	to only operate on the submodules found at the specified paths.
>>
>> ..to operate on... paths only.
>>
> 
> I didn't touch these lines, so ... patch?
> 

You're right, they were only context (I got hyperactive it seems). It's
better to leave that for an overall style spring clean.

Michael
