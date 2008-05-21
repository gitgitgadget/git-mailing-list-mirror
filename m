From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: looking for "market share" analysis of SCMs.
Date: Wed, 21 May 2008 17:10:09 +1200
Message-ID: <46a038f90805202210v5d0f75cekbad51da89c46f47@mail.gmail.com>
References: <48329282.1040407@tikalk.com>
	 <20080520093245.GA5037@mithlond.arda.local>
	 <bd6139dc0805200310j13a9b74dy9f28fe855c59e01b@mail.gmail.com>
	 <alpine.LNX.1.00.0805201748020.19665@iabervon.org>
	 <bd6139dc0805201525r22ba7398g6f341f89ae699b57@mail.gmail.com>
	 <alpine.LFD.1.10.0805202105430.3081@woody.linux-foundation.org>
	 <46a038f90805202126s80262d3i2f4f940a38d9ea06@mail.gmail.com>
	 <bd6139dc0805202144h2bb55fd1n9b26bc76c245f33b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Teemu Likonen" <tlikonen@iki.fi>,
	"Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Wed May 21 07:11:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JygbS-0002dY-E3
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 07:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbYEUFKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 01:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbYEUFKN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 01:10:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:53878 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbYEUFKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 01:10:11 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2401256rvb.1
        for <git@vger.kernel.org>; Tue, 20 May 2008 22:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=C8ahzi7dnewINh12Tmbp896zG0yhkvYhwQAHiEM7A3Q=;
        b=YKwss1F2KvUkO3NmHnW+OpQBR0ePfGWuX+h7InbMiIU+NDyuF3JRkYoPes+JdlJfiOk+0I2ogOZIP5TTKJL1t7GYzItdmIaDIeLzk+NqQ2929yakLbqaFZFdFECOMeOo+znIj6i2kXjUXJPKWYqDYklcsR8wmUMGfeAEfgHmCT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pYVmzVVdUPe4A40LSrd0a5mNzQL2C7SQXv6hCzsCdzX+gLah/IVL6f+Ct6lTpN5t1mloyqqSN0LjwcQFiDi6IzjO/F3tT0YrKi1oReD+4Jl9MJXjqRnNx5h+FUjXm+EsdcIGN+rUAXsHBH2VgdTKMvx7tf5i6bzXggqoQz/HT7A=
Received: by 10.142.52.18 with SMTP id z18mr3435851wfz.31.1211346609157;
        Tue, 20 May 2008 22:10:09 -0700 (PDT)
Received: by 10.142.128.16 with HTTP; Tue, 20 May 2008 22:10:09 -0700 (PDT)
In-Reply-To: <bd6139dc0805202144h2bb55fd1n9b26bc76c245f33b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82524>

On Wed, May 21, 2008 at 4:44 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
> Trimming it does make the graph a lot nicer although doing prevents
> you from comparing the grow curves (of CVS and SVN with those of git).
> http://tinyurl.com/6hj5ds

Actually, if we define the "market" to be DSCM, and the timeframe to
be existence of the git-core package, this graph of installs is quite
useful:
http://tinyurl.com/4uemg2

>> Do I confess I added tla to the list too? Some things in my past I
>> rather not talk about...
>
> I'm afraid 'tla' is too insignificant to be of interest :P, it's
> steady at, say, 100 users.

Maybe git-archimport has made a dent? ;-)
http://tinyurl.com/5okewp

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
