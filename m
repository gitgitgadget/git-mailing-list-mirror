From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: pushing patches to an imap folder
Date: Wed, 16 Nov 2005 16:45:41 +1300
Message-ID: <46a038f90511151945q62f59e3cl18ffedc5dd000c7c@mail.gmail.com>
References: <43799A67.9030705@codeweavers.com>
	 <7vd5l2qnq6.fsf@assigned-by-dhcp.cox.net>
	 <4379B9F6.5020402@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Kevin Geiss <kevin@desertsol.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 04:47:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcEFT-0000Gw-AO
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 04:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbVKPDpp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 22:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbVKPDpp
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 22:45:45 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:50103 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965220AbVKPDpp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 22:45:45 -0500
Received: by wproxy.gmail.com with SMTP id 67so2028366wri
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 19:45:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hU+E/GN0fTkrz6ZG24P5GdWg1iPGTCrxEI9M3B4YlbbM7wEgFymQiCZn2fc9U4z20Lqqw83kw0eP9kQDuiz96UGMDA3pKvrlCItQVC8wqCLdNhXFm0zbJzpPtmbVf7YN1XT+o/U37xeA4OVVesG5TqUts2wcuy/qYlE6RLahl1A=
Received: by 10.64.193.9 with SMTP id q9mr5181180qbf;
        Tue, 15 Nov 2005 19:45:43 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Tue, 15 Nov 2005 19:45:41 -0800 (PST)
To: Mike McCormack <mike@codeweavers.com>
In-Reply-To: <4379B9F6.5020402@codeweavers.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12003>

On 11/15/05, Mike McCormack <mike@codeweavers.com> wrote:
> It will probably be maintained in parallel with the Wine CVS for a
> while, unless somebody writes a GIT->CVS gateway.

The missing 'git-cvsexport' command should be the missing part for the
gateway. I am not hacking on it right now, but Kevin seemed to be
getting started in that direction. If not, I'll probably hack
something together eventually.

I don't have any project currently migrating to GIT... yet ;-)



martin
