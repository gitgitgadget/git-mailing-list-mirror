From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 08:53:04 -0700
Message-ID: <9af502e50806280853i4c8564daxde2041aedc7fcb8d@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <alpine.DEB.1.00.0806271408290.9925@racer>
	 <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
	 <20080628021444.GI5737@dpotapov.dyndns.org>
	 <9af502e50806271957o2df9e0abt9dadcb0514dd4173@mail.gmail.com>
	 <20080628040344.GK5737@dpotapov.dyndns.org>
	 <9af502e50806272320p23f01e8eo4a67c5f6f4476098@mail.gmail.com>
	 <20080628123522.GL5737@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 28 17:55:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCcld-0004sD-CC
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 17:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbYF1Pxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 11:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbYF1Pxt
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 11:53:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:39398 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbYF1PxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 11:53:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so457289fgg.17
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aIkTTawF+pqgDXE4OhC/BYdm8f0ayd5dQwK/kUqn0/c=;
        b=Qa1pPLduBP6CD7iajL4J01aylom/34VaawqAUJYIst9ZN709ERiBSA5KRG8ZjNJkMH
         aQp3wNaBJVbXmI25j3lXDQTVaUM3Xv2XWhFQJf2FPrR+ZfEpCBm/QYEIP79IZiqARduo
         qkZA+j8Lx/kkLht5m1LaxXSpOL4zgsuMb/17Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=evEoR7uDkDem/NqDIhJAHwwyCW4yaEz5mnO+dSUWeekmN4WDPL041rZ6//RJG+5lGH
         OntPR2nOzlWLYcw6XP51iiBy7GapNavWKHTku1GGAT3UW5DUw1EKNXts75EJ197Zn1A3
         rkeyB2UmNLqm95Dp/hJdufnzFMk7rFp7/DWUY=
Received: by 10.86.73.7 with SMTP id v7mr3696318fga.37.1214668384370;
        Sat, 28 Jun 2008 08:53:04 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Sat, 28 Jun 2008 08:53:04 -0700 (PDT)
In-Reply-To: <20080628123522.GL5737@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86724>

On Sat, Jun 28, 2008 at 5:35 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
>> Fine, you like doing extra work for no benefit.  Enjoy yourself.
>
> I don't see where you find this extra work.

You aren't trying to.  You're knee-jerk defending the status quo, as
is the case of 95% of reply mail sent to any SCM mailing list.

I worked in this model for years.  It is inconvenient and creates
redundant work.  It is a PITA.

Thanks,
Bob
