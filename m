From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Git: relicensing test-lib.sh from GPLv2 to GPLv2+
Date: Fri, 2 Apr 2010 10:52:08 +0200
Message-ID: <20100402085208.GA26658@localhost>
References: <87r5oqe7mi.fsf@yoom.home.cworth.org>
 <871vgmki4f.fsf@steelpick.localdomain>
 <7vaav8hpfo.fsf@alter.siamese.dyndns.org>
 <87tytdiqob.fsf@steelpick.localdomain>
 <alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
 <873a0xhwxs.fsf@yoom.home.cworth.org>
 <alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
 <87eikfhec1.fsf@yoom.home.cworth.org>
 <alpine.DEB.1.00.1002202321430.20986@pacific.mpi-cbg.de>
 <87pr2i8g8o.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Fri Apr 02 10:53:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxccm-0002l7-DW
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 10:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab0DBIxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 04:53:04 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35331 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab0DBIxA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 04:53:00 -0400
Received: by bwz1 with SMTP id 1so1375631bwz.21
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=pr5puPNuGybOQ/I/d5J8RN4wb5IeCwofDqQNBFPMvUU=;
        b=SYiRHCwRC0EO48MLbUxlAiOaOLz5Bjoq/nLucgLuN9YDlq59l5NFbs0ss8GJ6g6RhG
         yTfWHPBamE38FlmiRQBbw7jUDd/PjuzlnTUwpb6syDdzUpQiA7gZnPUkw9Xa2k6BWq34
         Nl1X3piQdNGf+dd4RcT5JMhEZrRYunI64bTcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Fz+//AXRT1IkZKdPmYCX6FDC4eOZ44V1K8BE6bGTzqNygxbM+LBqVAYW/PGXM++KMU
         6v5KcozrhecRnTot1PG5ijrsE+pEp+MvkXuoO2j25Q9uOfdlwZi3eESL63AjnLYL7ELt
         vbbrUIULJXhCqkfwvhfPuxZcfkRUyzREg+GIw=
Received: by 10.204.152.24 with SMTP id e24mr2416960bkw.186.1270198378815;
        Fri, 02 Apr 2010 01:52:58 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 14sm4451842bwz.10.2010.04.02.01.52.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Apr 2010 01:52:57 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Nxcbo-0006xO-Dp; Fri, 02 Apr 2010 10:52:08 +0200
Content-Disposition: inline
In-Reply-To: <87pr2i8g8o.fsf@steelpick.2x.cz>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143801>

YES, I agree to relicense all my contributions to test-lib.sh to GPLv2+
with the addition of the "or any later version" clause.

Clemens
