From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: Cover letter
Date: Tue, 08 Jan 2008 14:09:15 +0100
Message-ID: <478375FB.405@isy.liu.se>
References: <4d8e3fd30801080452g71c3d3dx39f2ec805239ef01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 14:10:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCEDO-0004rF-Sh
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 14:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbYAHNJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 08:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbYAHNJT
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 08:09:19 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:41962 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYAHNJS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 08:09:18 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id E06C925A9B;
	Tue,  8 Jan 2008 14:09:16 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 15479-04; Thu,  3 Jan 2008 00:53:57 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 647D925A92;
	Tue,  8 Jan 2008 14:09:16 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <4d8e3fd30801080452g71c3d3dx39f2ec805239ef01@mail.gmail.com>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69875>

> This is working fine but since I'm going to push out a queue of patches
> it would be nicer to script everything with git-send-email.
> 
> I know I have to configure git in order to use the gmail's smtp server,
> I know how to tell git-send-email where to pick up the patches but I fail
> to understand how I can write a cover letter and let it be part of the patch
> queue.

Use the switch --compose to git send-email, that should open up an 
editor and let you write a cover letter to go with the patches.

/Gustaf
