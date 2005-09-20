From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Ship our own copy of subprocess.py
Date: Tue, 20 Sep 2005 07:30:24 +0200
Message-ID: <20050920053024.GA12979@c165.ib.student.liu.se>
References: <432F0C66.7060402@zytor.com> <20050919200222.GA11322@c165.ib.student.liu.se> <7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com> <7v7jdclpme.fsf@assigned-by-dhcp.cox.net> <432F3253.3070201@zytor.com> <20050919231704.GA19276@unpythonic.net> <432F48C7.8070405@zytor.com> <7v8xxsebsc.fsf@assigned-by-dhcp.cox.net> <7vfys0cpyj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 07:31:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHaiO-00042Z-Fz
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 07:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbVITFab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 01:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVITFab
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 01:30:31 -0400
Received: from [85.8.31.11] ([85.8.31.11]:43680 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S964893AbVITFaa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 01:30:30 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 94A4340FD; Tue, 20 Sep 2005 07:35:51 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EHai0-0003O8-00; Tue, 20 Sep 2005 07:30:24 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfys0cpyj.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8976>

On Mon, Sep 19, 2005 at 09:39:48PM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> >  - merge-recursive not requiring 2.4 but checking the result
> >    from 'import subprocess', and optionally install its own
> >    subprocess.py (I could do this myself but Fredrik could help
> >    me);
> 
> I'll be cutting 0.99.7a with this, to help RHEL instalation.
> Proofreading appreciated.
> 

The patch looks good. I am obviously too slow for this kind of thing :)

Thanks.

- Fredrik
