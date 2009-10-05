From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: previous references
Date: Mon, 5 Oct 2009 23:20:24 +0200
Message-ID: <fabb9a1e0910051420q58bded6aqa9510b2cc77a1419@mail.gmail.com>
References: <8E72DAAF9F8E4024BB819F3F83CCFC79@teddy> <200910041127.29588.johan@herland.net> 
	<1254777067.26111.105.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>,
	=?ISO-8859-2?B?T2N0YXZpYW4gUuK6bmn+4w==?= <orasnita@gmail.com>,
	git@vger.kernel.org
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muv2F-0004P2-Md
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 23:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbZJEVVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 17:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbZJEVVW
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 17:21:22 -0400
Received: from mail-ew0-f225.google.com ([209.85.219.225]:41119 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbZJEVVW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 17:21:22 -0400
Received: by ewy25 with SMTP id 25so3093555ewy.21
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Uj8czNU2eBPFB5APr4YoudzADWhnnOZAZRJQPodcEEw=;
        b=SG+GcdkC/Nx7ioPdcqCtuv8G6N/FLdjHyNQ0aimGfqqWO9h1+JSSA4TURwcIuMHBpX
         l06FPjSsR+v/oNLBBS2Ducw+fa8W69kl9RLlRuK5ZQoW3NSmJtNbciRX8oIjUUCI1vSG
         plp2mRuctSEPBBKboS8awm8oDyzwMmMpX4UFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eXYx7JilPJkRznCNMs1gmv7oD78mf99dVR6+HP4mdXDnh4T0xAFNcEqQtafIEborun
         6McKCe/fsz3QukxMHczJuOgu1uPvkAj9gpk9yC+n+0Z8a7nifPG+aXy7AfxyscadG7Mh
         xAmtGYiZMDXg7GRrc60ChnyTYttMIgHRedKHI=
Received: by 10.216.27.137 with SMTP id e9mr126270wea.124.1254777644188; Mon, 
	05 Oct 2009 14:20:44 -0700 (PDT)
In-Reply-To: <1254777067.26111.105.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129594>

Heya,

On Mon, Oct 5, 2009 at 23:11, Daniele Segato <daniele.bilug@gmail.com> wrote:
> fatal: ambiguous argument 'HEAD^2': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions

Really? That's awful, shouldn't we at least say something about HEAD
not having that many parents?

-- 
Cheers,

Sverre Rabbelier
