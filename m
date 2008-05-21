From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: looking for "market share" analysis of SCMs.
Date: Wed, 21 May 2008 07:21:50 +0200
Message-ID: <bd6139dc0805202221v6fc476e8rcdb1822b17d8c13@mail.gmail.com>
References: <48329282.1040407@tikalk.com>
	 <20080520093245.GA5037@mithlond.arda.local>
	 <bd6139dc0805200310j13a9b74dy9f28fe855c59e01b@mail.gmail.com>
	 <alpine.LNX.1.00.0805201748020.19665@iabervon.org>
	 <bd6139dc0805201525r22ba7398g6f341f89ae699b57@mail.gmail.com>
	 <alpine.LFD.1.10.0805202105430.3081@woody.linux-foundation.org>
	 <46a038f90805202126s80262d3i2f4f940a38d9ea06@mail.gmail.com>
	 <bd6139dc0805202144h2bb55fd1n9b26bc76c245f33b@mail.gmail.com>
	 <46a038f90805202210v5d0f75cekbad51da89c46f47@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Teemu Likonen" <tlikonen@iki.fi>,
	"Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 07:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jygmg-0005i5-1t
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 07:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbYEUFVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 01:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbYEUFVv
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 01:21:51 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:26053 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbYEUFVu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 01:21:50 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2057280wfd.4
        for <git@vger.kernel.org>; Tue, 20 May 2008 22:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DlB6xmA4j/D0EmbMD4MgHJyWrrX5WEIunyr1xc2t2e8=;
        b=sjcQoMzSqDmBV0PhBakiH39QwBTtOK84/kzpDqNP/HrhHTrE7Xx/HIOvpY7ZxXho5Hw9dd9QYjWbdx7EKNvIpz63afsuNfEVrMhc6LUBM/7Yu6+x/8irzmwyBiLUh3eRaCQubwfFNcHC+F1SPr1WB1ynn4pAh/9d1KAq0AU4Y8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mUIyAPkHrGpfl0Y2pIXrF9xWc1VrNrvdSe+pdL7QH/qbPy74HVlbmiAX+CdlzYqVc1vt68+c48cpLf/bXgV07iE3IktkU/GG5WTM1DtZNabo5uItEThkygTBSwFwml4bZ4LBKht0jpSdjAhCeLzPT5/4kllc44vNDbrJPCcUbZ8=
Received: by 10.142.72.4 with SMTP id u4mr3688938wfa.269.1211347310193;
        Tue, 20 May 2008 22:21:50 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Tue, 20 May 2008 22:21:50 -0700 (PDT)
In-Reply-To: <46a038f90805202210v5d0f75cekbad51da89c46f47@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82527>

On Wed, May 21, 2008 at 7:10 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Actually, if we define the "market" to be DSCM, and the timeframe to
> be existence of the git-core package, this graph of installs is quite
> useful:
> http://tinyurl.com/4uemg2

Hehe, that feels a bit like manually favoring the odds in our benefit,
but it's fun to see how git is the most popular DSCM since 2007 ;).

> Maybe git-archimport has made a dent? ;-)
> http://tinyurl.com/5okewp

It would seem the contrary is true, the usage of tla was steadily
declining, but since git-arch it has been picking up! (Well, that is
what one could naively deduct from this graph, there's probably
another explanation :P).

-- 
Cheers,

Sverre Rabbelier
