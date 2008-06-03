From: "Matt Pearson" <404emailnotfound@gmail.com>
Subject: Re: Pushing an --amend-ed commit
Date: Mon, 2 Jun 2008 20:22:44 -0400
Message-ID: <706b4240806021722k2d15a4e9offa4d513a4ba6106@mail.gmail.com>
References: <6B355924-0EA9-4AF8-B051-F17FC4530495@manchester.ac.uk>
	 <706b4240806021708u4ade0f9ake53e26f53e34d97d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Robert Haines" <rhaines@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Tue Jun 03 02:23:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3KJQ-0004Hr-1I
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 02:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbYFCAWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 20:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753995AbYFCAWr
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 20:22:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:30734 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbYFCAWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 20:22:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so651576ywe.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 17:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HjOLrHNcDZQ7fSRGu0u+r4o46iJfCkncP0v1BPjw3S4=;
        b=JC45xXPDRSfrNcZioBV7pwoaunf4xQopgfGcTRr/bREq0CCL9Zx+CyWRj3ERPWgwHhPauY3+Dzzu9XsYowsA/KHwkXsG/OkqOCaY3WUWWR2e64TZS+DroWHBs/pOs/yqb29CRA9gbG3y2bnCSnPsp7HGKLl1eM6l8TB7xkTraB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fihKmWwJUSDHosvdgdeHlcXl2fJ18PFzss/BJzVUSjsl2gYtX0YRfMGzHzGsdE23oFmeJ+usn8WD5TmYDOJ0Yj6dIclc/UQg2iijm3x4U43SPU6ek032LWf9M7upgayGH63Ij0GGqUfMYHXZxJ2cV1JEWaFI2Rr9XW6rmjiTxAQ=
Received: by 10.151.49.8 with SMTP id b8mr5812415ybk.82.1212452564253;
        Mon, 02 Jun 2008 17:22:44 -0700 (PDT)
Received: by 10.150.52.8 with HTTP; Mon, 2 Jun 2008 17:22:44 -0700 (PDT)
In-Reply-To: <706b4240806021708u4ade0f9ake53e26f53e34d97d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83601>

On Mon, Jun 2, 2008 at 8:08 PM, Matt Pearson <404emailnotfound@gmail.com> wrote:
> (also, first git mailing list post.  I hope none of the experienced
> people have to correct me)

Heh, guess I have to correct myself -- someone already replied a long
time ago.  That's what I get for replying right when I start reading
backlog and depending on gmail to group threads for me :)
