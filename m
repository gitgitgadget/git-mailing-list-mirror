From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Sat, 23 Aug 2008 21:34:06 +0030
Message-ID: <4d8e3fd30808231404y7293eb56g4fbed5565ab2aa9a@mail.gmail.com>
References: <20080822174655.GP23334@one.firstfloor.org>
	 <m37ia8sv49.fsf@localhost.localdomain>
	 <20080823071552.GU23334@one.firstfloor.org>
	 <200808231121.41694.jnareb@gmail.com>
	 <20080823165350.GY23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>, git@vger.kernel.org
To: "Andi Kleen" <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 23:06:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX0Iv-0004WX-0b
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 23:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbYHWVEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 17:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbYHWVEK
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 17:04:10 -0400
Received: from qb-out-0506.google.com ([72.14.204.230]:61617 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbYHWVEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 17:04:09 -0400
Received: by qb-out-0506.google.com with SMTP id a16so1417897qbd.17
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=a7MY4GCuhHY43nSWoUibatfJNlqxVnvJGAIP8IUg+ao=;
        b=SgmlVfDVZRzw0cc4OwjFJLvOnkYZARnftzi9ZqYsYnASdHDJ6fnoxhGmFNtwTvi6hg
         gPA/Y2n2k8y6KSmiT/vzBLR2/lD+Bs6mutWpjYkqX/QIV0pXUuGwXSlDsS+h4+5u8b3l
         xknX9mLD5UaS2lIdHsH64Bw5Gc9zuC94yynow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZplmE2F3Vjk1EVtLcmC6T7aKs5v1D2hcngidemJG+WsQ0dU2QwDqG7HVWF5NDtW9Tj
         4kDrIk7U1nWv9d3OiZmCmh8IwEcv17C0qUUIzFGuOoCsEVoBZ+HKyU3jGUzcbkAbi2xA
         cpZcY4YqdaAEPaaZQuaJZs73sYpVfs26SW8rU=
Received: by 10.142.47.13 with SMTP id u13mr951275wfu.38.1219525446242;
        Sat, 23 Aug 2008 14:04:06 -0700 (PDT)
Received: by 10.142.194.8 with HTTP; Sat, 23 Aug 2008 14:04:06 -0700 (PDT)
In-Reply-To: <20080823165350.GY23334@one.firstfloor.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93490>

On 8/23/08, Andi Kleen <andi@firstfloor.org> wrote:
[...]
> Not more not less. Right now that's not there as I know
> from my own experience.
>
> Maybe for you people who spend days thinking about git and
> hacking it these ways are all obvious, but for someone like
> me who just wants to use the tool it's definitely not easy
> to do currently.
>
> Anyways I'll shut up on this now because it sounds like
> you people are not interested in improving the tool for
> non power users.


that's unfair Andi.
you got nice and detailed answers,  for example you can track a
rebased tree in your working directory using git pull --rebase.
What's wrong with that?

ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
