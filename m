From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 25 Apr 2009 23:53:54 +0300
Message-ID: <94a0d4530904251353p1e00e015o67825c8726817894@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
	 <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
	 <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com>
	 <alpine.LNX.2.00.0904251445030.2147@iabervon.org>
	 <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com>
	 <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com>
	 <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 22:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxoum-0005vF-Ej
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 22:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbZDYUx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 16:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbZDYUx4
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 16:53:56 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39055 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbZDYUx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 16:53:56 -0400
Received: by fxm2 with SMTP id 2so1650316fxm.37
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KEFewlLRhnu7f2DNaCZEysF/C2mnWgMk++n347GS/To=;
        b=NX7P0Fjt8pV9DrtVTkLfhK8Gvk2P3JiT2j6+dFcrse7jRxNklNz5AHKHiX3Z6iLzC5
         3SOgdFvurwUTpVZLWSwtAe2i5ZxP7kIZ80ZKGNB0rnMX9x1lJ7zXRmt9hLVISirR7mIV
         0UVNvbbie08tasac6z3B1qKsqGXRjrprI4too=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TH/PPNuo3JjtAGcN7h1u8skvmkbhQA2V9EdJ9genpzjuYmQ51EIf6j6IpScsihV85c
         6OlTxL54wxhnwVG6xsL1PrTQs9ydtKvX2ZzsjryCr7Z6B1yTBUAkp0R/oXPNZkTsGd3V
         FWYQItOuInzJs7L37KeUN/MKruhNpIgN/0hHI=
Received: by 10.86.59.18 with SMTP id h18mr1909009fga.44.1240692834586; Sat, 
	25 Apr 2009 13:53:54 -0700 (PDT)
In-Reply-To: <E85677CA-FA7E-4777-97DF-9B295E89B83A@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117576>

On Sat, Apr 25, 2009 at 10:36 PM, David Abrahams <dave@boostpro.com> wrote:
>
> On Apr 25, 2009, at 3:24 PM, Felipe Contreras wrote:
> Where it's relevant when the user notices that two distinct files have the
> same id (because they happen to have the same contents) and wonders what's
> up.
>
> It's not a foregone conclusion that objects with the same value have
> identical ids, but it's immediately apparent if the id is known to be a
> hash.

That's true.

hash +1

-- 
Felipe Contreras
