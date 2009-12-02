From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH v2 0/6] add support for git send-email
Date: Wed, 2 Dec 2009 22:35:31 +0000
Message-ID: <b0943d9e0912021435k6d19dc1crfa9c6865217a4973@mail.gmail.com>
References: <20091202003503.7737.51579.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Karl Wiberg <kha@treskal.com>
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:35:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFxnO-0002X4-84
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 23:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835AbZLBWf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 17:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755834AbZLBWf0
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 17:35:26 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:47887 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774AbZLBWfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 17:35:25 -0500
Received: by fxm21 with SMTP id 21so865501fxm.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 14:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=fICAB+uGBILrbB+jEo2tMkPBqna3gAWwbksASVg9BRI=;
        b=T0JaDWSjlHTr7l9hwoA+UzEgEubfFHJDpBSgnJWzrMGcKNc5AnuWUud2algwLuwrWP
         BKz+KJCAj17lKGyUovYwdgabxDbwUbwPjEGDbcHuYn3IU0aYZJuRsnZzOoVkJ9lXNcxP
         s3xyuEvnYN/6GFxCctUP+c90u7rRTL/orPuqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=p7EylKE/6fPmi0RDwGtuMnpAF7ZNF+jIlQvQE9SAgVYyIRCHVGB8BkJCJQG57gy8x6
         uc5lKCnGli1X1GIrD3qFKPC3+sO+jqsrNzs9GoNJ8QDr6V36z7hKNF4Wr8CjYFstW7ZX
         s0RJvyNjwBWiHEAj/ASF+ncwntggrBNanLly8=
Received: by 10.223.4.27 with SMTP id 27mr124193fap.48.1259793331267; Wed, 02 
	Dec 2009 14:35:31 -0800 (PST)
In-Reply-To: <20091202003503.7737.51579.stgit@bob.kio>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134410>

Hi Alex,

2009/12/2 Alex Chiang <achiang@hp.com>:
> This is v2 of the series that starts teaching stg mail how to
> call git send-email.

Thanks for posting these patches (and thanks to Karl for reviewing
them). I don't have much to comment (Karl did the hard work here) but
I'll give them a try tomorrow and let you know.

Thanks.

-- 
Catalin
