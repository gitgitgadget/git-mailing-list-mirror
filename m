From: Hans-Christoph Steiner <hans@at.or.at>
Subject: Re: native-style key bindings for gitk on Mac OS X
Date: Mon, 13 Dec 2010 11:28:45 -0500
Message-ID: <29A2F453-C1F8-4C7E-A35B-3F159EB693B8@at.or.at>
References: <681947AB-F2D2-4EBC-A635-09E28FC27256@at.or.at> <4D05D998.5080107@op5.se>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Dec 13 17:28:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSBGl-0000d6-DN
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 17:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758074Ab0LMQ2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 11:28:53 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34688 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758032Ab0LMQ2w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 11:28:52 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8180EA10;
	Mon, 13 Dec 2010 11:28:46 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 13 Dec 2010 11:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references; s=smtpout; bh=Q+jhKoOrBlcokxpGRIaIyfFECU4=; b=E3SbWZumsR9yntQUsjXsTBlqu/Q9nRsdTasZKR1k3SdYQS8iNPKW1ldSN1BTWovrmCvGbLauyjdFPQmLa9rhvXfXcrK4ERX3vKTLB8T9mKeBsbo5Zcwd5mPkiqjtfdwPRiYzNpX+9L614jwKXVD4AvGr7mfl2LekK08C4HSzqp0=
X-Sasl-enc: 0k1VPvCbcQkoHdMjOiJgzCRr3d7ZfClBaxQA9LzLUB5s 1292257726
Received: from dhcp-10.4.0.169.at.or.at (ool-182d0ad9.dyn.optonline.net [24.45.10.217])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1ABE9440521;
	Mon, 13 Dec 2010 11:28:46 -0500 (EST)
In-Reply-To: <4D05D998.5080107@op5.se>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163562>


On Dec 13, 2010, at 3:30 AM, Andreas Ericsson wrote:

> On 12/12/2010 11:08 PM, Hans-Christoph Steiner wrote:
>>
>> Hey all,
>>
>> This is my first post here, hopefully I'm not doing anything stupid
>> ;) I use gitk on Debian, Ubuntu, and Mac OS X. I'm big on having apps
>> feel native on each platform. Currently gitk's key bindings are very
>> GNU/Linux-ish when using gitk on Mac OS X. I'd like to submit a patch
>> to make gitk use native-style key bindings and re-use common key
>> bindings.
>
> So long as the patch lets the original keys work (ie, people who are
> used to them as they are now aren't suddenly hit by a nasty surprise),
> I think it's a great idea.
>
>> Before starting this, I just wanted to make sure this isn't some
>> hotly debated political issue.
>>
>
> It will be if the old keys stop working or all of a sudden do  
> something
> different. Especially if the new thing it does isn't exactly harmless
> but the old thing was.


I think that's a good idea.  The only problem is Cmd-F5 (i.e. Reload)  
is already globally claimed in Mac OS X to turn on the accessibility  
voiceover reader.  So all you get is a robot voice reading your GUI to  
you.  This could be Ctrl-F5 instead, then it'd be the same as on GNU/ 
Linux.

.hc




----------------------------------------------------------------------------

"[T]he greatest purveyor of violence in the world today [is] my own  
government." - Martin Luther King, Jr.
