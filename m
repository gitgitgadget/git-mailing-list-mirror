From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: sr/gfi-options, was Re: What's cooking in git.git (Aug 2009, #04; 
	Sun, 23)
Date: Mon, 24 Aug 2009 12:44:18 -0700
Message-ID: <fabb9a1e0908241244y74bbb33fh8d7d9c28ec2324e1@mail.gmail.com>
References: <7v1vn2qb29.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0908241641390.11375@intel-tinevez-2-302> 
	<fabb9a1e0908241145p2a1fe59fgef42a4c46209f154@mail.gmail.com> 
	<alpine.LNX.2.00.0908241456400.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 21:44:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MffTH-0000sx-VP
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 21:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbZHXToh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 15:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbZHXToh
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 15:44:37 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:20374 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbZHXToh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 15:44:37 -0400
Received: by ey-out-2122.google.com with SMTP id 22so683570eye.37
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=N6owKyK+jnFAoL6/TjnwS+O0dtURmhm3wPfMCPI2vCw=;
        b=OjZ292NXCNH9L8bjEtjwp/QG3FNIC35uokGngK51AUrfPHUYx3hZRKybLacFmgMO04
         hjEEyh54jpsgEdm9GP5jHTfnEH7UrAen3fRbnPX4I/5wpwljE6ftk9MtvLEQybfUjUP2
         RksE73YtAdvKJaVMY4KukEOrTrAunWJt8gx4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=w9CB7XJaIgJBIAfzEHdNenpgyvsTt+9JPf4BtAg05/qCLy31usvle6XxZoUcepR1X7
         +1p8mEaFbHXh3kTLhHvwcXyyV3Ahjh7nKHXtUgL81t8Fw2T8asjdSTYbbMx4Kfb4UslP
         MTXFdq4u3BlbtTNyGzGqtPvMUpv3oSVVXGU3o=
Received: by 10.216.71.13 with SMTP id q13mr1073396wed.190.1251143078134; Mon, 
	24 Aug 2009 12:44:38 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0908241456400.28290@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126962>

Heya,

On Mon, Aug 24, 2009 at 12:09, Daniel Barkalow<barkalow@iabervon.org> wrote:
> Nope, I didn't actually need it. I think the cvs helper wants it, though,
> since that is using the marks file.

Ah, that's right, the p4 helper uses a python script (like mine), and
the cvs helper uses a marks file (like mine). I got the two confused
:).

-- 
Cheers,

Sverre Rabbelier
