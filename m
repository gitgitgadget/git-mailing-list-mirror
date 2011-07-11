From: Steve Muadib <s.muadib@googlemail.com>
Subject: Re: repository in different directories
Date: Mon, 11 Jul 2011 15:44:56 +0200
Message-ID: <20110711134456.GA45560@sherwood.local>
References: <CABU6SG5uLXAsu0yXa1cmPAmte3WnsjaHN0r_D4c8C7W2tKJDHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Carlo Trimarchi <mr.spoon21@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 15:45:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgGnW-0001FV-PJ
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 15:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567Ab1GKNpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 09:45:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48968 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab1GKNpE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 09:45:04 -0400
Received: by eyx24 with SMTP id 24so1351470eyx.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gf5Db47BG5nlfn8Evor1NcKalbZZaNMsZKnHu+5OzOo=;
        b=iQWdaM5kO55si91Sac4HSKKxN5ZK9nfmloHzqHt2b+0KfjYenOFkSxUn3t/JQF6a0D
         4STeyuhG1uHo7VmmW3aV98D0o8bNyC83kam+vsY6gW3KSf+M/n6dKRcl7pRLUp5HJ4Ps
         MKrJlzPCv5J2OF6dYrr9USnzoL9efIr/mGjRs=
Received: by 10.14.17.138 with SMTP id j10mr603417eej.75.1310391902439;
        Mon, 11 Jul 2011 06:45:02 -0700 (PDT)
Received: from sherwood.local ([82.113.99.176])
        by mx.google.com with ESMTPS id f6sm1141410eef.34.2011.07.11.06.45.01
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 06:45:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABU6SG5uLXAsu0yXa1cmPAmte3WnsjaHN0r_D4c8C7W2tKJDHw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176840>

# Carlo Trimarchi <mr.spoon21@gmail.com> writes:
> Is there a better or a good way to do all this?
> 
> Thanks,

Yeah: use static webpages without images. :-)

Ah, and for wrong: how about using one repository and setting up
a commit hook to move files to final places?

Regards...
