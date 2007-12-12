From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Wed, 12 Dec 2007 13:50:55 -0500
Message-ID: <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
	 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
	 <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
	 <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
	 <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
	 <20071212041002.GN14735@spearce.org>
	 <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
	 <20071212052329.GR14735@spearce.org>
	 <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
	 <Pine.LNX.4.64.0712121814260.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Wfv-0004a3-PR
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbXLLSu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbXLLSu5
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:50:57 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:61213 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbXLLSu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:50:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so560585wah.23
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 10:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9+b1gc5aUBES6riiaeo7yKrquTyjkqRB0eBECx3Mbkw=;
        b=Y5a8ZTSvvGFmJpd0Rk75tOVBm3VjsqLfFwWaqboP0+4u8f4EliQnNRZuJ0ts6TA93ioXEmpMemBj7ZxL2ZN5FDffEdkAUx79dvxdB2d2tfJ/XFImb0R2WNKVVBkjunVDAJWQz9WaSidZXg7IDy50drBygbrmxMN62KvAUvU6cAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UeU1kQJHHwK5ANA56sOKGHt7ZIVAScwcc1mwKluzljjOj7BnBFz6LhS/8Res7beuvyxc3oi5Q5bEefLj/FA1q0XmDmoOodIZXsKfx+AAWSkkAAx8l3Bv7/pz/PcmmsiQbo8QpeomT/TdIS0ge3Skbv7sP2gEs4RhpPfqsLW1E+8=
Received: by 10.114.154.1 with SMTP id b1mr1166330wae.34.1197485455867;
        Wed, 12 Dec 2007 10:50:55 -0800 (PST)
Received: by 10.115.18.14 with HTTP; Wed, 12 Dec 2007 10:50:55 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712121814260.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68087>

On Dec 12, 2007 1:15 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 12 Dec 2007, Jason Sewall wrote:
> > On that note, did you see what I wrote above, about having "split hunk"
> > functionality?
>
> I had a patch for splitting hunks in git-gui in August, but there were
> some issues that I did not yet resolve.  If you want to work on it, I'll
> gladly share that patch with you.

Sure, send it along. I'm not going to make any promises, but I could
probably find time poke around in there.

Jason
