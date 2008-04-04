From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 04 Apr 2008 16:21:46 -0400
Message-ID: <1207340506.10992.28.camel@gaara.boston.redhat.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
	 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
	 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
	 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
	 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
	 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 22:22:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhsR0-0000bR-Pj
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 22:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093AbYDDUWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 16:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758044AbYDDUWI
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 16:22:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60492 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181AbYDDUWG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 16:22:06 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m34KLqvS020613;
	Fri, 4 Apr 2008 16:21:52 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m34KLpRh015744;
	Fri, 4 Apr 2008 16:21:51 -0400
Received: from [192.168.1.104] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m34KLpVn028746;
	Fri, 4 Apr 2008 16:21:51 -0400
In-Reply-To: <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.0 (2.22.0-4.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78815>

On Fri, 2008-04-04 at 11:24 -0700, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed
> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.
> 
> The topics list the commits in reverse chronological order.
> 
> With a handful topics graduated to "master", we hopefully will have
> the
> final 1.5.5 soon.

What happened to builtin-clone?  I know I just threw it over the fence,
but Daniel picked it up and got it a lot closer to working?  Did it fall
through the cracks or is it just 1.5.6 material?

Kristian
