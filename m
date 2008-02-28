From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: [PATCH] Document conding style
Date: Thu, 28 Feb 2008 14:07:12 +0100
Message-ID: <47C6B200.1080707@gmx.ch>
References: <12041000101604-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 14:07:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUiUL-0002Xl-4T
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 14:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033AbYB1NHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 08:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756089AbYB1NHP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 08:07:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:42431 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752995AbYB1NHP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 08:07:15 -0500
Received: (qmail invoked by alias); 28 Feb 2008 13:07:12 -0000
Received: from 37-45.78-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.78.45.37]
  by mail.gmx.net (mp024) with SMTP; 28 Feb 2008 14:07:12 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX184v11d3wE4O54hSVDH6oONloX3GkY33iYqBY78Pk
	2zFGi9mWJZ8nDO
User-Agent: Thunderbird 2.0.0.9 (X11/20071118)
In-Reply-To: <12041000101604-git-send-email-mkoegler@auto.tuwien.ac.at>
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75398>

Martin Koegler wrote:
> + - Avoid trailing whitespaces
> +

Maybe it's worth mentioning that the default pre-commit hook does
that for you (among other things); you just need to enable it.

jlh
