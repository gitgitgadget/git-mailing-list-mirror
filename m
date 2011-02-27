From: Aghiles <aghilesk@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 27 Feb 2011 16:16:40 -0500
Message-ID: <AANLkTik3rV6vejf=aRvysvxr4qn_UJxUqiQiTB0AG-vp@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org> <4D589CE0.7020203@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 22:17:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtnzK-0007et-Cv
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 22:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab1B0VRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 16:17:04 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52209 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab1B0VRC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 16:17:02 -0500
Received: by eyx24 with SMTP id 24so1119026eyx.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 13:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=i5sTHTajuTAaeHyy8Z7h+N7GjTzBYBwgySLVClsObzM=;
        b=idt/VLXG5jPdEKBIpRd/Ef7JdjoScxn5d0ofh0TI12HnAdzwe8pthM0B1gInHVMBSN
         xbGA1xiYy5UO3fZ0ddTy7FfnbwlS2w9DBk5Ml5oMbBvjh7XW95jc3kQdI+2N6w5vq/za
         iY7VsqWWqM/RFwUiX4nu0rGrA5zow91tpIR44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KeK+3/VD/gp+3ql19vL63zhLpn2AtJgXvsU1nY2H82A+PV50oEJnesCWwrBydCDzwj
         NARqe1EZ5Bs3d55rECmKJOzq398On4rNmNQP1EiEFQG8ldMD2kNKTMHM7X8tgk31+/lz
         e3ZuBIie1pgjZgHVustc+P2ZsCI+ZM4fPbyz4=
Received: by 10.213.29.16 with SMTP id o16mr3432075ebc.78.1298841421098; Sun,
 27 Feb 2011 13:17:01 -0800 (PST)
Received: by 10.213.20.5 with HTTP; Sun, 27 Feb 2011 13:16:40 -0800 (PST)
In-Reply-To: <4D589CE0.7020203@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168055>

> FWIW, when teaching Git I have found that users immediately understand
> "staging area", while "index" and "cache" confuse them.

FWIW, same here.

-- aghiles
