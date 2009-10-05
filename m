From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Teach 'rebase -i' the command "amend"
Date: Mon, 5 Oct 2009 11:39:56 +0200
Message-ID: <fabb9a1e0910050239h614118cfw8a5055e4ed966dd1@mail.gmail.com>
References: <4AC8F22F.5070101@gmail.com> <alpine.DEB.1.00.0910042308200.4985@pacific.mpi-cbg.de> 
	<6672d0160910042308v7280dcadyff97b977bcfe12c3@mail.gmail.com> 
	<alpine.DEB.1.00.0910051116480.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 05 11:45:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muk81-0002HY-U7
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 11:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758746AbZJEJkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 05:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758722AbZJEJkz
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 05:40:55 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:38167 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758750AbZJEJky (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 05:40:54 -0400
Received: by ewy7 with SMTP id 7so3296956ewy.17
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=xLNPXHm7WnCP/D55zmp2AMUXOA1fcCqTBO70xmai/Mg=;
        b=HFZlkALq8Fa9WrU2npbYvZc/S9w2d2ecysh2knLgLjBFoZg6+xVRsOxjlDdwPY0BdW
         5Jkn/H+jSCOcGudiNxFyeC2GzOY3UqkDtTa/sh0oqCtKLzrhHycpcHuVMRPlwpn89Kwu
         KWIDjaWBTO5dh9NDq27Ew8H+HJ50yd3zHaVb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=akBcF/SjQ9aG++GbN84PM3hl7pajwUJ+jSiCYEvg/IlUifIYmyr6EdJEBjO7A5YV3g
         V+HrKBnrsnv9YxoyuTcFypn8CqVhQptmTBlu5OyMYvLxlVyZ7ToX5agX88dd4oRhcThT
         BPQ7aetJ5fypeV6DaGgYxclu7csBaXLCV9MNM=
Received: by 10.216.8.5 with SMTP id 5mr671511weq.181.1254735616127; Mon, 05 
	Oct 2009 02:40:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910051116480.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129544>

Heya,

2009/10/5 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> My objection was that the "upcoming" (yeah, Sverre, I am imitating Duke
> Nukem Forever here) "merge" command would clash with "msgedit", which was
> why I suggested "rephrase" (but would be okay with "reword" Junio
> mentions).

I also dislike 'msgedit' because it's abbrev-ed, I would prefer
"reword" for that reason.

-- 
Cheers,

Sverre Rabbelier
