From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 18:41:48 -0400
Message-ID: <6dbd4d000806101541g32d57f18r2372a360f6c3ba2f@mail.gmail.com>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
	 <200806102159.02875.jnareb@gmail.com>
	 <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
	 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>
	 <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
	 <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
	 <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
	 <alpine.LFD.1.10.0806101431410.3101@woody.linux-foundation.org>
	 <6dbd4d000806101509l516cf467me06fadee6ead0964@mail.gmail.com>
	 <905315640806101525n26a0a4eic7943613ab9e1a8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:43:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6CYQ-0005Hm-5I
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 00:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbYFJWlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 18:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbYFJWlv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 18:41:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:43976 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbYFJWlu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 18:41:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1937719fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5boHlNgHRqSJ3Y38mMjIAfouMHcY55Kz6l/wRZqnRkE=;
        b=v/mM0JmWGJ5Kb8TN2UdpsZjYUi/sAd+Q6cBqcv74q1PP1HZ4i8T1nqOU5J3T0DbUeF
         4YbF1OeWUNhBmZTu5t9W84+Odxl7T8nl5vDPxO+ID34IsLauhDc8QZRDf3l2O8PMoxIU
         AiGcdPOqxPJfIVb4zEk/vlw9/iHlkzCI65coQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IMyeG/UTKg3sxkuvXzcEXMk8nIeDOzl5OhJEmLs5ub+F4joyBy9GmZ3UwPtS1W14PA
         T4sUsyr9q26nCt8Rs7RUARYXNKuJEz42dx7ep585Mc6HWgLml1WoU7/YyqzsTvxy7kLi
         TrMwItQHneu6OiWLcokvzZ05P8iYn58pgGyqA=
Received: by 10.86.92.7 with SMTP id p7mr6321316fgb.72.1213137708134;
        Tue, 10 Jun 2008 15:41:48 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Tue, 10 Jun 2008 15:41:48 -0700 (PDT)
In-Reply-To: <905315640806101525n26a0a4eic7943613ab9e1a8c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84556>

On Tue, Jun 10, 2008 at 18:25, Tarmigan <tarmigan+git@gmail.com> wrote:
> Do you have fink installed?  Do you have the openssl fink package
> installed?  Vger seems to have swallowed my original reply, but see
> this thread:
> http://marc.info/?l=git&m=120787191106549&w=2
> If so, try removing the fink openssl packages and reinstalling git.

I use macports.

> Do you push from this machine often?  If you do, then this probably is
> not your problem as you would have seen it earlier.

Yes, almost exclusively.  ... That is an odd problem.  Thanks for the
suggestion.

-- 
 Denis
