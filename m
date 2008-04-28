From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Git Library?
Date: Tue, 29 Apr 2008 08:09:09 +1000
Message-ID: <ee77f5c20804281509y3de0cc3cx72fe76e2102e3ed@mail.gmail.com>
References: <5FCF765E-F3FF-438C-B4C1-FFB3262831A0@gmail.com>
	 <m3y76xofgm.fsf@localhost.localdomain>
	 <F427C4D4-7264-4341-A714-23D9DD39E229@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Patrick Altman" <paltman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 00:10:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqbXz-0007XK-4W
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 00:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966651AbYD1WJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 18:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966641AbYD1WJN
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 18:09:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:4927 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966593AbYD1WJL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 18:09:11 -0400
Received: by ug-out-1314.google.com with SMTP id z38so929838ugc.16
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4Mcs7TmvAwcJP2XxWT7MUMsAFCXQozptEiQulIjb23M=;
        b=mFyBL/e2OOrqlQqdUhIj5+dHKbecJM7SAuue18wxhAm3z0nRka+KL+9Y60T1zI6touTz0s0s/6Pi8qNl5H5l98zLmJ8cHqPDHBj6z1WFblseTPOQaDElE603Nibg2LQ0/wJYk3pcnyr+Vp8vVPT82B1jZtutcMxpn+tJfQ93Ak4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CkowKK6WzPihG3FESQN3TdVTQivjm76D8mFnyV8+HDEHPdu9GdYW6jxSG2pqeJJp+mQ0vwgHHNZVaEJ7HSTpFY39t1qHJUdlYYvdlvgQLMYubhjn5C/d8exu+avLrpJk1yoSHyLBmAnTJEvOrQvdiDwfDPo3h59Xy+dx1rmndgk=
Received: by 10.66.223.2 with SMTP id v2mr5458935ugg.18.1209420549248;
        Mon, 28 Apr 2008 15:09:09 -0700 (PDT)
Received: by 10.86.96.12 with HTTP; Mon, 28 Apr 2008 15:09:09 -0700 (PDT)
In-Reply-To: <F427C4D4-7264-4341-A714-23D9DD39E229@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80628>

On Tue, Apr 29, 2008 at 7:17 AM, Patrick Altman <paltman@gmail.com> wrote:

>  I think that this point I am just going to use NTask and the like in
> Cocoa/Objective-C to wrap the command line utilities.

That's the way I approached it when I started doing a half-hearted
attempt at exactly what you're proposing. Clone my (small) rough code
from  http://git.symonds.id.au/macgit.git



Dave.
