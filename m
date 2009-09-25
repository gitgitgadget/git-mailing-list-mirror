From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 20:08:42 +0100
Message-ID: <e5bfff550909251208v68a561beu2d9f21ae2417fdd6@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>
	 <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>
	 <e5bfff550909250704x724fd4c7lebe7184b4557c7a9@mail.gmail.com>
	 <4ABCCFE4.6070202@viscovery.net>
	 <e5bfff550909250718y51709692kc8d1e2586017341b@mail.gmail.com>
	 <4ABCE167.7060204@viscovery.net>
	 <e5bfff550909251125t6ed59b1fv953eee597adc4471@mail.gmail.com>
	 <4ABD0E90.5030301@gmail.com>
	 <e5bfff550909251144ma9e4dccmb54a64f364b820fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: alexandrul <alexandrul.ct@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 21:08:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrG9y-0004Vy-4O
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 21:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbZIYTIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 15:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbZIYTIk
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 15:08:40 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:60140 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbZIYTIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 15:08:40 -0400
Received: by ewy7 with SMTP id 7so2840224ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=g325K8HlezGS/L6jEOn45qbbwtKDlIYXj16ILV8TJ1E=;
        b=B6ZNTuIX1RLkWvoHdELViXjMXd3zlUQSvMvdYmMEGY8MGBUCc+hOr+Zu2H26fzVoRS
         naiJmqbWDXX/3PynwPjrXPF3hHgUezNHlad52053tCbEKFnKeFKWI5UTUTv7oDXo/MbG
         gqJkfyG+vbTH+pUYu+SG0iKzEvZ6rv9kxotEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hp5mQNwyUtW8tXg5yPdtxSY4dtO4YVEVZz9ukscGdVpLo+p4I4t3ZRM4YEvMh44Oqi
         w0T51jo2tU9z841J422L47WWsRUcr2TnzkwXzlDjOsrrHJSdKOTMl61tFsjnrLcVyRdB
         SjMiqXzfv9csqTN3XJezotznlbcvEVEC2z7vs=
Received: by 10.216.16.148 with SMTP id h20mr104192weh.141.1253905722232; Fri, 
	25 Sep 2009 12:08:42 -0700 (PDT)
In-Reply-To: <e5bfff550909251144ma9e4dccmb54a64f364b820fa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129105>

>
> This is a good idea, thanks. I will copy the git folder to a working
> PC and we will see....
>

I have copied the whole Git folder to another PC with windows xp.

I have moved the Git directory and all its subfolders under program
files instead of the old that I have renamed.

And everything worked as expected ! no problem and from git bash I
verified that the new copied version was running.

I really don't know what to think....
