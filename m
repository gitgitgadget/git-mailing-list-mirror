From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Fix approxidate() to understand more extended numbers
Date: Thu, 28 Sep 2006 20:12:23 -0400
Message-ID: <118833cc0609281712u2ce01bc5r8f3e97ae9c9a749a@mail.gmail.com>
References: <Pine.LNX.4.64.0609281211260.3952@g5.osdl.org>
	 <Pine.LNX.4.64.0609281212380.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 29 02:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT5zQ-0003BW-Mw
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 02:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWI2AMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 20:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWI2AMZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 20:12:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:19176 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965044AbWI2AMY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 20:12:24 -0400
Received: by wx-out-0506.google.com with SMTP id s14so752264wxc
        for <git@vger.kernel.org>; Thu, 28 Sep 2006 17:12:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DLo0KEvOulXChhYwIGJ69ODq96QhCj331wyfk58B5LcszhCynOQZ3f7iBd5oC6ay2jbpMDGRi+21GLi+gty5pR5U2OAqV3xjJnbLrug2Wjx4lMqb7L/qm4vTL0r9UNoLsSFq0oGyerIJOWo5m1IhusjyasGQJulMJQn08Nw8oBA=
Received: by 10.70.109.12 with SMTP id h12mr1302137wxc;
        Thu, 28 Sep 2006 17:12:23 -0700 (PDT)
Received: by 10.70.95.4 with HTTP; Thu, 28 Sep 2006 17:12:23 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609281212380.3952@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28076>

Just don't hack at 12am or 12pm.

M.
