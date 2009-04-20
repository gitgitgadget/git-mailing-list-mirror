From: David Miller <davem@davemloft.net>
Subject: Re: [ANNOUNCE] GIT 1.6.2.4
Date: Mon, 20 Apr 2009 01:06:57 -0700 (PDT)
Message-ID: <20090420.010657.07011402.davem@davemloft.net>
References: <7v4owklyvx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 20 10:08:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvoYT-0007AI-Si
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 10:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbZDTIHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 04:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbZDTIHH
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 04:07:07 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55357
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750755AbZDTIHG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 04:07:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 43C5BC8C0DE;
	Mon, 20 Apr 2009 01:06:57 -0700 (PDT)
In-Reply-To: <7v4owklyvx.fsf@gitster.siamese.dyndns.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116944>

From: Junio C Hamano <gitster@pobox.com>
Date: Sun, 19 Apr 2009 21:42:10 -0700

> The latest maintenance release GIT 1.6.2.4 is available at the
> usual places:
> 
>   http://www.kernel.org/pub/software/scm/git/
> 
>   git-1.6.2.4.tar.{gz,bz2}			(source tarball)
>   git-htmldocs-1.6.2.4.tar.{gz,bz2}		(preformatted docs)
>   git-manpages-1.6.2.4.tar.{gz,bz2}		(preformatted docs)
> 
> The RPM binary packages for a few architectures are found in:
> 
>   RPMS/$arch/git-*-1.6.2.4-1.fc9.$arch.rpm	(RPM)
> 
> This contains bunch of fixes that have already been merged to the master
> branch in preparation for 1.6.3.

Your GIT tree on kernel.org lacks a v1.6.2.4 tag, is this intentional?
