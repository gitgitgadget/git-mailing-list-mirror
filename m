From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Google Summer of Code 2007
Date: Wed, 28 Feb 2007 10:03:31 +0100
Message-ID: <vpq4pp6r6vw.fsf@olympe.imag.fr>
References: <20070225075917.GC1676@spearce.org>
	<200702280842.08279.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 10:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMKj9-0002Xa-9n
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 10:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbXB1JD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 04:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXB1JD4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 04:03:56 -0500
Received: from imag.imag.fr ([129.88.30.1]:34747 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbXB1JDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 04:03:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l1S93VK6029636
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 10:03:31 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HMKih-0000WT-8U
	for git@vger.kernel.org; Wed, 28 Feb 2007 10:03:31 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HMKih-0006UU-69
	for git@vger.kernel.org; Wed, 28 Feb 2007 10:03:31 +0100
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <200702280842.08279.andyparkins@gmail.com> (Andy Parkins's message of "Wed\, 28 Feb 2007 08\:42\:07 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 28 Feb 2007 10:03:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40909>

Andy Parkins <andyparkins@gmail.com> writes:

> What about the oft-asked for windows port?  From what I've seen, none of the 
> Unix types have any incentive to do this, so a financial incentive might be 
> just the thing.

+ 1. It seems the windows port somewhat has the status "we want it but
I'm not going to do it" for most git contributors.

I'm personnally using unix 99% of the time, but I also have a piece of
windows installed on my laptop. For example, I'm working on a small
project using windows-only software, and being able to use git
comfortably from this setup would be cool.

Also, I'm relucant to migrate to git completely even for unix-only
projects, since I know that a hypothetical future windows-port will be
made hard by the non-availability of the windows port.

> Given that the best thing for git in the long term is more users, 

That's what I feel. The problem with distributed SCMs at the moment is
that there are too many of them, not sharing enough users. For
example, I had to choose a replacement for CVS with some colleagues
recently. I argued about using a distributed one, but the argument
against, and the decision was "SVN is what they're more likely to use
later, let's go for SVN no matter how bad it is".

> and that no windows support is the commonly given reason why other
> SCMs are chosen instead, this would be a good use of the resources.

Sure. One of the best examples being Mozilla. I hardly see them using
a piece of software that's not working properly on windows, since the
majority of users (and probably of the developers, I don't know) are
running windows.

-- 
Matthieu
