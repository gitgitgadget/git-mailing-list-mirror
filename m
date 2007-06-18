From: Sergey Yanovich <ynvich@gmail.com>
Subject: Re: git tool to keep a subversion mirror
Date: Mon, 18 Jun 2007 09:42:36 +0300
Message-ID: <4676295C.1050603@gmail.com>
References: <11821061823423-git-send-email-ynvich@gmail.com> <vpqhcp6b85c.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, normalperson@yhbt.net,
	Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 18 08:42:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0AwF-0006pw-RW
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 08:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbXFRGlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 02:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756663AbXFRGlo
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 02:41:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:21985 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785AbXFRGln (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 02:41:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1356298ugf
        for <git@vger.kernel.org>; Sun, 17 Jun 2007 23:41:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QE+jjZB0cPt0OcOKjK9kV8ZryB97FHOtZtB/+tVnWqLcUC1TbGap0RyIocp38JHACycsWucJ71v9NNPndpEI01WkQzSIlWeMK8emqhezZ6a3HLecTY9jcaUNftQm9ogIH89h0KiUwKBzALbLNf5+mxwS1FW/pNSU+SM5MEn1aGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=M99TBe65N1bh6+mp5pEGG9s0cFSPoDDL8j0YY1uT/sVxR61RAgSueBV2oZPQbNyFlLdFsyMCuktXHSIHsnJ88JxQYlFw5wbeK01dNyXMbTfWLB7UppOSehnvQq6I6zLFtokw2rDtnRP0hg0mhnQTigTzOCOFM6nXwRnlJFERQ1Q=
Received: by 10.82.136.4 with SMTP id j4mr10528520bud.1182148902277;
        Sun, 17 Jun 2007 23:41:42 -0700 (PDT)
Received: from ?10.20.89.161? ( [212.98.161.164])
        by mx.google.com with ESMTP id 34sm3258864nfu.2007.06.17.23.41.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Jun 2007 23:41:40 -0700 (PDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <vpqhcp6b85c.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50385>

Matthieu Moy wrote:
>> which is corrected by an attached patch.
> 
> I believe you forgot it then ... ;-)
> 
Absolutely right. Forgot to add a dir in the end. But I noticed that, 
and send a catch-up:

git-send-email --to git () vger . kernel.org --to normalperson () 
yhbt.net --chain-reply-to --subject "git tool to keep a subversion 
mirror" --compose --in-reply-to 11821061823423-git-send-email-ynvich () 
gmail.com /tmp/out/

Here, I replace @ with ' () ' in the above for some anti-bot protection.

However, '--chain-reply-to' seems to have failed. The patches (2 of 
them) came as top-level posts. Or I may be doing something wrong.

--
  Sergey Yanovich
