From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: Development Environment Setup
Date: Mon, 17 May 2010 01:23:24 -0400
Message-ID: <4BF0D2CC.8090605@gmail.com>
References: <00b801caf560$6d07be50$47173af0$@burgmann.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Albert Krawczyk <albert@burgmann.anu.edu.au>
X-From: git-owner@vger.kernel.org Mon May 17 07:25:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODspx-0004cK-Vq
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 07:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab0EQFX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 01:23:28 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:64792 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab0EQFX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 01:23:27 -0400
Received: by qyk1 with SMTP id 1so6507878qyk.5
        for <git@vger.kernel.org>; Sun, 16 May 2010 22:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Vjd7m6REs51aSJA3LVPAii3iNBgy5WCLgbdAMZ7Sb+Q=;
        b=jsuAVfhQ2umCDM0EDRvAV2tG13mHYWIBJmU6js4r9Hd42NvGP5XzOHRw4N/1HXrKTV
         4rWzBYuOlXL6Dd5w1AmjBB3yptsgJSQvM+dsezh7V/mFwYkCFs/AucET+jNn1O30ULJ8
         f8yLhjsZwYLVTDfsrU6eUIH6H+1d52c4EI048=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Z31cFmfDzX7cMEXckNn06Qy5SYNI1MxgyNAEGb1R3R7A741rAwnjvk7xRA+w2PVEX+
         or6s4LzG7Q1m5gExdNWcTKxKOuwR/+aplzdAemnAEtotlbCOObRXHiA4hTK1UyyZGSEY
         q4yz6zUsCeyk0oE5Q1WidMjf+MC7L0e5VTrh8=
Received: by 10.224.87.83 with SMTP id v19mr2479401qal.392.1274073806956;
        Sun, 16 May 2010 22:23:26 -0700 (PDT)
Received: from [192.168.2.205] (dsl-154-109.aei.ca [66.36.154.109])
        by mx.google.com with ESMTPS id 22sm3098074qyk.2.2010.05.16.22.23.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 22:23:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <00b801caf560$6d07be50$47173af0$@burgmann.anu.edu.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147207>

On 2010-05-16 21:29, Albert Krawczyk wrote:
> Hi,
> 
> I'm curious, what is the recommended / typical setup for Git development?
> 
> Do people use IDEs? If they do what are they? 
> 
> I'm looking to do dev on Ubuntu. 
> 

Git has a couple of solution up its sleeves. Depending on which kind of
IDE you're typically using, you can use the right plugin or interface
for your needs.

If you like Eclipse as an IDE, EGit will be for you.

have a look at this list:

https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Editors_and_IDE_integration

And, higher up on the page, you can find descriptions for graphical
interfaces for git.

-- 
Gabriel Filion
