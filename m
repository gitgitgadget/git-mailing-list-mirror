From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: My git-gui difftool script
Date: Thu, 17 Feb 2011 17:28:16 +0100
Message-ID: <4D5D4CA0.8040301@fastmail.fm>
References: <loom.20110217T141642-685@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 17:31:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq6lR-00076Y-9J
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 17:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab1BQQb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 11:31:27 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34304 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755373Ab1BQQb0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 11:31:26 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 008152013F;
	Thu, 17 Feb 2011 11:31:25 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 17 Feb 2011 11:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=cqgp7m7LaZM5vn7jDF2TQpQi3GE=; b=DgZIAacQ7ZQfr8Cdngayxv+8hl7a84iDZtoIlmBn6MtqD5PApOl5JnR/eaX6WewnBeSFvb1RxtENKuSMxyJLY+m++93rIQUbSOf/H7S8rADobWzntlENR8EsF2gXqcC6+BS//mZdCTVmAa8HqoeBO+4sLG/VWaPetuxqYKQz2hc=
X-Sasl-enc: Wl2CLfoHvy4XKjDkIPzRPx71gDptUd9jLCkQgqP1MKSH 1297960285
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 79F27440186;
	Thu, 17 Feb 2011 11:31:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <loom.20110217T141642-685@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167092>

Chunlin Zhang venit, vidit, dixit 17.02.2011 14:22:
> My git-gui difftool scipt can use now.Can use with meld/beyond compare and so on
> visual diff tool.
> Upload to https://github.com/zhangchunlin/gitguidifftool ,and the usage is in
> README.
> 

I don't want to spoil the party, but how is this different from using
"git difftool -y $FILENAME" for the command?

Michael
