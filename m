From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git woes
Date: Thu, 27 Aug 2009 23:14:51 +0200
Message-ID: <81b0412b0908271414j16efcd7ayad7abe6a5b9644a6@mail.gmail.com>
References: <ca36ec440908262242l6e818c28gd7b0daff2b537d4@mail.gmail.com>
	 <f4f35435-79b7-46c2-8c2d-2d4c4deb68c4@s15g2000yqs.googlegroups.com>
	 <ca36ec440908271406t214fee11hed2c5e6da0e5ac0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nico Weber <thakis@chromium.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:15:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgmJ9-00055S-Mr
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbZH0VOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 17:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbZH0VOu
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:14:50 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33221 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbZH0VOu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 17:14:50 -0400
Received: by bwz19 with SMTP id 19so1246976bwz.37
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=lGqtzk2U2bJGIVFi5H/5iGzFkheAnUcccH5JARHKy9E=;
        b=LZ0cRVR+3JiJYLncYDaq81WTEriYiYdxZ3f3y0Lp7j04gWD5uFg7UMqjtxjuYuZCnp
         2029Gd5Ih4hajVpYK160TWj3Gbp8XhB3fhJw7zS/RfSWH+Yf9qx99QhK8KEbEqy7AZuD
         zuJVwrQYar4koqBZHX4k2krv3TkA8SQlx7Hx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Rh2H90vBnOqs3UCVGGP8uBrUdo57dWlr9aRxZj4Q9icU8ZzuOFoax64W5bV1hNLWef
         MkSuTlCp0j+OoVpJhek5RvlMzXsZlloErUe2ry4VWm3WywqhbG1kF2Qz8mXzSA0IAMCD
         nmdjpJEw52HusRYwBp1v0t5GsBlIPfW8rC8Pc=
Received: by 10.204.8.72 with SMTP id g8mr127075bkg.199.1251407691256; Thu, 27 
	Aug 2009 14:14:51 -0700 (PDT)
In-Reply-To: <ca36ec440908271406t214fee11hed2c5e6da0e5ac0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127212>

On Thu, Aug 27, 2009 at 23:06, Nico Weber<thakis@chromium.org> wrote:
> Hi git list,
>
> Alex Riesen asked me to forward this to this list.
>

Thank you! It is appreciated.

>
> If it happens again, I'll post a dtrace to this list.
>

Yes, this would be very useful.
