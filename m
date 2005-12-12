From: Don Zickus <dzickus@gmail.com>
Subject: Re: branching and supporting a tagged kernel version
Date: Mon, 12 Dec 2005 18:58:38 -0500
Message-ID: <68948ca0512121558s6e300103t95fcc0e9573604a7@mail.gmail.com>
References: <68948ca0512121331x13bfb691t62224d02ced04a27@mail.gmail.com>
	 <7virtueycd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 01:00:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElxZ6-00069k-9r
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 00:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVLLX6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 18:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVLLX6k
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 18:58:40 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:4368 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932263AbVLLX6i convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 18:58:38 -0500
Received: by wproxy.gmail.com with SMTP id 69so1490249wra
        for <git@vger.kernel.org>; Mon, 12 Dec 2005 15:58:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HdvzP9sszVZtEZPrrfk8t8nSTkjbJB6EeJWQ34QnHGASK/BlennV7O759gETUk5fX0ZswEhWbFinwoAuDEQeLy0A8HqhZjZCtYk0gfjvriFwq5t2+dTmMwz/6AqiXyA+lLvYlm7kiIKf0BG9N8E6/QqCxq0QzKQeh2nl3vlTYCI=
Received: by 10.65.123.3 with SMTP id a3mr166183qbn;
        Mon, 12 Dec 2005 15:58:38 -0800 (PST)
Received: by 10.65.240.20 with HTTP; Mon, 12 Dec 2005 15:58:38 -0800 (PST)
In-Reply-To: <7virtueycd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13547>

Thanks for clearing things up.

> I'll refrain from saying that it is not the usual way to work
> with git, since you seem to know what you are doing.  So let's

Either this or cvs. :)  Anyway my work involves releasing a platform
to customers who don't want  to constantly upgrade their kernel.  And
instead of waiting for bugs to be filed, I was just trying to find a
way to be pro-active and fix certain bugs _before_ our customers hit
them.

Cheers,
Don
