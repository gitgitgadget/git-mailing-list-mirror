From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 16:55:05 +0100
Message-ID: <509149D9.3070606@drmicha.warpmail.net>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com> <20121029085045.GA5023@sigill.intra.peff.net> <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com> <20121029212643.GA20513@sigill.intra.peff.net> <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com> <20121029215631.GF20513@sigill.intra.peff.net> <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info> <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com> <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info> <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com> <5090EFCA.7070606@drmicha.warpmail.net> <CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:55:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTadW-0007OX-Ru
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 16:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934575Ab2JaPzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 11:55:10 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58370 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757974Ab2JaPzI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2012 11:55:08 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 51EB320AE8;
	Wed, 31 Oct 2012 11:55:07 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 31 Oct 2012 11:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=/1soSTq39ogHgxpLor1fh+
	2mZuE=; b=GlZfoxDDoCrlCj6O0Xpd96faU58PVNJMp4M8Ceslux5zCDR/Pkc8WL
	z7XPgax21TP2s90OeXYqOUNj0o94CRISkTzIS3ejYE7CpWiq4ThNi2Dy3cVi+eQx
	CZKo64U/ZDosm5YyIO2bF4WnVfxzd8pKd6eokPFXr0hvcLu9BOnpM=
X-Sasl-enc: xOdHJD8RBQZpHVa+25eLmfxPufmYz0qKzwDMBHXorRY5 1351698907
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 42E278E0496;
	Wed, 31 Oct 2012 11:55:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208835>

Felipe Contreras venit, vidit, dixit 31.10.2012 16:39:

> This is precisely ad hominem; you are ignoring the code, not because
> of the code, because of the person. This is as ad hominem as it gets.

I am not rejecting your code (I reviewed an early series) but reject the
communication style and manners displayed in this thread.

> As for how "professional or helpful" that is, it's debatable. The
> Linux kernel mailing list is known for being harsh, and yet, they
> manage to get more things done than any other. They truly look at the
> code, just the code, they don't consider criticism to the code
> personally (nobody should), nor linger on any personal beefs that only
> distract from the end goal.

There are people who choose not to be on that list because of its style.
For this list, I think we should follow this list's style, not that one.

> But enough about Johannes, if I go on to Max's branch and give a try
> to the code, make a list of issues, run my extensive tests and so on,
> and make a report of the status, and a comparison with my code. Would
> that make it more likely for you to stop being a by-stander?

Sure, that's what I and others have asked for.

> Didn't think so. The truth of the matter is that it doesn't matter
> what I do code-wise.

Just try, seriously.

>> Orthogonal to this, it seems that all hg-git interfaces could take
>> advantage of a "git heads" feature if we resurrect the old ideas (can't
>> find the thread right now).
> 
> Never heard of that.
> 
> You accused me of ad hominem, now I ask you; can you ignore any
> personal biases and look at the code, and only at the code?

My efforts here prove that I either have no biases or ignore them. I'm
not going to ignore the style of communication, though. As a patch
submitter, you ("generic you") want the attention of others as
reviewers. It's in your own (again "generic you") interest not to put
them off, in the same way as it's up to the submitter to argue why a
patch is desirable and correct.

Michael
