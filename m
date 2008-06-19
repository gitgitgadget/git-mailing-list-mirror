From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is there a repository for git-cvsserver?
Date: Thu, 19 Jun 2008 10:11:13 -0700 (PDT)
Message-ID: <m3prqdmjuq.fsf@localhost.localdomain>
References: <485A891E.5080605@distributel.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Le" <le_wen@distributel.ca>
X-From: git-owner@vger.kernel.org Thu Jun 19 19:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Ngd-000896-0e
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 19:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757862AbYFSRLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 13:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbYFSRLT
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 13:11:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:49930 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757862AbYFSRLT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 13:11:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so437385fgg.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=meCiSxLengy4ftZEBv9gVC8Ji9rwKDzmH+h7ilkzvF8=;
        b=qDTNIvRBPTvjGI1pYg1dcPISv5uABdtMYu9mh6Bcb8uN4G8pHj511HCBqnb0JpgcE8
         Ghd5KuHG62xHRjgNxXTIEwsyXYGckaVG518McdOwF0Aefd/kAV9eg3dw9ZVrBFvi2k7W
         pl9TUC2tN4gSaPCCVPh+MAgMd/buVEHbEBqMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=aqY1gw8EzLKBlgUZvTZjjpjW2yuXDqZwBhXNPaXIMcZnPPHw8NikOZ0kFlSniDwcqF
         VvJnOXUZgM2sp4kXvtydkTzkeu++QXRTtyYF3cxOB0OypB7P4ymCnzSTH0yc5vBh/JFn
         Hg3zZcy49EL4unbUomciK1ktOy2y6onH26s54=
Received: by 10.210.90.10 with SMTP id n10mr2064578ebb.179.1213895474569;
        Thu, 19 Jun 2008 10:11:14 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.242.161])
        by mx.google.com with ESMTPS id c25sm1288118ika.11.2008.06.19.10.11.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 10:11:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5JHAfeq032746;
	Thu, 19 Jun 2008 19:10:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5JHAM5G032737;
	Thu, 19 Jun 2008 19:10:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <485A891E.5080605@distributel.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85494>

"Le" <le_wen@distributel.ca> writes:

> I've tried to find it but in vain. What I got is only git itself.
> 
> If anyone knows, please let me know. Thank you!

No, git-cvsserver is part of git.  You probably have it in separate
package named git-cvs (or perhaps even git-cvsserver).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
