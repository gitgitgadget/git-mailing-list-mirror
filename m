From: Mohit Aron <mohit.aron@gmail.com>
Subject: Re: git push should automatically push to remote tracking branch
Date: Sun, 18 Oct 2009 20:50:57 -0700
Message-ID: <ee22b09e0910182050k55efac83v6799285d992fcbb0@mail.gmail.com>
References: <ee22b09e0910181320j15a273e8vc510801c890b93a9@mail.gmail.com>
	 <1B59440B-5929-4AB9-82C7-05188DC4F959@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 05:58:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzjNi-0004u3-CX
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 05:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879AbZJSD5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 23:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbZJSD5t
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 23:57:49 -0400
Received: from mail-px0-f171.google.com ([209.85.216.171]:55327 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770AbZJSD5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 23:57:47 -0400
Received: by pxi1 with SMTP id 1so83171pxi.33
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 20:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=eP3ZvB5dY13+qzGDaDrISWHGKllbNqR76nCwgPvtHl0=;
        b=IBo002VwppLZq9XbFsVYZ1Ebowfm14Uhk+ID3UGzlNNvG0Cu84uG1oaNyeI8GE2Me6
         J68suVMaO7v+U5AQztsrcJvqbJonef+v1ed+Cx2uPp6uJw/M1hsrIQlEgKPVxSZ93gW/
         ShdzvtqQfgsokr19lopZOLyXWHlHbzGAlJxqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=EbvfI1GjFYI7D3TQmzwpf9xg7n8uJW7HvMFglZqfvTPFG2F+7rhxXQ7jPn0smUhMNa
         TCiz2yCGHUczYpEJaN4DzFxRpd+PMADHySHQeEzQfwYD7gM+hxqecH6ZX1oXjk2uRDA5
         8/osto9eixuetZVonxL3ofedXZKJNK6fZCtzg=
Received: by 10.115.80.6 with SMTP id h6mr5142451wal.108.1255924258016; Sun, 
	18 Oct 2009 20:50:58 -0700 (PDT)
In-Reply-To: <1B59440B-5929-4AB9-82C7-05188DC4F959@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130644>

Thanks - I suppose this is a new config option. I'm running Git
version 1.6.0.4 (the latest with Ubuntu Jaunty) and that doesn't seem
to have this option.


- Mohit

>
> $ git config push.default tracking
>
> tom
>
>
