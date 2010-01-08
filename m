From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Document git-blame triple -C option
Date: Fri, 08 Jan 2010 16:36:46 +0100
Message-ID: <4B47510E.7040802@drmicha.warpmail.net>
References: <f3271551001080610p62ef6abfge1c96648d1ea948f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 16:38:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTGv3-0004Je-IZ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 16:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab0AHPi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 10:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315Ab0AHPi2
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 10:38:28 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:52278 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752091Ab0AHPi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 10:38:28 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F039CC957A;
	Fri,  8 Jan 2010 10:38:26 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 08 Jan 2010 10:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+i52psgTPg3Sfm5/iibZveeFX64=; b=BuUqTZ6Q4npZXSUBWdkUF0q60t7WvnCdhsLGvJY7gEeDC4Yh/ai+9/VPnTSaKhlKHVP0J8wuVmfAUdPf+YgQlmFDDL1hDZkZX+LJZsqmWGaYSuxMPQLjTpfRAIX/I0Ecoszll8KSXrxyCzTnrW/ILV9RULIxaSWWkcgvE24DAqA=
X-Sasl-enc: rqbeqA0ShnlVHC9n8Gi5UfvG3Syi/pVwgu9AoKyB8qfY 1262965106
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6C55020306;
	Fri,  8 Jan 2010 10:38:26 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <f3271551001080610p62ef6abfge1c96648d1ea948f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136444>

Ramkumar Ramachandra venit, vidit, dixit 08.01.2010 15:10:
> The git-blame -CCC option is undocumented. This patch fixes that.

Above you see why it is difficult to comment on attached patches.
They're not included!

You re-wrapped the existing documentation. Please don't do that, because
it makes it difficult to spot what you really changed.

It seems you added one sentence. Please don't use "thrice" for "three
times", that is very old English and sounds funny.

Michael
