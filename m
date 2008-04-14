From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Intricacies of submodules
Date: Mon, 14 Apr 2008 12:56:26 -0700
Message-ID: <1208202986.25663.73.camel@work.sfbay.sun.com>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
 <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
 <1207859579.13123.306.camel@work.sfbay.sun.com>
 <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Avery Pennarun <apenwarr@gmail.com>, stuart.freeman@et.gatech.edu,
	git@vger.kernel.org, rvs@sun.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 21:57:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlUkh-0005Fe-Na
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 21:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762222AbYDNTxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 15:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762183AbYDNTxU
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 15:53:20 -0400
Received: from sca-es-mail-1.Sun.COM ([192.18.43.132]:60259 "EHLO
	sca-es-mail-1.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762128AbYDNTxT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 15:53:19 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3EJrIpf012242
	for <git@vger.kernel.org>; Mon, 14 Apr 2008 12:53:18 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZB00001YZNHQ00@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Mon, 14 Apr 2008 12:53:18 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JZB0004TZ8U2CB0@fe-sfbay-09.sun.com>; Mon,
 14 Apr 2008 12:53:18 -0700 (PDT)
In-reply-to: <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79529>

On Thu, 2008-04-10 at 22:20 -0700, Junio C Hamano wrote:
> Roman Shaposhnik <rvs@sun.com> writes:
> 
> > ... I'm very interested in getting this functionality
> > right with git-submodule. And I can be either your guinea pig or
> > a frenetic hamster. After all, you don't mind complete newcomers
> > to the development process sending you code, do you? ;-)
> 
> Everybody starts out as a total stranger.  Linus has never worked with me
> when I started, and many people who are the core members of git community
> have never worked with me before either.

Cool! I do have a couple of questions on the development etiquette,
but I think I'll ask them off-line unless somebody can point me
to an FAQ on how Git's development is setup. The section 
"Community and Development" doesn't seem to answer much
of my questions.

Thanks,
Roman.
