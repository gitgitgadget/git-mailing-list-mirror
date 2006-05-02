From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Features ask for git-send-email
Date: Wed, 03 May 2006 00:33:13 +0100
Message-ID: <1146612793.19101.50.camel@pmac.infradead.org>
References: <4fb292fa0604290630r19edd7ejf88642e33b350d1d@mail.gmail.com>
	 <1146573417.14059.21.camel@pmac.infradead.org>
	 <4fb292fa0605021546i45c740c4i42c64125b8c560e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 03 01:33:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb4Mq-0002If-PU
	for gcvg-git@gmane.org; Wed, 03 May 2006 01:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWEBXdS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 19:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWEBXdS
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 19:33:18 -0400
Received: from canuck.infradead.org ([205.233.218.70]:34711 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932103AbWEBXdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 19:33:17 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1Fb4Ml-00077o-Ge; Tue, 02 May 2006 19:33:15 -0400
To: Bertrand Jacquin <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0605021546i45c740c4i42c64125b8c560e@mail.gmail.com>
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19441>

On Wed, 2006-05-03 at 00:46 +0200, Bertrand Jacquin wrote:
> I tryed it. I used this patch again master git git release
> 
> And I got the following with git-send-email :
> 
> Use of uninitialized value in hash element at /usr/bin/git-send-email line 437.
> Use of uninitialized value in hash element at /usr/bin/git-send-email line 437.
> <>: missing or malformed local part 

Interesting; it worked for me. Does the same happen _without_ the patch
applied?

-- 
dwmw2
