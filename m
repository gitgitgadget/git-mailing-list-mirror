From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #01; Wed, 07)
Date: Thu, 8 Oct 2009 08:49:32 +0200
Message-ID: <fabb9a1e0910072349q68d6756cgebb041a0bbe2ba65@mail.gmail.com>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910080848380.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spearce@spearce.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 08 08:53:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvms5-0004NV-HO
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 08:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbZJHGvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 02:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbZJHGvA
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 02:51:00 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:47862 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbZJHGu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 02:50:59 -0400
Received: by ey-out-2122.google.com with SMTP id 4so1186815eyf.19
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=I4xROBOE8Q/yz4U5QPS6OVCQINv2ACxFsmev3BvvC28=;
        b=OsF2MDGGZvvShIYMTPSBBz2jK5cUGWVjaKIIPGuUlkPUQMi0TZzKwWWQra+0QxRRm2
         mX6zxBhaGKsm3+maUW4mme5Cv/M3h6jZ1r9YfYGiPjvA5MwxJ2k5hZ8OKYu7ueaBRP+M
         n9CIcKNbE9MMYCvoqvHtifJxEmJLcPkmV0e4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eQ7irOumjcWK/LQ10Lnk81jgWV0uk8Cpy6+YSj62/c/Iv0yo2/ooWJKDsklsKtRCQH
         0Bdem3kYSEja8kH2g3aOosxF5BzWX8hB7LXy+ueybrjF1pcYiTNGzwzvZTg3ZhRBrHQZ
         5tj7j/Ur50Ud9jan1eUii40+40ZPrpuptcSrQ=
Received: by 10.216.86.139 with SMTP id w11mr270124wee.10.1254984592141; Wed, 
	07 Oct 2009 23:49:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910080848380.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129677>

Heya,

On Thu, Oct 8, 2009 at 08:49, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Shawn, last time I heard of this issue, it was stuck in your review queue.

Correct, am waiting for Shawn's decision on whether to drop options
and replace them with additional features or not.

-- 
Cheers,

Sverre Rabbelier
