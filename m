From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Fri, 21 Jan 2011 11:08:21 +0100
Message-ID: <4D395B15.2040406@seznam.cz>
References: <4D3893EA.5090907@hartwork.org> <201101202127.39962.trast@student.ethz.ch> <4D389E69.608@hartwork.org> <7vk4hzqnbx.fsf@alter.siamese.dyndns.org> <20110120231649.GC14184@vidovic> <20110120233429.GB9442@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 21 11:08:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgDuu-00085o-O0
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 11:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab1AUKIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 05:08:24 -0500
Received: from cgc-instruments.com ([83.169.21.132]:54673 "EHLO
	lvps83-169-21-132.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752635Ab1AUKIX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jan 2011 05:08:23 -0500
Received: (qmail 12182 invoked from network); 21 Jan 2011 11:08:20 +0100
Received: from 188-120-198-113.luckynet.cz (HELO ?10.0.3.100?) (188.120.198.113)
  by cgc-instruments.com with SMTP; 21 Jan 2011 11:08:20 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20110120233429.GB9442@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165361>

On 11-01-21 00:34, Jeff King wrote:
> On Fri, Jan 21, 2011 at 12:16:49AM +0100, Nicolas Sebrecht wrote:

>   4. Do (3), but also list the all (or common) diff options in a succint
>      list without descriptions, and refer the user to git-diff(1). Then
>      they can grep if they like, and while they won't get the immediate
>      answer, they will get referred to the right place.
> 
> As you can probably guess, I favor option (4), though we already do (3)
> in some places.

I also favor (4), for the following reasons:

- sometimes you want to read the whole manpage, e.g., it's good for
beginners to get feeling what is it all about.

- repeated information makes the page too long and reading too boring.

- too long manpages may scare beginners.

Maybe there could be sort-of extended manpage, containing everything,
but it would need some markup beyond the capabilities of a terminal (a
grayed or collapsed area in html, or whatever). However, this could be a
lot of additional work, and I don't claim it should be done, just an idea.
