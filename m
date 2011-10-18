From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Compiling on Windows
Date: Tue, 18 Oct 2011 07:41:24 +0200
Message-ID: <op.v3i8rauz0aolir@keputer.lokaal>
References: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Andrew Ardill" <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 07:41:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG2Qj-0006XA-SQ
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 07:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267Ab1JRFl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 01:41:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37214 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217Ab1JRFl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 01:41:27 -0400
Received: by eye27 with SMTP id 27so189870eye.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 22:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=5YSPxnI2qOPPuX6CdPzaNt+DpDwykRHMzi8UHmnouso=;
        b=bVZR2yuH+4Ucx7iwGbaWzH/Bj+to8TV2aOKukX98rZKcHxdSP7aV2j3s4m4Siz/5Fc
         55P154BUQxKi0lR5xdVTre92BjEFkEtm6Js/WRxW8kVkpxa+n7dsJ8uMcYpG0/DN5ExB
         5FUDIScCAxUNv0hhQBTGhxa2jbOiPaz1Mg26Y=
Received: by 10.14.0.193 with SMTP id 41mr70488eeb.45.1318916486016;
        Mon, 17 Oct 2011 22:41:26 -0700 (PDT)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id t14sm2246387eeh.7.2011.10.17.22.41.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 22:41:25 -0700 (PDT)
In-Reply-To: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183859>

On Tue, 18 Oct 2011 06:08:16 +0200, Andrew Ardill  
<andrew.ardill@gmail.com> wrote:

> Hi list, I have been searching for details on what is required to
> compile on Windows, but haven't found anything conclusive. Perhaps
> there is something on the wiki, but unfortunately it is down at the
> moment.

There's this project called msysgit[0]. The website depends on the wiki  
for explanation though.

Cheers,
Frans

[0]http://code.google.com/p/msysgit/
