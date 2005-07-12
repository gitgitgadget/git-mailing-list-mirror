From: Darrin Thompson <darrint@progeny.com>
Subject: Re: [PATCH 2/2] Demo support for packs via HTTP
Date: Tue, 12 Jul 2005 08:35:54 -0500
Message-ID: <42D3C73A.9010305@progeny.com>
References: <Pine.LNX.4.21.0507112147400.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Jul 12 15:41:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsKzL-0000cm-2z
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 15:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVGLNjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 09:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVGLNgm
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 09:36:42 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:63403 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261424AbVGLNgD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 09:36:03 -0400
Received: (qmail 2325 invoked from network); 12 Jul 2005 13:35:58 -0000
Received: from unknown (HELO ?127.0.0.1?) (dtthompson@sbcglobal.net@68.74.58.216 with plain)
  by smtp108.sbc.mail.re2.yahoo.com with SMTP; 12 Jul 2005 13:35:58 -0000
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507112147400.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:
> If I understand the curl documentation, you should be able to set options 
> on the curl object when it has just been created, if those options aren't
> going to change between requests. Note that I make requests from multiple
> places, but I use the same curl object for all of them.
> 

I didn't realize that it was the same object. Great!

--
Darrin
