From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: /bin/sh portability question
Date: Fri, 23 Sep 2005 15:55:03 -0400
Message-ID: <118833cc05092312553b526845@mail.gmail.com>
References: <20050923075058.GA25473@bohr.gbar.dtu.dk>
	 <43345C17.7060402@zytor.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 21:55:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EItdb-0008Uk-9n
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 21:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVIWTzG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 15:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVIWTzG
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 15:55:06 -0400
Received: from qproxy.gmail.com ([72.14.204.193]:41457 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750853AbVIWTzE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 15:55:04 -0400
Received: by qproxy.gmail.com with SMTP id f11so238575qba
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 12:55:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fRTUuHS3UrK2mE+rDYIYTmK6VDVrBrdyWXO8iembQ77hCWSVirIBTtJtTP4k9/MxMY2G98V+OZXCidEgEhsAh+mhJjcZadl8509U3qL6KsmMrYwSASyJwaClxdUDui8JWixYS8SNLsE96t4vfQqYw55hnREIkcOFZgd+4NO8+LM=
Received: by 10.65.83.6 with SMTP id k6mr259595qbl;
        Fri, 23 Sep 2005 12:55:03 -0700 (PDT)
Received: by 10.65.107.8 with HTTP; Fri, 23 Sep 2005 12:55:03 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43345C17.7060402@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9198>

> I think $(foo) is required by POSIX.

Indeed, but Solaris really does not have it.

Morten
