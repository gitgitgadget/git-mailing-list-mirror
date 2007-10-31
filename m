From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 14:49:49 +1300
Message-ID: <46a038f90710301849h1c31736an1ec163aa1e274577@mail.gmail.com>
References: <Pine.LNX.4.64.0710280000240.4362@racer.site>
	 <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org>
	 <20071029214925.GH21133@thunk.org>
	 <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org>
	 <20071030030104.GK21133@thunk.org>
	 <7vtzo9s221.fsf@gitster.siamese.dyndns.org>
	 <20071030044026.GA9600@thunk.org>
	 <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
	 <46a038f90710301741n67526976vda1cd131270aa7f@mail.gmail.com>
	 <20071031014347.GB23274@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:50:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In2ia-0001OI-RA
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 02:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbXJaBtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 21:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbXJaBtw
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 21:49:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:51353 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbXJaBtv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 21:49:51 -0400
Received: by ug-out-1314.google.com with SMTP id z38so235642ugc
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 18:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Pen3sAaOchVIshQ+jTZlH4b1QuJgwZgzIuh8142oGKU=;
        b=LGmO1uA9whxYg1t8iEa88PMadW+DiUqdUjQSQFXRPkluBKuBObf67kAaAeLSNMj9bZmRxcqrbyH4aS6sOax4PsBwcjnaZDcmGeMY7Dtxgc8OA00LPBz1i4JSq5NRBdXM92QEOHj8BbTOFt+oQuIoN7iOan5CwZIlmBxZhS0GosI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H4B75MTVeEdgLmQrJTWVRPXH+PC+FpqjnLAnVTfWEQKHfO712GCWIQYasaFnWlWIzI4SVPiNeplogv7A1YayY0J2pkSlEvngd/H6fPZxDI+ITFk7asS2VAr0oL+OGe1Y5ZrSX0n8MnNC2KlB7VT+CCVlIPKVj0S5KrBI1sDQW8k=
Received: by 10.66.221.17 with SMTP id t17mr118427ugg.1193795389761;
        Tue, 30 Oct 2007 18:49:49 -0700 (PDT)
Received: by 10.66.252.2 with HTTP; Tue, 30 Oct 2007 18:49:49 -0700 (PDT)
In-Reply-To: <20071031014347.GB23274@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62776>

On 10/31/07, Jeff King <peff@peff.net> wrote:
> Actually, IIRC it won't fetch any of the non 'blue' refs.

You recall correctly, and that was a cogito misfeature. I don't think
git should follow that part of the spec ;-)

> Anyway, to recap (my impression of) the discussion leading up to this:
>   - the cogito feature is useful
...
>   - flamefest begin

Great summary. I read the first and last stages you describe (with a
trip in the middle distracting me). Heh.

No stress. Let the flames continue!


m
