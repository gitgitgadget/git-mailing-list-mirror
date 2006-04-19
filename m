From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: GIT Error issue
Date: Wed, 19 Apr 2006 13:20:28 +0200
Message-ID: <20060419112028.GA7278@mars.ravnborg.org>
References: <3857255c0604190416j62abeae8va164896c5100f6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 13:21:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWAju-0003LH-W4
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 13:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWDSLUq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 07:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWDSLUq
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 07:20:46 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1552 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750886AbWDSLUq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 07:20:46 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id C5FB81EC366;
	Wed, 19 Apr 2006 13:20:42 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 7419943C21C; Wed, 19 Apr 2006 13:20:28 +0200 (CEST)
To: Shyamal Sadanshio <shyamal.sadanshio@gmail.com>
Content-Disposition: inline
In-Reply-To: <3857255c0604190416j62abeae8va164896c5100f6ee@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18919>

On Wed, Apr 19, 2006 at 04:46:57PM +0530, Shyamal Sadanshio wrote:
> Hi,
> 
> I am newbie to GIT and facing some problem with the GIT usage. I am
> trying to clone a repository at www.linux-mips.org with the
> following command, I get error message as below:
> 
> **************************************************************************
> [root@sshyamal git-tutorial]# git clone
> git://ftp.linux-mips.org/pub/scm/linux-malta.git linux-malta.git
> git: warning: invalid extra options ignored
> 
> GNU Interactive Tools 4.3.20 (i686-pc-linux-gnu), 12:39:46 Apr 18 2006
You are running the wrong git.
The git you are running are the "GNU Interactive Tools" and not git from
the git-suite.
Fix - uninstall "GNU Interactive Tools"

	Sam
