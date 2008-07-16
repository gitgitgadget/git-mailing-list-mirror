From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: MSysGit Stability
Date: Wed, 16 Jul 2008 08:33:00 -0400
Message-ID: <eaa105840807160532t73e6b851h5b78c0d8ad4c1c1a@mail.gmail.com>
References: <73fd69b50807151458u22a383a3l343779e47f4161fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Joe Fiorini" <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 14:34:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ6Cw-00009K-9e
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 14:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbYGPMdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 08:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753542AbYGPMdK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 08:33:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:18595 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbYGPMdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 08:33:09 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2715142ywe.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=2HFEHBEfN8ps09XU7ZfB7UA4Op0pMSlmot4FpKyILPw=;
        b=u7RRxdirObx2b1V/LefyFW4wPk6VwefJd5Yu+aotq8kxFafgYV30inTlgq3cO7qG+U
         xnvolNurkwK/0OVAhdvHCHihSZnqRHoimlQlT87XiuWUmGSTZH4Jus+VqyJTIopDlSNz
         Zc82PDCiy4ogB/TELJqfNub7WdBoWb3stFwEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ZQxvEEfMhuZkyQqwEeXZcvxe3XhR3GtgUEQKq+IEqW50Aoy9P9Q/KOVnB7sTK77XSu
         NPLkFIxuYbroWYxuzNfjctdupqEoe6I5P/YvzdHXcXyIUlO1w5UO5M0UshaQYjUNKwC7
         XXw21IpxZqBbR6x/X1INVnTNna1xlDSXq8KbQ=
Received: by 10.125.142.5 with SMTP id u5mr3615859mkn.126.1216211580012;
        Wed, 16 Jul 2008 05:33:00 -0700 (PDT)
Received: by 10.125.159.20 with HTTP; Wed, 16 Jul 2008 05:32:59 -0700 (PDT)
In-Reply-To: <73fd69b50807151458u22a383a3l343779e47f4161fa@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: ea68bfb5dc817d51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88674>

On Tue, Jul 15, 2008 at 5:58 PM, Joe Fiorini wrote:
>
>   Does anyone have experience running Git on Windows?

I use msysgit regularly. The core git is quite stable, although
occasionally peripherals have a bit of trouble. For example, git-svn
was broken recently.

Overall, I would recommend msysgit for anyone stuck on Windows.

Peter Harris
