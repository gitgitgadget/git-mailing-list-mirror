From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Teach "git reflog" a subcommand to delete single entries
Date: Wed, 17 Oct 2007 11:24:50 +0200
Message-ID: <09CDCBB0-35F1-429C-8470-6020D481F452@wincent.com>
References: <Pine.LNX.4.64.0710170249260.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 11:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii59s-0003i3-Cm
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 11:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbXJQJZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2007 05:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbXJQJZa
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 05:25:30 -0400
Received: from wincent.com ([72.3.236.74]:54512 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213AbXJQJZa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 05:25:30 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9H9POpL017072;
	Wed, 17 Oct 2007 04:25:25 -0500
In-Reply-To: <Pine.LNX.4.64.0710170249260.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61356>

El 17/10/2007, a las 3:50, Johannes Schindelin escribi=F3:

> This commit implements the "delete" subcommand:
>
> 	git reflog delete master@{2}
>
> will delete the second reflog entry of the "master" branch.
>
> With this, it should be easy to implement "git stash pop" everybody
> seems to want these days.

Looks good to me. Thanks for taking the initiative, Johannes.

Cheers,
Wincent
