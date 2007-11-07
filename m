From: Aghiles <aghilesk@gmail.com>
Subject: Re: [PATCH] Documentation: enhanced "git for CVS users" doc about shared repositories
Date: Tue, 6 Nov 2007 20:36:46 -0500
Message-ID: <3abd05a90711061736r4c969cddj348c006615ffbdd6@mail.gmail.com>
References: <472F99F8.4010904@gmail.com>
	 <7v8x5cmern.fsf@gitster.siamese.dyndns.org>
	 <4730E056.7080809@gmail.com>
	 <7vd4unez2l.fsf@gitster.siamese.dyndns.org>
	 <47310ACF.4030103@gmail.com>
	 <Pine.LNX.4.64.0711070053320.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Francesco Pretto" <ceztkoml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 07 02:37:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpZqy-0002Rp-Sn
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 02:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbXKGBg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 20:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbXKGBg7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 20:36:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:46703 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110AbXKGBg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 20:36:58 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1865825nfb
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 17:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MP+ujlXMpT9nGXlyYXWW5WqZv05gvXEgLon8BT7EToM=;
        b=jwPp501PDbjrmjP9kDnspmr0iVRojZTtC+2fkWXB41aOg9Y/k3JyxsAXRVEU7mP7U9JYojWHNlhbOte4zLE+2JGCzcnA3Gb3BQdVAe6r4TqK3BVeFX7PzeTNAGCUyt3Py92L+txGtMvqHc97vpklxEeEfyVuF+bp6adHPhD+FPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=khCqstGHxj35WW1LpZfzRb7DgoWlyQoszmK1U36b/7pVlXNLuT4Hx0X2cZ1FW3Cv+pqdI0yx4FQpIqtp7U84bEnPPjW+awistCf673fzBxeHsxT3CaxOuvdJ/3T9mwp1r9IuyOuvMZNwCbZ+E7ZWe3Toj/qFUQ/T4Vl3eXJflGo=
Received: by 10.78.132.2 with SMTP id f2mr5500392hud.1194399416444;
        Tue, 06 Nov 2007 17:36:56 -0800 (PST)
Received: by 10.78.185.1 with HTTP; Tue, 6 Nov 2007 17:36:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711070053320.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63766>

Hello,
>
> Remember, those who read "git for CVS users" are _unwilling_ to spend the
> time reading git documentation (at least for the most part).  If they
> encounter something which is not useful to them, they will not just ignore
> it, they will stop reading.
>

I must disagree with this analysis (although I didn't read the content of the
patch you are commenting). People that are not really interested in git will
find many reasons to stop reading the manual anyway. Those who really
want to migrate (such as we did) are looking for every tiny bit of information.
(We googled git commands and error messages because we didn't
find what we needed in the docs)
The docs are not perfect and somewhat unequal in content but I prefer
more information than less, at this particular stage of git development.

- Aghiles.
