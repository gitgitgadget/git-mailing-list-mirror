From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [PATCH] Remove link to the survey from the git home page.
Date: Thu, 18 Oct 2007 14:25:15 +0200
Message-ID: <2c6b72b30710180525s3924c720rb7cb715dc7b43c3b@mail.gmail.com>
References: <20071016235714.190672ff@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pasky@suse.cz, git@vger.kernel.org
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 14:25:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiURN-0005Uy-Nd
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 14:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbXJRMZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 08:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756545AbXJRMZR
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 08:25:17 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:34103 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328AbXJRMZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 08:25:16 -0400
Received: by rv-out-0910.google.com with SMTP id k20so140865rvb
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=u2nzEhtQSyBei4R+2rwJyVUNwwcDmC563f94tmB43RI=;
        b=lVSQ2umF11J3RWTGjmoJHVlSJo3+y8D8hbKPRpkud0O6g2G5oevxCAB0jgfptSwexApL6t1fAgfE9ghBI00hzOw7e4W558V+0ZNkh7d25IboX8oXjoIg+87O6NBGV4alsPX6ik0aFm11thHmy51QgDHjFumE2K5Z0Tzeal2mgV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FT3DLHogtfhMmPLFOqqYZCWNvnj2SoMLsu+R77ajZ5izrlUyBzQ2Y4lWGKMYNAO6k6BnT+4zlX7yvXD21OYR60HjDqZVCJ5QXKF63bOT31TBZZs/c76TMvDmaN865af9dfmmfHQ95HtpD7f0lYlY2Cx3ZhKOcY0JeaHqgFdcdfU=
Received: by 10.141.87.13 with SMTP id p13mr243155rvl.1192710315672;
        Thu, 18 Oct 2007 05:25:15 -0700 (PDT)
Received: by 10.141.13.18 with HTTP; Thu, 18 Oct 2007 05:25:15 -0700 (PDT)
In-Reply-To: <20071016235714.190672ff@paolo-desktop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61523>

On 10/16/07, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> As far as I know the survey is close so it makes sense to remove the link/text from the home page.

Pasky has provided me with write access to git-homepage.git and to test
the setup I have applied this change, which seemed to have been overlooked.

Pasky, maybe you can update git.or.cz and perhaps also remove the link
from the front page of repo.or.cz? :)

-- 
Jonas Fonseca
