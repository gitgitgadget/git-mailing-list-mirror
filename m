From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 21:13:16 +0200
Message-ID: <m2xfabb9a1e1004141213t7d4f084bk72a3b72544e11542@mail.gmail.com>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> 
	<l2jfabb9a1e1004111635v16e4dc86g405883ca12d316b9@mail.gmail.com> 
	<201004142110.36453.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 21:18:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O286t-0000U8-6l
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 21:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab0DNTSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 15:18:46 -0400
Received: from mail-qy0-f189.google.com ([209.85.221.189]:35491 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab0DNTSp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 15:18:45 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2010 15:18:45 EDT
Received: by qyk27 with SMTP id 27so625646qyk.23
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 12:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=VOUq0R21OkqKWDJmT8TF+NZwls5ePMqIGwNvpgHpbyg=;
        b=ak+qDNpxxXTqRWvGPnkKTkflMpfoEoWQK1HZNabl7A7+RcjhcnCcXsc4FOOzxJnBGW
         y4cFmboJ4KMrHlIT1YC8tyBGJo/HwwWUIqziC1qVy6gFXbgk6TKJ+1gXPzXY4laOEiiC
         9hK+tHhF/DiOuchvWdh4/EO8mNzQcFJ0tF7Ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Dh0upNGsB16YKFyZxQqh8gDt1JTXBZkpHJHgYn0feIXQ4i3IpE75y4HrufimVJJUaT
         fTz6U2D5YFSEReRaDg/OU/VM3ZqUq0bxQAi5Xo4nKvMAtrJCyb7Ic46YoDcB3lDdI5RN
         Mf43Q3aILTEMQkMdE7dM5pHME2st84/Yq/+DE=
Received: by 10.224.74.3 with HTTP; Wed, 14 Apr 2010 12:13:16 -0700 (PDT)
In-Reply-To: <201004142110.36453.jnareb@gmail.com>
Received: by 10.224.72.15 with SMTP id k15mr2773728qaj.356.1271272416135; Wed, 
	14 Apr 2010 12:13:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144894>

Heya,

On Wed, Apr 14, 2010 at 21:10, Jakub Narebski <jnareb@gmail.com> wrote:
> I don't think it is needed for either command.

Those were just the first two plumbing commands that came to mind that
I use myself, do you have any suggestions for others that would be
more appropriate?

-- 
Cheers,

Sverre Rabbelier
