From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Fix AsciiDoc errors in merge documentation
Date: Fri, 05 Sep 2008 08:09:20 +0200
Message-ID: <200809050809.20791.johan@herland.net>
References: <48BFBBEF.6010403@isy.liu.se>
 <200809042348.48570.johan@herland.net>
 <7vbpz31oup.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 08:10:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbUWp-00042L-6X
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 08:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbYIEGJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 02:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbYIEGJg
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 02:09:36 -0400
Received: from smtp.getmail.no ([84.208.20.33]:46369 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbYIEGJf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 02:09:35 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K6P0070PL3YC200@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 05 Sep 2008 08:09:34 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6P008R7L3LXS40@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 05 Sep 2008 08:09:21 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K6P00J3TL3KJZ40@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 05 Sep 2008 08:09:21 +0200 (CEST)
In-reply-to: <7vbpz31oup.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94992>

On Friday 05 September 2008, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > [...]
>
> Thanks.  It's good to see issues with new changes are resolved while they
> are still in 'next'.

Hey, that's what next is for, isn't it? ;)

> Have you tried this patch without double quotes around the teletype text,
> by the way?

Seems to work fine, as well.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
