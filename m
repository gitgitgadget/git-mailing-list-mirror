From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: error when installing 1.7.0.1: "ImportError: No module named 
	distutils.core"
Date: Mon, 1 Mar 2010 19:32:24 +0100
Message-ID: <fabb9a1e1003011032r61577a2cr21a1fa61154c2d76@mail.gmail.com>
References: <20100301144000.GA17135@cs-wsok.swansea.ac.uk> 
	<be6fef0d1003010715l31d7b49bs36ee69685e1684e8@mail.gmail.com> 
	<fabb9a1e1003010724g7c4d2517v1515b846e288713a@mail.gmail.com> 
	<bb49d06f73fe23be76e16089ce8b251c@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Johan Herland <johan@herland.net>,
	Oliver Kullmann <O.Kullmann@swansea.ac.uk>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 01 19:33:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmAQM-0000iY-6O
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 19:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab0CAScr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 13:32:47 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab0CAScp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 13:32:45 -0500
Received: by pwj8 with SMTP id 8so1821327pwj.19
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 10:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=c6b+IR94s+jinvNdZNLivKBp1yrgGuq2wMWH5yyEOqs=;
        b=P2d+vqxYv91W2upNZWc0EnfiQb0E+iNC2n1zu9CsYxH6kB/wpwrOGqX01ZFchiKnag
         wwAZmU9Oo7nFfGpqGUBStw97bUT7f1uSFhpSvQhTkkWKf7aJeCcdYX1Z+ImbTHc1eqow
         FagAZ38cuqyr+9VDr9uenzVmSA04dVfbE4v6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ejOlnx3ALPNRB0lOH5EpwJzl6ltZ61reJdKsYd0/zDyFkuqbRTujBorDp8A/bbEep7
         bEkNN1phCOl0cH+W40rxD6JR+h4W0xQvcsE2oQ7CjPcCNcp1uD074QfHx6a7CfEVeQC9
         wMFr2yCWuFakzBGY1dLGQxLCwbU577mE6YdKE=
Received: by 10.142.151.5 with SMTP id y5mr2803036wfd.70.1267468364544; Mon, 
	01 Mar 2010 10:32:44 -0800 (PST)
In-Reply-To: <bb49d06f73fe23be76e16089ce8b251c@212.159.54.234>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141340>

Heya,

On Mon, Mar 1, 2010 at 19:21, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> Something like the following in the Makefile perhaps?

Indeed, I reckon there's some style issues there, but something along
those lines yes :).

-- 
Cheers,

Sverre Rabbelier
