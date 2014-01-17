From: Yuri <yuri@rawbw.com>
Subject: Re: [PATCH 0/3] improved out-of-the-box color settings
Date: Fri, 17 Jan 2014 01:13:32 -0800
Message-ID: <52D8F43C.9020709@rawbw.com>
References: <52D87A79.6060600@rawbw.com> <20140117014758.GF7249@sigill.intra.peff.net> <52D88F30.4000807@rawbw.com> <20140117021320.GA12444@sigill.intra.peff.net> <20140117022921.GU18964@google.com> <20140117023548.GB13023@sigill.intra.peff.net> <20140117041430.GB19551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:13:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W45Ur-0001Vi-1j
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbaAQJNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 04:13:45 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:59142 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbaAQJNl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:13:41 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0H9DW4e040251;
	Fri, 17 Jan 2014 01:13:32 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140117041430.GB19551@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240579>

On 01/16/2014 20:14, Jeff King wrote:
> The second patch turns on "MORE=R" only for FreeBSD. Yuri, if you can
> confirm that my patch works for you, that would be excellent. And if you
> (or anyone) has access to NetBSD or OpenBSD to test the second patch on,
> I'd welcome updates to config.mak.uname for those systems.

I applied 3 patches, and it fixed the issue for me.

Thank you for such a fast response! This is very impressive!
I saw this issue for a long while, and only last night took time to 
report it.

Unfortunately, I don't have any other BSDs sitting around. The easiest 
way to try this is to install them in VM.

Yuri
