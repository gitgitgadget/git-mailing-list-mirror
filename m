From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Give the hunk comment its own color
Date: Wed, 18 Nov 2009 16:16:15 +0100
Message-ID: <36ca99e90911180716v2bebffdeva7caa3abe7eb0115@mail.gmail.com>
References: <1258543836-799-1-git-send-email-bert.wesarg@googlemail.com>
	 <20091118142320.GA1220@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 16:16:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAmGp-0008SP-7S
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 16:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757443AbZKRPQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 10:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757239AbZKRPQN
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 10:16:13 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:58587 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183AbZKRPQM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 10:16:12 -0500
Received: by fxm21 with SMTP id 21so1288723fxm.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 07:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=0px74yHN9NM2NWAh75BmXqbP3KZQ45sM0qh1W+K1ZXo=;
        b=L/Ui9S0pjwhzbo0C9SI9XH4u3949S+S2v+247h7U7jButUZXcvi8rNTK6KQh/4ilBv
         2GWI9qL1kAB8bDfrjBNxX7gNKEnmjcUIKoXY2PpXKJK75YdCNa77Kuv6iZRUj2I9H1Ro
         VOteBmwYoVfLAPnlzKWt3UN2WJmDXSc/o59RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mP0mP9yO6l7Ald2zw8sD3hDzvE02voxR6MuUQIvtYIgsHBUpud28aewh7svLWH1FTh
         Y3ENau+nW57oSB4RCP73cj+1FBkdaDPaJ3Bi4fqJlSssvNyQA/RBrDAhBWmY1uB8Y192
         5lw+wdWGP70qiee02lsNGKUu2foegdI4LEtJA=
Received: by 10.223.161.215 with SMTP id s23mr797403fax.44.1258557375963; Wed, 
	18 Nov 2009 07:16:15 -0800 (PST)
In-Reply-To: <20091118142320.GA1220@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133184>

On Wed, Nov 18, 2009 at 15:23, Jeff King <peff@peff.net> wrote:
> PS I almost complained about your default of "magenta" as the same as
> the meta color before I remembered that magenta meta is a personal
> setting I use. Personally I find the bold meta color to be distractingly
> ugly. Blaming it, the default seems to come from Linus, who even in his
> commit message (50f575f) seems to indicate that it is somewhat arbitrary
> (mostly just dropping the purple from the bold purple).
I took magenta, because it is not used as any other default color
value. I think choosing a color other than cyan would bring the
attention to this new feature.

Bert
