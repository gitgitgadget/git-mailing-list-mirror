From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add history and blame to git_difftree_body()
Date: Mon, 2 Oct 2006 21:55:23 +0200
Message-ID: <200610022155.24487.jnareb@gmail.com>
References: <20061002193217.86165.qmail@web31814.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 21:56:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUTsb-0007gA-Ke
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 21:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWJBTzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 15:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWJBTzG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 15:55:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:62131 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964931AbWJBTzD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 15:55:03 -0400
Received: by ug-out-1314.google.com with SMTP id o38so549775ugd
        for <git@vger.kernel.org>; Mon, 02 Oct 2006 12:55:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZGKjKSpthuUS/5sdb4i8QhR6ynfBPF+NSQOWurk2kpL2tPxo0pTefEk+YZBZj7AUAo+Luj8ek65acUlqnYpd8JPVH2k7061qn1jm6yRGUfV/s+c1YfRZtzJYF1rM/PVFHI9vVH36wNdYkMgxRxV66xHllMIDjEmC6hmONryZWvU=
Received: by 10.67.121.15 with SMTP id y15mr2968957ugm;
        Mon, 02 Oct 2006 12:55:02 -0700 (PDT)
Received: from host-81-190-17-45.torun.mm.pl ( [81.190.17.45])
        by mx.gmail.com with ESMTP id o30sm5473373ugd.2006.10.02.12.55.01;
        Mon, 02 Oct 2006 12:55:01 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <20061002193217.86165.qmail@web31814.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28234>

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
> > Luben Tuikov wrote:
> > 
> > > Add blame and history to Deleted files.
> > > Add blame and history to Modified or Type changed files.
> > > Add blame and history to Renamed or Copied files.
> > 
> > Blame has to be added conditionally (gitweb_have_blame).
> 
> Can you please not edit the CC field when you reply?
I do not edit Cc: field. I reply via GMane NNTP (Usenet)
interface.

> I can see that only the GIT mailing list was left,
> but my email had been removed.
It was not removed, it was not added.

-- 
Jakub Narebski
Poland
