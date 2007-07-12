From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-update-server-info may be required,cannot clone and pull from a remote repository
Date: Thu, 12 Jul 2007 17:05:52 +0200
Message-ID: <81b0412b0707120805l105bc692yfa8698293683f492@mail.gmail.com>
References: <a901b49a0707110708o7c883bb0s707d9791f344f1f6@mail.gmail.com>
	 <81b0412b0707110731n4ffa25afoea5395a856869325@mail.gmail.com>
	 <a901b49a0707112227m2ea746ectd367031fdc8d3537@mail.gmail.com>
	 <f74tk8$k21$1@sea.gmane.org>
	 <a901b49a0707120550i9361e30wc5811bd5d3305f59@mail.gmail.com>
	 <a901b49a0707120552y649fba20p4fa14ca48be4be54@mail.gmail.com>
	 <Pine.LNX.4.64.0707121411070.4516@racer.site>
	 <a901b49a0707120632m1654733as94839e88bd993bb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "pradeep singh" <pradeep.rautela@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 17:06:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I90Ev-0003Gf-Bx
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 17:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069AbXGLPFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 11:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756507AbXGLPFy
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 11:05:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:24696 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007AbXGLPFx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 11:05:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so356082ugf
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 08:05:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CQ87/GmOTN1TS0YQ3YC9KQIVGNk86XDRFY+9Aif1sIQZoAIfdZIMKbiqNE2bVGfC63ZZvfO1tsWYh3PNE06wE9GABkfM1liSX5HmvyNi4AyA424aKnGY4M18iIyqsEydZ3viOPaOONqkAlwMIf2YzL1ad1YTvFDZVYJyZbQSyKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cgaB193DoeOChNIb56iFhO2zKyWNQdREU2qooRSh+BxHBtnXPChQcHLxe0tCueYU+JIc113JzjKmxVNZChq9H57J0LkXkvN6IzJRmOJOZEbbhrwYDcAL+k39aZJN8522uDF0ydtzi+GXrPtKVDh/YPeROdlAggXOie+T2BEcsQM=
Received: by 10.78.170.17 with SMTP id s17mr169293hue.1184252752307;
        Thu, 12 Jul 2007 08:05:52 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Thu, 12 Jul 2007 08:05:52 -0700 (PDT)
In-Reply-To: <a901b49a0707120632m1654733as94839e88bd993bb1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52297>

On 7/12/07, pradeep singh <pradeep.rautela@gmail.com> wrote:
> If i upgrade to git 1.5.x will i loose my earlier git info and all the stuff?

No

> I hope having differnt git versions on different machines does not hurts?

It does not hurt, but you'll find you like the new one.
