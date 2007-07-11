From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Hook after pull ?
Date: Wed, 11 Jul 2007 16:51:44 +0200
Message-ID: <81b0412b0707110751i7947ac5bv819e1c2de4e94621@mail.gmail.com>
References: <4694EC0F.10003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Claudio Scordino" <cloud.of.andor@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 16:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8dXj-00017u-NC
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 16:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761845AbXGKOvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 10:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759723AbXGKOvr
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 10:51:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37072 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758888AbXGKOvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 10:51:46 -0400
Received: by ug-out-1314.google.com with SMTP id j3so129760ugf
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 07:51:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WuqifwVwwwiR4mQ0fvnI8t5aNAVy0ISwOAukO/roaEa5kK5nZhm2MqsFzZ+RzbftNH75RarQuD/4qkFnlNuHuclRLf0e6c2+nzmhYvSkOMnIOQ3K4f8qIZ8mElpAnnDroVWC/Ixgu+cWqZdKdwoS77eO05zNrGqigqsDgDZB33I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KVuJ1bX0xlgQ/2u7R8V3+XgH1+/RhtgLilrM+pT7txuoEhZ8tGmtePCloDU0v8yOQO/BG+TiOjn4Es+/evkWAmMFzkP5CQcLupqRUgFNZyL7gjoYQJbdDIKOCF5w1uDDnEbEZwLs/S9+KHHYuygmRFHDThi/Dzn9YXSr+dMKEvU=
Received: by 10.78.181.13 with SMTP id d13mr2443717huf.1184165504409;
        Wed, 11 Jul 2007 07:51:44 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Wed, 11 Jul 2007 07:51:44 -0700 (PDT)
In-Reply-To: <4694EC0F.10003@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52165>

On 7/11/07, Claudio Scordino <cloud.of.andor@gmail.com> wrote:
> Hi all.
>
> Does any hook being called after the pull (that means, after fetch or merge) ?
>

There are some

> If no, does exist any easy way of creating such hook ?
>

What for? What do you want to do?
