From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Snipping on this list (Was: Re: [PATCHv2 3/3] git-add: rename -u
 to -a)
Date: Mon, 28 Feb 2011 10:05:08 +0100
Message-ID: <4D6B6544.2040404@drmicha.warpmail.net>
References: <cover.1298821535.git.git@drmicha.warpmail.net> <4D68D630.9000608@drmicha.warpmail.net> <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net> <AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com> <7v39n8ll0s.fsf@alter.siamese.dyndns.org> <4D6B5D09.8010806@drmicha.warpmail.net> <buomxlg35zq.fsf@dhlpc061.dev.necel.com> <4D6B6101.9090504@drmicha.warpmail.net> <buohbbo35g8.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 28 10:08:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptz5o-00073h-SQ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab1B1JIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:08:31 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34721 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752577Ab1B1JIa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 04:08:30 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 18D8B20CA2;
	Mon, 28 Feb 2011 04:08:30 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 28 Feb 2011 04:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=lsGy1ryuWVn5M4+tdjdgtNPr1kw=; b=AF/aVj6rcqzcaHLc3pUX6pbc3A5ZGXzySrMNkxGLGLSekG48hafnuvLvI/tOqarJJAPAiyvWV0ONRnYRleLWooIy+jQiA0SSayYRoWwHYMxKYji4HhhGsfRpmILuCBwGHSKzOb/dyilAn4rWwRTmOp3sxYw1L6mSkIyi9NVpOJs=
X-Sasl-enc: 77SY8UUTR9ErLGYyxCfz+IUEoy1QMEDL/CCPZLzNtA1K 1298884109
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3BCBB406696;
	Mon, 28 Feb 2011 04:08:29 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <buohbbo35g8.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168080>

Miles Bader venit, vidit, dixit 28.02.2011 09:53:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> And would you please try and follow our netiquete here? I had promised
>> myself not to respond any more, but see how I'm still forgiving. Try and
>> deserve it :)
> 
> I'm confused; how am I "not following netiquete"?  It was an honest
> question...

Well, we're trying to cut as little as possible here. In particular,
don't just include one single line, taking it completely out of context.
Even more particularly, don't cut away the paragraph leading to a
conclusion when you're responding that conclusion - in this case that
paragraph would have ansered your question already. (And I don't think
I'm saying this the first time, but I'm used to it - I have little kids...).

We do cut patches when we respond to a commit message only (and the
response is not about the implementation), or hunks of a patch when
they're not related to the response.

As a general guideline, a reader should be able to understand the
response without looking up the post you are responding to (but may have
to read up on a longer thread). When in doubt, err on the lenient side
(less cutting), and make your MUA display quotes nicely (conversation
view, quotecollapse, ...).

And don't cull cc, don't break the thread. (You haven don't that here, I
do appreciate that, thanks!).

Cheers,
Michael
