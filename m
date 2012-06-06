From: John Wiegley <johnw@newartisans.com>
Subject: Re: Please revert e371046b6473907aa6d62b7862a3afe9d33561e1
Date: Wed, 06 Jun 2012 13:26:28 -0500
Message-ID: <m262b4uwiz.fsf@gmail.com>
References: <m24nqoohss.fsf@gmail.com>
	<CA+39Oz4f_Wn1cVzqNWO76HZWa4AswSBpbriaRc0OznapVLJfGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 20:26:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScKwI-0003dJ-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 20:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757949Ab2FFS0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 14:26:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51640 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212Ab2FFS0b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 14:26:31 -0400
Received: by yhmm54 with SMTP id m54so5141465yhm.19
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tmz9zkNDjyvdkMjCS+iJNfZYd3jW9zMlpmPiQhC9JmE=;
        b=TrsyQjMSvDZtL3iR3V/woZzV5XKPXIYWbQBtpqC83Kxx4CJRjkVvqMT61b28/70EMh
         WOKAarDcxrnmxbFgPybg1ZNVbdU3QHnFCfTMU12JF2Qso+/wY2YMmFHIiUcRiPhHiOPr
         y7YW7Fx726gFpEDvYGGqfSi7e1kRzIF4l7gqZMwjBKZUhS8xAxL/cfhxxvgvsCvRam9s
         OrzR8RMzzTQPSl3wTC00UHDiAThB0fBmn5mdYr2+QMfObHH1dAuib4oeN4NPvbKWHBnv
         evOwoRej6F3qHiZbainoFDQuirCousffYr7RpRUW0GRwFbXVlZzUuvhO5Np279s1yWGi
         9CjQ==
Received: by 10.50.158.168 with SMTP id wv8mr7797811igb.24.1339007190716;
        Wed, 06 Jun 2012 11:26:30 -0700 (PDT)
Received: from vulcan.local (c-98-215-105-167.hsd1.il.comcast.net. [98.215.105.167])
        by mx.google.com with ESMTPS id z3sm1491602igc.7.2012.06.06.11.26.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 11:26:30 -0700 (PDT)
Received: by vulcan.local (Postfix, from userid 501)
	id D60AEED343B6; Wed,  6 Jun 2012 13:26:28 -0500 (CDT)
In-Reply-To: <CA+39Oz4f_Wn1cVzqNWO76HZWa4AswSBpbriaRc0OznapVLJfGg@mail.gmail.com>
	(Thomas Adam's message of "Wed, 6 Jun 2012 18:54:10 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.1 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199344>

>>>>> Thomas Adam <thomas@xteddy.org> writes:

> This assertion is not only wrong, it's just ludicrous.  The intended
> functionality has a statement of intent with regards to its functionality --
> and as a user of cvs2git, I'd not want to lose *any* of that functionality.
> 
> Don't be stupid with this.  Please.

My needs would be satisfied with an command-line option that removes the
limit, while keeping the status quo unaffected if it's not used.  How does
that sound?

John
