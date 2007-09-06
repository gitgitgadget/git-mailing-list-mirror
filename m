From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Include a git-push example for creating a remote branch
Date: Thu, 6 Sep 2007 12:50:30 +0200
Message-ID: <A3C344D0-B2A0-44DC-BCBD-3B2C1EBD24B1@wincent.com>
References: <20070906044408.GA588@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 12:50:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITEwd-0008Lf-Ai
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 12:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbXIFKui convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 06:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754254AbXIFKui
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 06:50:38 -0400
Received: from wincent.com ([72.3.236.74]:45902 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511AbXIFKuh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 06:50:37 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l86AoXEF001297;
	Thu, 6 Sep 2007 05:50:34 -0500
In-Reply-To: <20070906044408.GA588@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57860>

El 6/9/2007, a las 6:44, Shawn O. Pearce escribi=F3:

> +git push origin master:refs/heads/experimental::
> +	Create the branch `experimental` in the `origin` repository
> +	by copying the current `master` branch.  This form is usually
> +	needed to create a new branch in the remote repository as
> +	there is no `experimental` branch to match.
> +

A welcome addition; I was puzzled the first time I tried this myself =20
too.

Cheers,
Wincent
