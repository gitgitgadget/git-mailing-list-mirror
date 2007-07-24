From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: http git clone memory problem.
Date: Tue, 24 Jul 2007 09:58:42 -0700
Message-ID: <1621f9fa0707240958y7c5f1b66lbfa940d60c082067@mail.gmail.com>
References: <1621f9fa0707232044j7cec2bes7bc7cd268775ce48@mail.gmail.com>
	 <Pine.LNX.4.64.0707241025450.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 18:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDNih-0002kS-MH
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 18:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbXGXQ6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 12:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbXGXQ6o
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 12:58:44 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:1136 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbXGXQ6n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 12:58:43 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1448350nze
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 09:58:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j7fqEcXN2aAsMcEpCu24f/CJPkph8v2e9AuolgAEKf7VFLsp592CNaFGH0dzO+1xa7+djbPvkR1fwBHYTj2YgHLiCbI0CKDJ1mJwJ4I3lIZTLZnav6l4x0HsQ02a6uwa41vNuuqUoebqoEerbmxmC+gsrCqkfaECy7kq9AuCb6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fg9r8ApDXEyV0XXdI+aSbMo3VFn3vbMrYoabS5CCQFJ+tbtQWZko4byfhMCZyqwzNVjiOtNEJu+41O5A136hZmaBrg4DiRBmx5O1oDB1ve/4Xw97lCJACsDorUMa3d1lG2RaAQmBNeMoXfcu1429QPnXNOPke7Z2h0pPrUZv5tI=
Received: by 10.142.100.1 with SMTP id x1mr346468wfb.1185296322242;
        Tue, 24 Jul 2007 09:58:42 -0700 (PDT)
Received: by 10.143.19.17 with HTTP; Tue, 24 Jul 2007 09:58:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707241025450.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53613>

With

On 7/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 23 Jul 2007, Benjamin Sergeant wrote:
>
> > - Sorry for the noise if this has already been reported.
> > - It's on a Mandriva Spring machine with git 1.5.0.4
>
> That is really old.  Could you try with a newer version?  I do not
> remember off-hand if we had fixed such a problem.
>
> Ciao,
> Dscho
>
>
