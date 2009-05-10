From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: questions about git-mktree
Date: Sun, 10 May 2009 11:27:19 -0400
Message-ID: <4A06F257.4030308@gmail.com>
References: <2cfc40320905100641v3e8742c4v1d0e1091a730970b@mail.gmail.com> <20090510151200.GA10189@pengutronix.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>, gitster@pobox.com,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sun May 10 17:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Aw5-0004JW-3x
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 17:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbZEJP1V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2009 11:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754743AbZEJP1V
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 11:27:21 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:52623 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbZEJP1V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 11:27:21 -0400
Received: by gxk10 with SMTP id 10so1730900gxk.13
        for <git@vger.kernel.org>; Sun, 10 May 2009 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wI1Sh9lr8aQHLWkb6RDEFMDAKQ6PVM4lBks2c2SL9b8=;
        b=MPmGDJxlJOQatp0YhhhqzOOYGr/ZKpqoxDReP+8U0DvJtXdyP6qed0YbEmf9daU0FX
         djgfM4rMG8c2usEKww3aWUIHHCe//0ChPzmSWU0BQojXtdIWk2PGWURkWbk+jvVmDKKc
         6gAu7dDj5/ZXzyDROlGAILf1ZtVDWHJob1bnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=ZiAw9gWc/yGn8YweWbaacAQLCJUyhxZepCMGQ7f+4f7RDXDwz1bUYnLjL5vTqT/6sr
         cM4+v3i+IM0zhqvh3DFLrms7ywWGmVMzzDleqhAahfJvfFcV0CHRMAyYWUlPrBn04+1/
         nTTqXLIGh+QrdmnxSboTP1U9pEDbrbTI5SYUM=
Received: by 10.90.65.5 with SMTP id n5mr5255887aga.11.1241969241187;
        Sun, 10 May 2009 08:27:21 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id 29sm5221972agd.41.2009.05.10.08.27.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 May 2009 08:27:20 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20090510151200.GA10189@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118722>

Uwe Kleine-K=F6nig wrote:

> As git-mktree doesn't exists I cannot answer that question ...

http://kernel.org/pub/software/scm/git/docs/git-mktree.html
