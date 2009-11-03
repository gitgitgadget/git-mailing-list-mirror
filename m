From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Tue, 3 Nov 2009 17:07:28 +0100
Message-ID: <fabb9a1e0911030807h6b76b661pef75628a1255356@mail.gmail.com>
References: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 17:08:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5LvO-00025k-5N
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 17:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbZKCQHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 11:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbZKCQHp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 11:07:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:62040 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbZKCQHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 11:07:44 -0500
Received: by fg-out-1718.google.com with SMTP id d23so1374653fga.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 08:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=fxJe6gv5nCmkBbRhcvOB9HODL40IzJb4t2dDbT6WGcc=;
        b=iQ2+IB8xMR1FTK+F9jP4OTriWHeBqFTZCj6JARWgEr23v/y2iih8YYz/5h/u+0MhsM
         3Hik7Hw1HOkADK8CbwiDWl95/m1QjAjn+A4H046jD+lJDjgvSPD2iPiBI/BNUjkDdspm
         iI6nDkIPmcehMZlnOwIqLSQJHOIlkLtYaACeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qT0Ka2PvUFQ6PuNga2VwLCtmOhdAsHYMpqcfOIXffHCCW003ffcFd9/1lC90c+rlvO
         ZVBahF7h6ga6uI7LDNaXd2VINRBfFnfZXa7hiB+5yxWNY9NhlinSF8aqzrjhoUNtp7uA
         ukUt3UBVW5SMF9yCNmg2yANoo4YQwvKj19SY4=
Received: by 10.204.7.88 with SMTP id c24mr176697bkc.17.1257264468762; Tue, 03 
	Nov 2009 08:07:48 -0800 (PST)
In-Reply-To: <2e24e5b90911030800j22b00372r99a56c3f847a3644@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131976>

Heya,

On Tue, Nov 3, 2009 at 17:00, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> At the command line, this gives you a detailed warning message, but the
> GUI currently allows it without any fuss.

This is even better than an annoying popup dialog, as we all know
those are just ignored anyway :).

-- 
Cheers,

Sverre Rabbelier
