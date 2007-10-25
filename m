From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: git-svnimport
Date: Thu, 25 Oct 2007 14:08:37 +0300
Message-ID: <31e679430710250408g679538e7ha9e1e75507c2aac5@mail.gmail.com>
References: <31e679430710250225w39a876d0w738d819245e514e@mail.gmail.com>
	 <Pine.LNX.4.64.0710251132580.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 13:08:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il0a4-0004tw-Da
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 13:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbXJYLIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 07:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbXJYLIk
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 07:08:40 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:27881 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbXJYLIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 07:08:39 -0400
Received: by nz-out-0506.google.com with SMTP id s18so490842nze
        for <git@vger.kernel.org>; Thu, 25 Oct 2007 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=MeTiwZIfFoJVjkN0jm+cZQQ9BlMOFXfW5G3+yn7qgB8=;
        b=ZI7TdqUx68bwNOi2pMEx+Z7kZomsEnVpmFV/rOeju4kMww+EnTd1V8oo4V6dvfoFprsdZb2FhFvfw1gALmfxNNSFveXwMDu7SJNGE3cRGLN0nGONArtNZO4GQs88yC8qpeexYhvcoxLREG9iVnnU2c8Dibp5VA+BDH/w81iG8I0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XoJJUA7f07PYLf06754UFVEQhYV7EFlKD1OBzSHGIqPQ4pNHP1QxaqsPmYOhaRqDq1BTtLGgqS4o9Z8dtkEGTCts18e0c5d0G5rhTSSVKjkMZ627knwdS69GsGP54hv76ibE0CEXxhce0WQz1nmdnHrOL58tJwdQ5Z/iGymXTA0=
Received: by 10.114.77.1 with SMTP id z1mr1962939waa.1193310517910;
        Thu, 25 Oct 2007 04:08:37 -0700 (PDT)
Received: by 10.114.61.4 with HTTP; Thu, 25 Oct 2007 04:08:37 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710251132580.25221@racer.site>
Content-Disposition: inline
X-Google-Sender-Auth: 1c729de958418330
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62309>

Hi,

On 10/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 25 Oct 2007, Felipe Balbi wrote:
>
> > I was importing busybox svn repository to git but I got a connection
> > timeout after more than 19k commits... is there a way to continue where
> > the error happened or should I do it all over again ??
>
> AFAICT git-svn is better suited, even to one-shot importing svn.
>
> As it happens, I got interested in this project, too, and did an import
> some time ago.  For your pleasure, I uploaded it to
>
>         http://repo.or.cz/w/busybox.git/

thanks... much better... I'm cloning your tree and I'll merge with
current busybox tree... ;-)

>
> Hth,
> Dscho
>
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
