From: Santi Bejar <sbejar@gmail.com>
Subject: Re: What's in git.git
Date: Thu, 26 Jan 2006 17:24:35 +0100
Message-ID: <8aa486160601260824g72b127ddn@mail.gmail.com>
References: <7vy814qx6o.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160601250634v294857e0j@mail.gmail.com>
	 <7vvew7lv4s.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160601260104v745594d9m@mail.gmail.com>
	 <7vk6cngwfh.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160601260156h6157ca34s@mail.gmail.com>
	 <7vhd7rfare.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 17:24:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F29vN-00016I-Fl
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 17:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWAZQYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 11:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWAZQYi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 11:24:38 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:36674 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964788AbWAZQYi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 11:24:38 -0500
Received: by xproxy.gmail.com with SMTP id s14so246846wxc
        for <git@vger.kernel.org>; Thu, 26 Jan 2006 08:24:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MgLUN+4JRcVesK9niYGV89A5GdjZtFkQUqirhCE7yfQpYkb7KDt9/rVb4ACU5Zd5r7J+C18P1PL5+FzZ1WSNt436atu3suVm2W6VibHM0gUWW7IM81iQ40UqEC/RHHuSryzZZsD1gPLjfZaXcT5xqzi/JRNTkpSHEQ9sQMObq48=
Received: by 10.70.15.3 with SMTP id 3mr2335837wxo;
        Thu, 26 Jan 2006 08:24:35 -0800 (PST)
Received: by 10.70.19.18 with HTTP; Thu, 26 Jan 2006 08:24:35 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd7rfare.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15168>

> I think this patch would address your two issues (applies on top
> of "pu"), but I have not had time to test it seriously enough.

It works here, thanks.

Just a little issue. With grafted commits the combined diff works but
the "Merge:" line is not shown.

Santi
