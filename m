From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Fix zebra coloring flip introduced by eeef88cd2
Date: Wed, 11 Oct 2006 00:21:26 -0700 (PDT)
Message-ID: <20061011072126.12959.qmail@web31805.mail.mud.yahoo.com>
References: <7vk637xxxr.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 09:21:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXYPF-0001rF-9n
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 09:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWJKHV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 03:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWJKHV1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 03:21:27 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:6072 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932453AbWJKHV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 03:21:27 -0400
Received: (qmail 12961 invoked by uid 60001); 11 Oct 2006 07:21:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hJyVVJSgzxk0V/AozFyshZll526dpnR/nG5eE+t0ycVmoo5HH/+oe2X+phhrWiecCN1DenjWEwlLHqtFHAjrMXaZsBYDq5xgWBbqFBwr0WClnc3zdg/oZCn96cy3D+SCtzp9wRD6A3d9CrkVkYToXrhTX2Ftlf40yc8efL5GgZ0=  ;
Received: from [71.80.233.118] by web31805.mail.mud.yahoo.com via HTTP; Wed, 11 Oct 2006 00:21:26 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk637xxxr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28696>

--- Junio C Hamano <junkio@cox.net> wrote:
> I do not have much preference either way, but it was done more
> or less deliberately to match what you did with 6dd36ac.

Sorry, I didn't mean to introduce the apparent inconsisteny.
The 6dd36ac touches alternate "active" shading, and blame
only shows the contents, albeit with the commit-8 and block
coloring.

    Luben
