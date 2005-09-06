From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: git daemon usage
Date: Tue, 6 Sep 2005 10:28:06 +0400
Message-ID: <200509061028.06951.snake@penza-gsm.ru>
References: <20050812001339.GL25280@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 06 08:29:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECWwL-0001mV-7P
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 08:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVIFG2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 02:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVIFG2O
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 02:28:14 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:40665
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S932415AbVIFG2O
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 02:28:14 -0400
Received: (qmail 10908 invoked from network); 6 Sep 2005 06:28:09 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 6 Sep 2005 06:28:09 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <20050812001339.GL25280@pasky.ji.cz>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8122>

Sunday 12 August 2005 04:13 Petr Baudis wrote:
>   Hello,
>
>   is anyone actually using the git daemon in practice, now that the
> other transfer methods can deal with packs? I ask since I wonder if I
> should actually bother with adding support for it to cg-pull.
Sorry for the very late answer - I was on vacation and now reading archives.
I'm using it as djb's tcpserver + linus's git-daemon
>
>   Thanks,

-- 
Respectfully
Alexey Nezhdanov
