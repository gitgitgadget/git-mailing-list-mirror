From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Tue, 03 Feb 2009 09:00:46 -0800 (PST)
Message-ID: <m3hc3bwj5b.fsf@localhost.localdomain>
References: <1233432317.26364.5.camel@wren>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:02:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOfD-0001oJ-UB
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbZBCRAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbZBCRAx
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:00:53 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:33588 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbZBCRAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:00:52 -0500
Received: by fk-out-0910.google.com with SMTP id f33so1701460fkf.5
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 09:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=xY0hfnBg8NUL5HUYqcAtBoqSlLIwQNeTRudeugdyEZ4=;
        b=dFubK/Rufk+gSr5O9FcIcCwYuvVNdIKbEFg65UkkzZcx7l+I0WQh6YOwK0N0/YaUDI
         /mJiGzZukHxtOoU8VZN/ZM0amx24fW2q0qdQJvWYOVXHXGsy4V9R6e9sp8CujyDhHxYe
         0AclQgpUCxm3B5/S8jnadlXHkXUypHJ3KOYXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Yyw9v2HxXUuS6QGMbdfwr4ZLpbdP/nZtPnvyHlCnwJ2ezAGsMOnoJvIqmknG6Ck1+i
         7KE5KtYIRAKSTU4hSVAsJbtSrJRqrbnn6MnFo3xKU/o+71bLXqyEbxBI8Sk9eEPhUwhk
         nr1ZkKoQGRlBTROUMBdwh7OjK8uhDgCjxGZ8E=
Received: by 10.223.108.15 with SMTP id d15mr444923fap.105.1233680447694;
        Tue, 03 Feb 2009 09:00:47 -0800 (PST)
Received: from localhost.localdomain (abvf78.neoplus.adsl.tpnet.pl [83.8.203.78])
        by mx.google.com with ESMTPS id f3sm3029924nfh.74.2009.02.03.09.00.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 09:00:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n13H0ERp023919;
	Tue, 3 Feb 2009 18:00:25 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n13H03BM023912;
	Tue, 3 Feb 2009 18:00:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1233432317.26364.5.camel@wren>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jesse van den Kieboom <jesse@icecrew.nl> writes:

> I have been developing a gui application for git for gtk+/GNOME based on
> GitX (which in turn is based on gitk). I feel that it's reaching the
> point where it might potentially be useful for other people to use.
[...]

How it differs from other git GUI applications for GTK+/GNOME,
namely GitView (in contrib/) and Giggle?

> The project is currently hosted on github:
> http://github.com/jessevdk/gitg

If you feel it is ready to be used (or at least tested), could you add
short information about this project in "Graphical Interfaces" section
of http://git.or.cz/gitwiki/InterfacesFrontendsAndTools (preferable
not using GUI edit, as it screws up formatting, unfortunately)?

TIA
-- 
Jakub Narebski
Poland
ShadeHawk on #git
