From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git to libgit2 code relicensing
Date: Sun, 16 Nov 2008 22:09:25 +0100
Message-ID: <bd6139dc0811161309t652d3ed2gb9aaae637ee91504@mail.gmail.com>
References: <491DE6CC.6060201@op5.se>
	 <200811151615.42345.chriscool@tuxfamily.org> <49200914.6090506@op5.se>
	 <alpine.DEB.1.00.0811162159280.30769@pacific.mpi-cbg.de>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 16 22:10:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1otO-00076e-TP
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 22:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbYKPVJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 16:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbYKPVJ1
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 16:09:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:61565 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYKPVJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 16:09:27 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1852584fgg.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 13:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2GXOecyc6IunVz1BdfcrEdJ83IJpfxKT/DGK+33/268=;
        b=DuRhVjQKp///YlOquWTGW84s8WX1jEMfhJCvYoq5+E/t7qBlYRtdgGaPSce9Imr+Q+
         dSIEGcBDJtVq/vuYKY4flBI9wn7ZG4ZJ8cWSYXcT3hx1r8t6C7eH6mayWStVMzJitw+a
         VsBQU8k/4F/Pba0C2/5Wsdcvafmvaqj6CJR+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=DSH9lreI8JD6LqaXQQZRXZSUWHMcNBFb/HSgbQIbETuE/KU8BRCyyk6FxkjIl2a/z1
         77uow3QE9YXB79MeASBhcF2Ll5ci95B+oFYUmL/fqmvHk0549iomzxwQKA1p8IVVE3Pg
         e0UR/tc6wJodnMX0z79uxFMuwrJAoKQSN4atk=
Received: by 10.187.198.8 with SMTP id a8mr375983faq.4.1226869765169;
        Sun, 16 Nov 2008 13:09:25 -0800 (PST)
Received: by 10.187.213.8 with HTTP; Sun, 16 Nov 2008 13:09:25 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811162159280.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101160>

On Sun, Nov 16, 2008 at 22:00, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I doubt it.  Most of that code was written with the execute-once
> mentality.  And with the we-have-posix mentality.
>
> Two things we do not _want_ in libgit2.

But at least with permission from the authors we're allowed to look at
the original code without preventing us from licensing the new code as
GPL+exception ;).

-- 
Cheers,

Sverre Rabbelier
