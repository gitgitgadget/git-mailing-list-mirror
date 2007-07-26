From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 14:21:56 +0200
Message-ID: <46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
	 <7vps2fc196.fsf@assigned-by-dhcp.cox.net>
	 <20070726031838.GO32566@spearce.org>
	 <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0707260614500.14781@racer.site>
	 <46A8378A.6050201@xs4all.nl>
	 <Pine.LNX.4.64.0707260737170.14781@racer.site>
	 <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
	 <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: hanwen@xs4all.nl,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 14:22:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE2Lx-0004hr-FH
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 14:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbXGZMV7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 08:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754393AbXGZMV6
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 08:21:58 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:40732 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbXGZMV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 08:21:58 -0400
Received: by nz-out-0506.google.com with SMTP id s18so451577nze
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 05:21:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tiUKyV7uKrH4m7M6fUYO8HFrqX3DJxrr2Hi9ZvJAcMiKzYkS7rB+CUY4i3HzzhQXOwMlih0Yhr3DIHNsJOUMQewxtupDS0CC3WHfoa+wcZBOH9PJULGHrYnlb7zq6ufoo/kh1h0GheIsvXsM273R+FVHY3b6qT0XUv+MobhxiTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V8K+uOq3N7uh4iQtIxNsaOWSFfVy0FghbeaM+iPtRdDiaHzQ06CCbd/3qBTwwi6VSBgUnUGruTqKt6uwJ6focMQA1HIEyz7iIpr1Jn1fj3r5TrZ1AbBx1eJOqU0yXIyO7tsTofNYEUuRz0RYIlliDuKhsHFRXYPB7RtuN7NIEYs=
Received: by 10.114.78.1 with SMTP id a1mr1661574wab.1185452516712;
        Thu, 26 Jul 2007 05:21:56 -0700 (PDT)
Received: by 10.115.78.15 with HTTP; Thu, 26 Jul 2007 05:21:56 -0700 (PDT)
In-Reply-To: <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53822>

On 7/26/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> microperl [1] maybe? I haven't tried it yet.
>

it won't work. I tried that few months back.

plus the fact you'll still need perl modules.

I just had a look at your gitbox gitweb. Did you really manage
to get busybox-1.6.1 to work with mingw ?

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu
