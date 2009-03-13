From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Fri, 13 Mar 2009 08:45:04 +0530
Message-ID: <ab9fa62a0903122015l58c32ca5mfbe1e04e9a2353aa@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
	 <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
	 <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
	 <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
	 <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
	 <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>
	 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>
	 <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com>
	 <alpine.DEB.1.10.0903121343590.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Mar 13 04:16:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhxt3-0004sp-Ey
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 04:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbZCMDPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 23:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbZCMDPJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 23:15:09 -0400
Received: from mail-gx0-f167.google.com ([209.85.217.167]:33616 "EHLO
	mail-gx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbZCMDPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 23:15:08 -0400
Received: by gxk11 with SMTP id 11so2572542gxk.13
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=utpTKtZq6lzWmeNQCX/faQFVB15LvcDcdpwk9/NlAas=;
        b=Oqtmhr9NC71wSTNi5aukjhwah/euFcHc3ecTBRU+PeyCf3/OBAG1sL1yqt5pqYG3/Z
         pkMpC/BgP0MtXf6GenD2AsP8Y19ZPp1q9bf1/X4Jh7IF7iFhh+TjjyMag3irah2a/1XG
         RWX/Rk4awzuOJrR8NWTu29xbR1DfoAWusXWRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jnzcPGctn31qh43uPiOJi7JXvNp0uTpvrOhAW5FEDms9UzPHoCGLXQ60oWSGcTgDfk
         yQinUhkD7RJxlmWNcteaXajx1WgdseBX8Br+Mrra8Q3gCEkG2jhqJ3QMV064hj2IcxKT
         uUseJi3mBaAmyTSuH8NiOeOrH8jy9R4QtLKKc=
Received: by 10.231.16.197 with SMTP id p5mr175839iba.51.1236914105068; Thu, 
	12 Mar 2009 20:15:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0903121343590.16753@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113139>

On Fri, Mar 13, 2009 at 2:15 AM,  <david@lang.hm> wrote:
>
> when I am mentioning config files here I'm thinking of ones that don't use
> XML (such as the git config file)
>
> a 'paragraph' merge driver could also help with things like a maintainers
> file where the order of the paragaphs doesn't matter, just the content
> inside each one.
>
> that's very similar to re-ordering XML tags, but with a slightly different
> syntax

yes, in that case, I think we can modify the existing text merge
driver somewhat and provide these configuration options to the user.
User can choose the option to configure the merge operation.


-- 
Saurabh Gupta
Senior,
NSIT,New Delhi, India
