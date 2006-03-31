From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Gitk strangeness..
Date: Fri, 31 Mar 2006 08:27:34 +0200
Message-ID: <81b0412b0603302227t1580b20awff937ab932ae39bd@mail.gmail.com>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	 <17448.40941.256361.866229@cargo.ozlabs.ibm.com>
	 <7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
	 <17448.48143.764989.649462@cargo.ozlabs.ibm.com>
	 <7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net>
	 <17448.54558.865097.519248@cargo.ozlabs.ibm.com>
	 <7vzmjbj9a1.fsf@assigned-by-dhcp.cox.net>
	 <17449.48630.370867.10251@cargo.ozlabs.ibm.com>
	 <20060330205759.GA27131@steel.home>
	 <17452.28122.129442.49226@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Mar 31 08:27:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPD6n-0004Hu-1v
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 08:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWCaG1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 01:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWCaG1f
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 01:27:35 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:2764 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750755AbWCaG1f convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 01:27:35 -0500
Received: by zproxy.gmail.com with SMTP id o37so751879nzf
        for <git@vger.kernel.org>; Thu, 30 Mar 2006 22:27:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I2Q52o0qsTqG+mQ3Yzs5J+oBpSKRXWMApCvKi6InorKNz7MI18jljY05gOTvlSmGRzQmWH3LillE4Bq7tuIRQPBOSNE85b8+fntOnLGYatkVu1Nziz4+avhD35Xpmk/lx21XG/K1wFZXwEuRUUNfJWGz75bwDquKZVSbwvRVKlc=
Received: by 10.35.70.17 with SMTP id x17mr252006pyk;
        Thu, 30 Mar 2006 22:27:34 -0800 (PST)
Received: by 10.35.41.18 with HTTP; Thu, 30 Mar 2006 22:27:34 -0800 (PST)
To: "Paul Mackerras" <paulus@samba.org>
In-Reply-To: <17452.28122.129442.49226@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18218>

On 3/31/06, Paul Mackerras <paulus@samba.org> wrote:
>
> > The old gitk produced a denser graph, which wasn't perfect too, but
> > had a higher count of visible commit titles (and this is two-monitor
> > setup, too).
>
> I just pushed a new version which does better on this.
>

This one looks reallly much better! Thanks!
