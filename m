From: Thomas Koch <thomas.koch@ymc.ch>
Subject: Re: Finding the name of the parent branch?
Date: Fri, 30 Jan 2009 15:26:24 +0100
Organization: young media concepts
Message-ID: <200901301526.24566.thomas.koch@ymc.ch>
References: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
Reply-To: thomas.koch@ymc.ch
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 15:53:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSukV-00074N-Su
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 15:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbZA3Ovx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 09:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754900AbZA3Ovx
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 09:51:53 -0500
Received: from hera.ymc.ch ([217.113.37.19]:44118 "EHLO hera.ymc.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbZA3Ovw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 09:51:52 -0500
X-Greylist: delayed 1520 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jan 2009 09:51:52 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hera.ymc.ch (Postfix) with ESMTP id 0BA46105869;
	Fri, 30 Jan 2009 15:26:30 +0100 (CET)
Received: from hera.ymc.ch ([127.0.0.1])
	by localhost (mail.volano.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oui3fANjFDIf; Fri, 30 Jan 2009 15:26:29 +0100 (CET)
Received: from jona.local (67.Red-81-32-182.dynamicIP.rima-tde.net [81.32.182.67])
	by hera.ymc.ch (Postfix) with ESMTP id B7314E5F65;
	Fri, 30 Jan 2009 15:26:29 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
X-Face: ##Diipbu!WHqpJ%Eb+k:m;]n%VcrM\f\MJ-:0\<0.r?ULf7g"kC!"Cg,o;D]
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107829>

Am Friday 30 January 2009 11:56:12 schrieb Pascal Obry:
> I want to find the name of the parent branch in a script. What is the best
> way?
>
>                          o---o---o---C
>                          /
>                     o---o---o---B
>                    /
>            ---o---o---o---o---o---A
>
> For B I want to get A and for C I want to get B.
>
> All this can be found in gitk, but from a script I did not found a
> good solution.
>
> Any idea?
>
> Thanks.
> Pascal.

Isn't your problem solved by topgit?

-- 
Thomas Koch, YMC AG, http://www.ymc.ch
Phone: +41 (0)71 / 508 24 86
