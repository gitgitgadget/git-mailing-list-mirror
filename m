From: Alexey Shumkin <Alex.Crezoff@gmail.com>
Subject: Re: Compiling on Windows
Date: Tue, 18 Oct 2011 10:39:55 +0400
Message-ID: <20111018103955.1db40b5e@ashu.dyn.rarus.ru>
References: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 08:40:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG3LL-0007RB-Hv
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 08:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab1JRGkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 02:40:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43266 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab1JRGkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 02:40:00 -0400
Received: by wyg36 with SMTP id 36so227899wyg.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rarus.ru; s=google;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=cysK7OsLWLYf1spDQTzdCelf0hboK5F7Y41u/0xxkfo=;
        b=evFwQkOzffv6Z7LNuLGN2jjx39W8iBJDdlGbU4qViZe4BKhsUJSoQR+Ejl+YtLjspi
         y7sq797ee8yApvsXRdV+J5axUPD4SirES9ePXkoRFu3X73StA7pBeCLMS3GVhpGlndCp
         SMv8TnW732xzSXIVCxF1u6E7MW7mWw2jIsjbQ=
Received: by 10.227.55.65 with SMTP id t1mr351326wbg.90.1318919998809;
        Mon, 17 Oct 2011 23:39:58 -0700 (PDT)
Received: from ashu.dyn.rarus.ru (mail.rarus.ru. [213.247.194.83])
        by mx.google.com with ESMTPS id b5sm1617137wbh.4.2011.10.17.23.39.57
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 23:39:57 -0700 (PDT)
In-Reply-To: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183865>

Take a look at Cygwin.
On Windows I use Git under Cygwin.
And, of course, Git can be compiled there (with dependencies installed 
like openssl-dev, curl-dev, etc)

> Hi list, I have been searching for details on what is required to
> compile on Windows, but haven't found anything conclusive. Perhaps
> there is something on the wiki, but unfortunately it is down at the
> moment.
> 
> Can anyone point me in the right direction? I would like to be able to
> compile and test topic branches, and perhaps even do some dev work on
> my windows machine.
> 
> Regards,
> 
> Andrew Ardill
