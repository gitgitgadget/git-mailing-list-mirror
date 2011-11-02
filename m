From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 02 Nov 2011 22:05:29 +0100
Message-ID: <4EB1B099.5030701@drmicha.warpmail.net>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike> <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com> <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com> <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com> <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <4EB12122.7010803@drmicha.warpmail.net> <7v1utqjqre.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 22:05:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLi0B-0001f4-Jr
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 22:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab1KBVFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 17:05:37 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:44410 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751079Ab1KBVFe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 17:05:34 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4247D20E42;
	Wed,  2 Nov 2011 17:05:33 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 02 Nov 2011 17:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=KH+MEN04zxEZRBNzNi2Y/r
	eLNI4=; b=MoDZDUgojWVUak2Jm7fb6uBP4FkqIiaX3f32K+PQXkVx9qnQFBBtfW
	CDSuUHaw1cjnkCSbZJ86zsougNPzaZDqYwVBYdm2Q6OU9xCDK/4O9d7PXlQSRqB6
	9fnF86TeclcWFvbF0Z0xh6jJEnySClkAl2Lxm9bgJnrOikLSYDt8Q=
X-Sasl-enc: Wf/nvYwNfRCqWgdKGwxTw94ntljN1FhoNnhninJ9Lp2K 1320267932
Received: from localhost.localdomain (p4FC752B6.dip0.t-ipconnect.de [79.199.82.182])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 74AA5483403;
	Wed,  2 Nov 2011 17:05:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7v1utqjqre.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184669>

Junio C Hamano venit, vidit, dixit 02.11.2011 19:58:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> The advantage of tags is that they can be added without rewriting the
>> commit, of course.
> 
> And you did neither think about the downsides of tags, nor read what
> others already explained for you?

We're just weighing things differently here, and no accusations of
"misinformation" or "not thinking" will change this.
