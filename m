From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: Ambiguous -from of git-send-email
Date: Sun, 31 Aug 2008 12:37:56 -0700
Message-ID: <1A4402DD-03B5-4951-B8CA-DB8A8E93D8C4@develooper.com>
References: <20080831055710.GA644@yukikaze>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sheng Yang <yasker@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 21:40:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZsmf-0006PT-7g
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 21:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179AbYHaTh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 15:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756141AbYHaTh7
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 15:37:59 -0400
Received: from x8.develooper.com ([216.52.237.208]:50410 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066AbYHaTh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 15:37:59 -0400
Received: (qmail 17295 invoked from network); 31 Aug 2008 19:37:57 -0000
Received: from gw.develooper.com (HELO embla.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 31 Aug 2008 19:37:57 -0000
In-Reply-To: <20080831055710.GA644@yukikaze>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94502>


On Aug 30, 2008, at 22:57, Sheng Yang wrote:

> And can we add a something like "sendemail.sender" to specify the
> sender? I think it's not that unusual to make author's email address  
> is
> different from sender, at least I think it's more common than
> "sendmail.bcc".

Try the sendemail.envelopesender option.  I'll make a patch for adding  
that to the documentation.


  - ask

-- 
http://develooper.com/ - http://askask.com/
