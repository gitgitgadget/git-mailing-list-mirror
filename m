From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and  Mercurial
Date: Sun, 26 Apr 2009 12:16:58 +0200
Message-ID: <200904261216.58444.jnareb@gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org> <4d8e3fd30904260123r35b6a348uab3ad22fde9daa3f@mail.gmail.com> <alpine.DEB.1.00.0904261206170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 26 13:30:24 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly1RZ-00039O-Br
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 12:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbZDZKRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 06:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZDZKRG
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 06:17:06 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:64694 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbZDZKRE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 06:17:04 -0400
Received: by bwz7 with SMTP id 7so1782047bwz.37
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rEjkWvGiBanVKqQQNW4IF/rUNWg+9mtjIPqbc9WqDLI=;
        b=fxNZnx5EPNZRhkmuOi22NdTzvg23Om8pMcNu/JdiH+FaIzFzhTmtOrcquyfOBlAzXu
         n+9JPXFNVNzpzk40ne5FQdGZZqRigJb7e5m/SG1d32avPqR09FtYoC7lrc3w84yNy8mt
         bHFKdykCUT/gkXYRDeLu5EcUU2hn+afpgQHA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GQPpE9fuN5IlOr4mEAoU6Uz6/+QGzrIECR6AfTdfOZCn3x5raY6QK4+9ttF6b+TzIa
         Otd3QXTG2BEfFfNt9YE44DglKyvdzOXNFGApDRHmvoymCersWOlFNVpL0yPmg660rbIq
         m5RBt6mcJ1BsS79YtcIvdZ/eOvna+0QvVujsQ=
Received: by 10.103.228.7 with SMTP id f7mr2448888mur.130.1240741022031;
        Sun, 26 Apr 2009 03:17:02 -0700 (PDT)
Received: from ?192.168.1.13? (abwp56.neoplus.adsl.tpnet.pl [83.8.239.56])
        by mx.google.com with ESMTPS id 25sm8925944mul.57.2009.04.26.03.17.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 03:17:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0904261206170.10279@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117587>

On Sun, 26 April 2009, Johannes Schindelin wrote:
> On Sun, 26 Apr 2009, Paolo Ciarrocchi wrote:
> > On 4/26/09, Jakub Narebski <jnareb@gmail.com> wrote:
> > 
> > > The deciding feature (well, one of deciding features) was the fact
> > > that Mercurial has better HTTP support... I guess (it was not obvious
> > > from the analysis, but it was hinted at) that Mercurial uses its
> > > custom protocol over HTTP, as opposed to "dumb" HTTP protocol support
> > > in Git.
> > >
> > > Perhaps it is time to restart work on _"smart" HTTP protocol_?
> > 
> > wasn't Shawn working on it?
> 
> GIVE HIM A BREAK!
> 
> Isn't Shawn doing enough for Git?  No need to offload the stuff on him 
> _that you could very well tackle yourself_.

It is a bit pity that we don't have "smart" HTTP protocol as one of
git projects for this year Google Summer of Code 2009.

-- 
Jakub Narebski
Poland
