From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Opera release Git-splitter, a sub-modularizing tool for Git
Date: Fri, 21 Dec 2012 13:23:46 +0100
Message-ID: <50D454D2.5030403@drmicha.warpmail.net>
References: <op.wpiovoj5qrq7tp@acorna.invalid.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yngve N. Pettersen (Developer Opera Software ASA)" <yngve@opera.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 13:24:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm1e8-0001wK-Tm
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 13:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab2LUMXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 07:23:50 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44004 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751234Ab2LUMXs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 07:23:48 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 02D0D2067F;
	Fri, 21 Dec 2012 07:23:48 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 21 Dec 2012 07:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=uNb2l1oeLeZP2RM82rZEtC
	qHjhw=; b=IPgWKfMKjvdE0lvCJo21f21Hj1tOvWYqrWQrnrME9+W2aaT52eUxv5
	jkQ6r7eWpUvtcVUT/zuhI0+rwKzRhVPJwUq3O3jT16gYhD/3pxdg1fC4sA7ZrusD
	UH9kKLaoCKUlmrd/M3HltUqEIq+WtHmF+t0X/tixpl0uTyHPuLnJI=
X-Sasl-enc: s9eINuTK9NSeTO52hvpLeoVtK/LAtImHOdXS4KcsPDA/ 1356092627
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7D8874825BB;
	Fri, 21 Dec 2012 07:23:47 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <op.wpiovoj5qrq7tp@acorna.invalid.invalid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211966>

Yngve N. Pettersen (Developer Opera Software ASA) venit, vidit, dixit
18.12.2012 15:51:
> Hello all,
> 
> Today Opera Software released the "Git-splitter", a small tool for  
> sub-modularizing code in a git repo, with complete commit history, under  
> the Apache 2.0 license.
> 
> It's functionality is similar to "git-subtree", but also include a command  
> for reversing the process.

Is there something keeping you technically from adding a join command to
git-subtree?

> The code is hosted on GitHub:  
> <https://github.com/operasoftware/git-splitter>
> 
> We have announced the release as part of another announcement of released  
> code at the Opera Security Group home page:  
> <http://my.opera.com/securitygroup/blog/2012/12/18/tls-prober-source-released-under-apache-2-0-license>
> 
