From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Better advice on using topic branches for kernel
 development
Date: Thu, 21 Oct 2010 11:32:08 -0500
Message-ID: <20101021163208.GC3732@burratino>
References: <4cc06a8128436b591e@agluck-desktop.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Luck, Tony" <tony.luck@intel.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 18:36:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8y7U-00073K-Q1
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 18:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab0JUQfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 12:35:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38694 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab0JUQfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 12:35:54 -0400
Received: by ewy7 with SMTP id 7so328759ewy.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2ReSCpwWmbgOpnx+6vKRaaGBz3uujTwF4Hnmy+E1z+A=;
        b=LtD2QA/Gxa//iob5gWkwo9+9ByYyxJ5D14xy9A3weme16meAHhSRPC5MrzeK35KBpp
         IyIwqXdNeyrGdnHCo1HXSNNdPi7PfGLP9nLnKkT3A0ArPrLhZjDAUiBdOX7/jTKZyLO1
         9Sb3mLcw/1txfMCKJvSFqrXkKMii11YOkXcPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dBT4tNvQ99YTi+DxIy+2Q/L+UEpOtpEZb4qLwxz5yAoFZNf8HG6T2bx4ePV0CeFDYN
         zSUi/VbasYLkfQhIQ0hD6C8yL0H9XXIV/GCmMDt6QLExf+MatzXqnKBz7tCaRoTnjHqH
         Mi8em0IhpOlpnfCwywFDp8/wWDZJBcEbd4fwE=
Received: by 10.213.12.202 with SMTP id y10mr8148550eby.78.1287678953123;
        Thu, 21 Oct 2010 09:35:53 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a25sm904462fab.13.2010.10.21.09.35.50
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 09:35:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4cc06a8128436b591e@agluck-desktop.sc.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159522>

Hi Tony,

Luck, Tony wrote:

> Maybe they do this because they read it in the Git user-manual.
> 
> Fix the manual to give them better guidance.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
[...]
> Originally posted on October 1st ... no comments received.

No comments received, but applied to "maint".  Sorry for the
confusion.

Occasionally there has been discussion of automating notification
that a patch was applied.  Maybe someone on the git@ list might
consider it worth trying (or maybe not).

Thanks.
