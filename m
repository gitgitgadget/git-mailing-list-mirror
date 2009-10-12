From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] user-manual: use 'fast-forward'
Date: Mon, 12 Oct 2009 14:50:07 +0200
Message-ID: <4AD325FF.6070105@drmicha.warpmail.net>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>	 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>	 <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>	 <1255293973-17444-4-git-send-email-felipe.contreras@gmail.com>	 <7veip9jj6z.fsf@alter.siamese.dyndns.org> <94a0d4530910120305o49ed7c74sf6a03097b1098a5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 14:57:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxKTI-0004bx-Ak
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 14:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbZJLMvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 08:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754894AbZJLMvQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 08:51:16 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53064 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754647AbZJLMvQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 08:51:16 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BE688A38C4;
	Mon, 12 Oct 2009 08:50:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 12 Oct 2009 08:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LoihWnmRHkpjvtPbcRhkOs6yP2o=; b=KwifA1nsKMr0TwF30h8Dq0EaMD9QeZi6oZp7kXazO1euxHWrqQTcPEwpIq8bzUDEyQQ+n8n3yjtZ+sqYHt1vDg7gKU2PyuH/9wxzDNBQ2qNU3d2eMD3tsLzncdUxNFKeDS0chrGv73AX3av1iYUXYvoRo8CkeM3hKKQGBoLiPAQ=
X-Sasl-enc: scq1zQWfGyyqmb8OaYjpPVIl57R0oa5QCyvCvvrSqC+L 1255351814
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1B9DB21779;
	Mon, 12 Oct 2009 08:50:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091012 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <94a0d4530910120305o49ed7c74sf6a03097b1098a5f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130010>

Felipe Contreras venit, vidit, dixit 12.10.2009 12:05:
> On Mon, Oct 12, 2009 at 8:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> It's a compound word.
>>
>> Thanks.
>>
>> This removes 7 out of 37 "fast forward" in Documentation/ directory.  Are
>> we going to convert the remaining ones, too?
> 
> Sure. Once I finish pushing the patches I have for user-manual, which
> is the one I'm interested right now.
> 

And how about the other 40 or so in the remaining code?

In fact, hyphenated and separated forms of this compound noun are almost
evenly split, which reflects well upon the fact that there is no
clear-cut rule in US English (and neither in BE).

So, if you are suggesting a style we should define it and follow it
consistently. Our main source of definitions is the glossary. Now, that
has a truly salomonic solution:

fast forward
	A fast-forward is a special type...

I suggest that this is the first place which needs attention, after
fixating the definition, maybe not just among the three of us, all
non-native speakers.

Michael
