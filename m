From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] push/pull: adjust missing upstream help text to changed
 interface
Date: Wed, 07 Nov 2012 09:22:38 +0100
Message-ID: <509A1A4E.5060805@drmicha.warpmail.net>
References: <00F68AED-5D59-44F2-B0F1-E541881BC2CB@uva.nl> <bd710e422cb8ca0cec4cf52ea3c9ddb284d6c60d.1352197626.git.git@drmicha.warpmail.net> <03ff9252-71dc-4c28-a542-d65d16ba6549@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeroen van der Ham <vdham@uva.nl>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:22:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TW0uT-00015t-Qm
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 09:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434Ab2KGIWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 03:22:41 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57452 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751346Ab2KGIWk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2012 03:22:40 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 15EF320865;
	Wed,  7 Nov 2012 03:22:40 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 07 Nov 2012 03:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=rskleAShAS907BEXXVXnSM
	XCZiM=; b=H1vVv2Gq1++OvqtJ5fFOZB+AguRr0SJ9mytO7UZNRT4eusZl8Le4H7
	8HH2D/uPCmhjHa63HnkQ5C/ZipHS953t96o8ITrGUAdp5ddc7TNrJdHbXwktR+mS
	6vbcieQ9Zr8dF7IqiGKZT5prfY9FzzMuTWd3P5oJYNk8Kle7fZ5fw=
X-Sasl-enc: DvVXB+7QRymcUG5K/LB/epQvsL0d/8lhA8HyNctPRSe6 1352276559
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5A933482655;
	Wed,  7 Nov 2012 03:22:39 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <03ff9252-71dc-4c28-a542-d65d16ba6549@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209131>

Junio C Hamano venit, vidit, dixit 06.11.2012 15:45:
> 
> 
> Michael J Gruber <git@drmicha.warpmail.net> wrote:
> 
>> Yes, I'm in low hanging fruits mood.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> 
> It is called tying loose ends, and is very important. Very much appreciated.

;)

By the way: The gotcha with the signed-off-by after the note is due to
my old format-patch-notes being tripped up by the recent restructuring;
your version in next get's it right. I've dumped my old branch, and I
hope the maintainer in chief will shuffle around the s-o-b where it belongs.

Michael
