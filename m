From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [RFC] Do we still need the git command?
Date: Fri, 23 Sep 2005 23:38:31 +1200
Message-ID: <46a038f905092304384d79d715@mail.gmail.com>
References: <72499e3b050923042466011c4f@mail.gmail.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 13:41:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIlt4-0001x1-Fw
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 13:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVIWLid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 07:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVIWLid
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 07:38:33 -0400
Received: from qproxy.gmail.com ([72.14.204.202]:32490 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750888AbVIWLid convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 07:38:33 -0400
Received: by qproxy.gmail.com with SMTP id v40so155194qbe
        for <git@vger.kernel.org>; Fri, 23 Sep 2005 04:38:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AA8eWSvzxjTctcRY3BXSv0HPnayXUwl4D+tOqF7a4Fu9UA8xPA+86fCHAV+JslDcEC9VgnJXzv0XwfvJEzEvYjKEcJDw9S3ZTbFS00nM518CXOzZBlLD2NtjsSUZivs3jUUsWza/FiqBMxyIK9OhO8TrhHZCzt6SFVnEho51J6A=
Received: by 10.64.209.14 with SMTP id h14mr217728qbg;
        Fri, 23 Sep 2005 04:38:31 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Fri, 23 Sep 2005 04:38:31 -0700 (PDT)
To: Robert Watson <robert.oo.watson@gmail.com>
In-Reply-To: <72499e3b050923042466011c4f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9178>

On 9/23/05, Robert Watson <robert.oo.watson@gmail.com> wrote:
> (2) Different style from CVS/SVN.

That is a plus in my book -- CVS implemented an awful UI, and everyone
else followed. CVS did make use if it in that it discriminated options
to the cvs utility from command options.

> Pros:
> (4) Do not conflict with GNU Interactive Tools.  Make the life of
> Debian people easier.

+1! Anything to avoid yet another flamewar in debian-devel ;-) and it
also shows some good manners towards a (mostly forgotten) but good
project. The whole name conflict prompted me to install the GNU
Interactive Tools and run it for a couple of days. Nifty little
"midnight-commander" style utility.

cheers,


martin
