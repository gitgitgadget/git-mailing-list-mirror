From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 17:42:27 +1000
Message-ID: <2cfc403205051100421a2ffa7e@mail.gmail.com>
References: <2cfc40320505100800426d38ca@mail.gmail.com>
	 <1115739511.16187.432.camel@hades.cambridge.redhat.com>
	 <17115.200.158.14.67.1115740220.squirrel@www.tendencies.com.br>
	 <1115740844.16187.445.camel@hades.cambridge.redhat.com>
	 <26021.200.158.14.67.1115741989.squirrel@www.tendencies.com.br>
	 <20050510234501.79eea7a4.diegocg@gmail.com>
	 <20050511071717.GB23090@infradead.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Diego Calleja <diegocg@gmail.com>, eduardo@tendencies.com.br,
	dwmw2@infradead.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 09:35:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVlko-00068b-3L
	for gcvg-git@gmane.org; Wed, 11 May 2005 09:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVEKHmp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 03:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVEKHmp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 03:42:45 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:63968 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261919AbVEKHm3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 03:42:29 -0400
Received: by rproxy.gmail.com with SMTP id j1so53277rnf
        for <git@vger.kernel.org>; Wed, 11 May 2005 00:42:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NUbE+OaFZF9DU3gPhk7TOjGbWstxaStNum2m0nwphNGdB7iHFqE2gEQBA3vxLg1JeadugJiGP8/gggBDY0Z41qb0U2MXGqsOJA2ZRiXEBqTGn9nSqR5BtwUMFpWj2PpY++h/c12SC0USjbkJc8Cpxg9a5Ba6JMpJuXWRf2ibpmQ=
Received: by 10.38.209.15 with SMTP id h15mr277846rng;
        Wed, 11 May 2005 00:42:27 -0700 (PDT)
Received: by 10.38.104.59 with HTTP; Wed, 11 May 2005 00:42:27 -0700 (PDT)
To: Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20050511071717.GB23090@infradead.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/11/05, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, May 10, 2005 at 11:45:01PM +0200, Diego Calleja wrote:
> > ...and I don't think people who use eclipse wants to have the fastest tool
> > on earth, so "java-invoking-C is slower than pure java" is not a great excuse
> > either...
> 
> Note that it's also not true.  At least if you use the gcj-specific CNI
> mechanisms instead of Sun's braindead JNI.
> 
> 

What I actually claimed (contrary to Diego's misquote) is that
"Java-invokes-C-executable" would be slower than pure-Java. I didn't
make a claim one way or the other about the performance of a Java
implementation invoking some form of native interface.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
