From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Initial Italian translation of git-gui.pot
Date: Sun, 22 Jul 2007 14:11:51 +0200
Message-ID: <4d8e3fd30707220511s3f9ee1dfu4b24b0a6d9949ebe@mail.gmail.com>
References: <20070722124236.47baacb1@paolo-desktop>
	 <Pine.LNX.4.64.0707221255260.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 14:12:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICaID-0003he-6J
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 14:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759259AbXGVMLx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 08:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757535AbXGVMLx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 08:11:53 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:2231 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261AbXGVMLw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 08:11:52 -0400
Received: by py-out-1112.google.com with SMTP id d32so2754001pye
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 05:11:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fwLVE3GdywwT/6RnYYEGb7BNnUR9niHom3xg8+wASihjDio4Wu6P1FKYqUX0sJW8PQLONBXY2HLGTC+1je3GVgLO/X/+l3OXDWHBvDYjQFBDr0x04YBvzgadQ/atCdW3OM8Dnzv9nG9oNvSIO+S+gV4OK/6B25mu1Qdd/KyRtBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sVrcBe3HwYEQo9Au+U2ihqii6Y2NxfbJ02EZ9MAmNWW2Tg+50vi0QZdfqWkD9wULyBIexDOPKyni4RpDlqie5rRRCKoGpVw/S+Q3U48HT+TGyneLAKeU+OdyRIiYQHL3JmEF7O4OwlLvtXcgUr7wFLIstsPQYcpBdu9FxgH3VCk=
Received: by 10.143.161.3 with SMTP id n3mr154114wfo.1185106311428;
        Sun, 22 Jul 2007 05:11:51 -0700 (PDT)
Received: by 10.142.86.9 with HTTP; Sun, 22 Jul 2007 05:11:51 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707221255260.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53256>

On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 22 Jul 2007, Paolo Ciarrocchi wrote:
>
> > Initial Italian translation
>
> Thank you very much!  I took the liberty of squashing your 3 commits into
> one ;-)

Yeah, I was writing you an email suggesting to at least merge my
latest patch into the previous one.

Out of curiosity, how did you merge my 3 commits into one? (I'm really
a newbie).

> I see that 5 translations are missing:
>
> Commit, Checkout..., Unstage From Commit, Sign Off, Apple
>
> I guess that "Unstage From Commit" needs to be translated, but that you
> wanted to keep the others as-English, right?

Yes, I even translated a few words that I think should remain in English.
I FWed my patch to my local LUG, I'll collect some feedback and post a
followup patch.

Ciao,
-- 
Paolo
