From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Licensing a file format (was Re: SVN Branch Description Format)
Date: Sun, 18 Mar 2012 20:34:22 -0500
Message-ID: <20120319013422.GC19680@burratino>
References: <4F5C85A3.4080806@pileofstuff.org>
 <4F668BD4.70808@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Nathan Gray <n8gray@n8gray.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>, semen.vadishev@tmatesoft.com
To: Andrew Sayers <andrew-20120318@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 02:34:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9RUZ-0000l7-MU
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 02:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397Ab2CSBea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 21:34:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46041 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab2CSBe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 21:34:29 -0400
Received: by iagz16 with SMTP id z16so8712413iag.19
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 18:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wbbmlIOXtLp/n2R3Z+nL2HAloIrM9cPxS/1pM9gqQIY=;
        b=ewcrqW3TcQPG/HSSTH+6Rslht4oMd+pAL0e+763UoFZt6P/yeDzkWW6jQtMGaUqIMT
         S6O7own+N6a6mDZ7qgLpGHYorS6c9pIzxGcTX0zK6x5pZR+bd06zDds79YqNlLORySgX
         dTC3h0P3ryZjB0PHNQohGR6CjzLm9MS1FwKK2UKWUL5SUeeaQV78yMnhumP6wfcUdisv
         elqWv6XOTe6druXcyY+HRfzXNSIVuyydRfrygiZe0qprOOWiEqaqueNnV2pAojhUIYme
         MASjxHsK+kFUX/daRS3A3ya34oFj8Rd5KuGqQeh3oOAlRV1HyLb6nycbw8/LTph1ZFjo
         hX1A==
Received: by 10.50.154.169 with SMTP id vp9mr4625869igb.71.1332120869419;
        Sun, 18 Mar 2012 18:34:29 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ko6sm4955543igc.2.2012.03.18.18.34.28
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Mar 2012 18:34:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F668BD4.70808@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193409>

Hi Andrew,

Andrew Sayers wrote:

> I'm planning to release the spec under a Creative Commons
> Attribution-NoDerivs license
[...]
> So the big question - would you be more inclined to use/contribute to
> the SVN Branch Description Format if it had a different license?

Yes.  By the way, I think fear of forking/discussion of potential
improvements/translation into other languages in the context of
standards is misguided.  If you would like legal protection for your
standard, that is what trademark law is for.

Kind regards,
Jonathan
