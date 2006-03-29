From: "David Ho" <davidkwho@gmail.com>
Subject: sending git-format-patch files with mailx.
Date: Wed, 29 Mar 2006 15:36:17 -0500
Message-ID: <4dd15d180603291236j4ca4654fvbe5b6375e8623081@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Mar 29 22:36:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOhOy-0003Hc-5F
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 22:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWC2UgT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 15:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWC2UgT
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 15:36:19 -0500
Received: from wproxy.gmail.com ([64.233.184.225]:38288 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750839AbWC2UgS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 15:36:18 -0500
Received: by wproxy.gmail.com with SMTP id 57so267531wri
        for <git@vger.kernel.org>; Wed, 29 Mar 2006 12:36:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TmyllPWsW7mRR/ReWXUQbMboYKQsFPEsHeVVw8MIWlK5B3jtuxFd+7FIJt6nSQbUrAJ2gZGot/RdGK/ueXp0PguFHQdhC4+ghcVtsZfgMjqyZMDGFyYVj4m3+xdBeXbzrnbIFjOzAS/gcGzyHGlJqXXXA6pPyo0CU4SXLlxzd9w=
Received: by 10.64.181.15 with SMTP id d15mr20957qbf;
        Wed, 29 Mar 2006 12:36:17 -0800 (PST)
Received: by 10.65.22.11 with HTTP; Wed, 29 Mar 2006 12:36:17 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18182>

Very stupid question.

I have patches created by git-format-patch.  However I suppose I can
send it off directly using mailx, but I have a hard time figuring how
this is done.

Someone here can probably answer this in a second.

Thanks in advance,
David
