From: Kyle Rose <krose@krose.org>
Subject: Re: C++ *for Git*
Date: Sat, 22 Sep 2007 11:15:22 -0400
Organization: The Valley of Wind
Message-ID: <46F5318A.4030103@krose.org>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 17:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ6he-0002I8-13
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 17:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbXIVPPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 11:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbXIVPPY
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 11:15:24 -0400
Received: from kai.krose.org ([140.186.190.96]:40931 "EHLO kai.krose.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbXIVPPX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 11:15:23 -0400
Received: from [192.168.33.7] (nausicaa.valley-of-wind.krose.org [192.168.33.7])
	by kai.krose.org (Postfix) with ESMTP id CDEC32AEC104;
	Sat, 22 Sep 2007 11:15:47 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070802)
In-Reply-To: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58935>

You know, git *is* free software.  Feel free to fork it and add all the
C++ code you want.

FWIW, I am of the opinion that Python or Ruby (or god forbid, Perl)
would have been a better choice for something like git that does lots of
text processing... furthermore, I think the exception handling, garbage
collection, and implicit object destruction provided by those languages
(and by C++, as overwrought as it is) makes any codebase easier to
understand and maintain.

But that's irrelevant: git is written in C.  That's the way it is, and
you should accept that or fork.

Kyle

Dmitry Kakurin wrote:
> We've had this theoretical (and IMHO pointless) discussion C vs. C++ *in
> general*.
> In no way I want to restart it.
