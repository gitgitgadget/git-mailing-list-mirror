From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] cg-init should only process files
Date: Thu, 12 May 2005 17:45:22 +0100
Message-ID: <42838822.9000908@dgreaves.com>
References: <E1DWG9b-0001VV-V0@ash.dgreaves.com> <118833cc050512093750db7d55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 18:39:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWGhH-0001wg-3B
	for gcvg-git@gmane.org; Thu, 12 May 2005 18:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVELQpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 12:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVELQpk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 12:45:40 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:34432 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262076AbVELQpf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 12:45:35 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 3C732E6DF5; Thu, 12 May 2005 17:44:13 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 30245-13; Thu, 12 May 2005 17:44:13 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.145.229])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 99048E6A89; Thu, 12 May 2005 17:44:12 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWGoM-0004Zg-NQ; Thu, 12 May 2005 17:45:22 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc050512093750db7d55@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Morten Welinder wrote:

>>-       find * | xargs cg-add
>>+       find * -type f | xargs cg-add
>>    
>>
>
>I think we went through that a day or two ago:
>
Doh!
I even commented.

Sorry for the noise.

David

