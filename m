From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git Download/Bootstrap Suggestion
Date: Sat, 28 Mar 2009 00:21:19 +0100
Message-ID: <fabb9a1e0903271621g392eefdeu85b46c655c1ad067@mail.gmail.com>
References: <49CD0841.9000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 00:23:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnLOG-0006d2-Dx
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 00:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbZC0XVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 19:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbZC0XVi
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 19:21:38 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:9860 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbZC0XVh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 19:21:37 -0400
Received: by mu-out-0910.google.com with SMTP id g7so525660muf.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 16:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q4XXQou/2gX4EkmCyJzNUOjTFzKIgTzgcDoab1bf0OM=;
        b=Dnzkt1A24yYxD9MDn3b7ORgynq91vXM5vXfJga0MOc8Fj738Wf5LUuRmfXzPmWjYoX
         6P2IZkQHzN5FDkwQ4PIdOdSR8gDWAyxZFjijSpmcw053s+JWk/DGPi1PbJihMnbFdAt+
         no6XqdhL6bZzMCPQcIy10nYmnn7UcemDz8W0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VkLAFbsDR/gnhOFrc9LcMu5HbHTqVh58DoCcZa/+lMbkEDPrGxICZHqIPUzQoiU6TM
         a3a3wZE9CGhvmXvvV2H/O9ba7PsCFai9j+XqHVBYqMkxlYiuzJ109XsGBEb6CcFSKcya
         r1BUzGf5FX8CzVdJrlFpqPaN1Op9R0ChbURsM=
In-Reply-To: <49CD0841.9000602@gmail.com>
Received: by 10.103.49.12 with SMTP id b12mr666897muk.98.1238196094721; Fri, 
	27 Mar 2009 16:21:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114926>

Heya,

On Fri, Mar 27, 2009 at 18:09, Mike Gaffney <mr.gaffo@gmail.com> wrote:
> I have to do is
> - download the source tarball (or the rpm)
> - make it
> - install it

Nah, you don't need to do all that ;).


> It'd be a lot cooler if I could just wget a full get repo on the latest tag

You mean like, this?

http://repo.or.cz/w/git.git?a=snapshot;h=master;sf=tgz

-- 
Cheers,

Sverre Rabbelier
