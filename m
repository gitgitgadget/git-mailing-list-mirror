From: Adam Mercer <ramercer@gmail.com>
Subject: Re: error in rewriting author history with filter-branch --env-filter
Date: Sun, 5 Apr 2009 10:52:02 -0500
Message-ID: <799406d60904050852pf9ffffep84b5d24cb1c5f84a@mail.gmail.com>
References: <799406d60904042121o27b4ac39m633354dcf0bcc84d@mail.gmail.com> 
	<20090405072158.GA3881@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 17:55:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqUhC-00057r-Op
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 17:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbZDEPwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 11:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbZDEPwV
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 11:52:21 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:57002 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbZDEPwU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 11:52:20 -0400
Received: by gxk4 with SMTP id 4so3926531gxk.13
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NuAMmUFOBhFVpkw3KcqI7+kBX+GU8XDgn5ESTlnB47k=;
        b=l+SYxuVSe0XCVfKuUJ1s96psUFAhb0ST1yN+mCRhKplIh4wTN2zr19jqCCHInm4Top
         6StHrsdzv6Fep0CmIDOcfyjnl7fBI9nOqXCPHUn/3Nfm+xl4pfuEWeMAHFlsclm3xKVX
         dQQkFTWj1AWVaeOCOB5L+vADVthBoWHWk5n08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QBTci+ePYYC5M+rIIFXx1lNF9IAfJgUybOMJRjOpjB1WBe2nSQuBanfymCu6Y32K+x
         vdzeUSILrl87F2Z5DxwRmJSfE8dEEAnC8CQKgW7YclfQH9JR1C0N2XEQELdZrxJKXv6A
         LRUcdJq1ssW/0xLZpNj0CkmSKx5hmwj8inVGY=
In-Reply-To: <20090405072158.GA3881@glandium.org>
Received: by 10.90.33.15 with SMTP id g15mr2253171agg.55.1238946738466; Sun, 
	05 Apr 2009 08:52:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115672>

On Sun, Apr 5, 2009 at 02:21, Mike Hommey <mh@glandium.org> wrote:

> You need a white space between "ram" and ].

Thanks! I knew it would be something stupid!

Cheers

Adam
