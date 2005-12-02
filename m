From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: resolve (merge) problems
Date: Fri, 2 Dec 2005 05:59:37 -0800 (PST)
Message-ID: <20051202135937.86549.qmail@web31811.mail.mud.yahoo.com>
References: <7vk6eo9jag.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 15:02:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiBS4-0007Zq-3s
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 14:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVLBN7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 08:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVLBN7k
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 08:59:40 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:55890 "HELO
	web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750748AbVLBN7k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 08:59:40 -0500
Received: (qmail 86551 invoked by uid 60001); 2 Dec 2005 13:59:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4lA6+xDSRoTNqthCQt3yKTAv+64zhPt/ve8upTCfyRep0TUW5TAYwQAslwh0fj8C0t2dQVJljt7/QH5o4Y3Z891hVLWjFPMkiWXoVfQaGGBwojp3UpqfWA9FuSOgaAC1ZBXG6OXrIKadzStUxcOZnTTQK1a/pl8FrXjHfmL+SZ4=  ;
Received: from [68.221.13.176] by web31811.mail.mud.yahoo.com via HTTP; Fri, 02 Dec 2005 05:59:37 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6eo9jag.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13117>

--- Junio C Hamano <junkio@cox.net> wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > $python -V
> > Python 2.4.2
> > $which python
> > /usr/local/bin/python
> 
> Since you do not want to use /usr/bin/python but from your own
> location /usr/local/bin/python, I presume you built git with
> 
> 	$ make PYTHON_PATH=/usr/local/bin/python
> 
> among other installation specific override needed on your
> machine?

Oops :-) (lol)

Thanks,
    Luben
