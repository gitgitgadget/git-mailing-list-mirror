From: Scott Meyer <dutchlab@gmail.com>
Subject: Re: URL not displaying change made with git.
Date: Fri, 24 Apr 2015 08:59:25 -0400
Message-ID: <CAKXTx=3HeZ7WzX-4soENvPL1TSomg-xgSMn_-sABMOs1x=yRDg@mail.gmail.com>
References: <CAKXTx=1g6eBR1hR9vsQohjp2nCjd=gGU=embAzfQhp6JKZNyWQ@mail.gmail.com>
	<vpqoamdellc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 24 14:59:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YldCd-0005bs-39
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 14:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbbDXM70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 08:59:26 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34922 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbbDXM70 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 08:59:26 -0400
Received: by pabtp1 with SMTP id tp1so47987238pab.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2HfYruTXC+5Z6cxxCIW5NMItsjZ9q4dN7o65eNHJ+ec=;
        b=xLz8PFV5scZv5MTzYl4Ydi1/Uf686c/S1hvdETWJGo8tiQKYaigA2k3kg9NneXEqLB
         lWFLiqBrH6YMWN7Y19hhcRkOM2yKotC82jTMr5ISWWpGPi1JiZPhhHgzQRcv1/BTR2ux
         rm69TlTkyXGci5oPJQa6WddXEZVQwZFgVjUcQNcz1V58kJqgyirJ7jVlYX5Yupq5/fX5
         asIU8L36TgltQsBCqGa2YzNqVJgqIV4ulThEprQXRiuHn3ktWopIaky4ps2BUTPb7/GO
         fhe/gVu+1N5slEAfqwhT9zh03k9wim3EAPiw3tstNUoWsrpLavxO36VCS4MHLvVajXdb
         V4CA==
X-Received: by 10.68.191.229 with SMTP id hb5mr14717991pbc.126.1429880365890;
 Fri, 24 Apr 2015 05:59:25 -0700 (PDT)
Received: by 10.70.75.9 with HTTP; Fri, 24 Apr 2015 05:59:25 -0700 (PDT)
In-Reply-To: <vpqoamdellc.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267738>

The site is local to my laptop.  I am attempting to establish a
development environment where I can view and test changes before
moving to production.

On Fri, Apr 24, 2015 at 8:50 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Scott Meyer <dutchlab@gmail.com> writes:
>
>> When I use my browser to bring up the site the change is not visible.
>
> Which site are you talking about?
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
