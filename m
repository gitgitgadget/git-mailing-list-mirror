From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Commit to wrong branch. How to fix?
Date: Sat, 05 Sep 2009 14:51:33 +0200
Message-ID: <4AA25ED5.1020700@drmicha.warpmail.net>
References: <88A0A7C2-7DCB-45A3-B196-BED2A8AC9405@googlemail.com>	 <4AA13DF4.4050604@drmicha.warpmail.net> <40aa078e0909041011s7639cccbqa758f17a56c61863@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Howard Miller <howardsmiller@googlemail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 14:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjukl-00038p-SZ
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 14:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbZIEMvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 08:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbZIEMvo
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 08:51:44 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54666 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751420AbZIEMvo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2009 08:51:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 89212633EC;
	Sat,  5 Sep 2009 08:51:45 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 05 Sep 2009 08:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=E60aF0+yO32PmxVihjtJXDLLOQY=; b=giNAjmKhf+ivBjRLE92qRwQcAECsPLLBhRe3GirqUX2fTbuNaTZRyfg19gl6kc3fuZK3pg0k7KTbWy44JPcmYARbjdrwWHrBpUGRmaVVulW4enuzjwwingx31yqEAjHqyzHtK/hWF/BYor4ga1etHMbdcptp3TPajyyibVzv778=
X-Sasl-enc: 7DvzQnNY2OjrPojH3D/IW7w4eS083MygU2qf2ko1duWm 1252155105
Received: from localhost.localdomain (p5DCC0BE2.dip0.t-ipconnect.de [93.204.11.226])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B5FA434AB;
	Sat,  5 Sep 2009 08:51:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090902 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <40aa078e0909041011s7639cccbqa758f17a56c61863@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127812>

Erik Faye-Lund venit, vidit, dixit 04.09.2009 19:11:
> On Fri, Sep 4, 2009 at 6:19 PM, Michael J
> Gruber<git@drmicha.warpmail.net> wrote:
>> Let's say "geesh" is the branch on which you committed by mistake, and
>> which you have reset.
>>
>> git reflog geesh
> 
> That should be "git reflog show geesh", no?
> 

Yes, sorry. "show" is default, but only without a branch arg :|

Michael
