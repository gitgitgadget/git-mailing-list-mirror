From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: gitk doesn't work w/o sudo.
Date: Mon, 19 Jan 2009 09:48:36 -0500
Message-ID: <20090119144836.GD5625@jabba.hq.digizenstudio.com>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 15:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOvYt-0006Y0-Af
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 15:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760283AbZASOz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 09:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761102AbZASOz0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 09:55:26 -0500
Received: from k2smtpout05-01.prod.mesa1.secureserver.net ([64.202.189.56]:58257
	"HELO k2smtpout05-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761077AbZASOzY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 09:55:24 -0500
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2009 09:55:23 EST
Received: (qmail 5726 invoked from network); 19 Jan 2009 14:48:38 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout05-01.prod.mesa1.secureserver.net (64.202.189.56) with ESMTP; 19 Jan 2009 14:48:37 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id A7941100A34;
	Mon, 19 Jan 2009 14:48:37 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WjmjR-iUEMfJ; Mon, 19 Jan 2009 09:48:36 -0500 (EST)
Received: from jabba.hq.digizenstudio.com (ip70-174-182-217.dc.dc.cox.net [70.174.182.217])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTPSA id CC74C10008B;
	Mon, 19 Jan 2009 09:48:36 -0500 (EST)
Received: by jabba.hq.digizenstudio.com (Postfix, from userid 1000)
	id 7680F48E7A; Mon, 19 Jan 2009 09:48:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106362>

On Mon, Jan 19, 2009 at 03:46:41PM +0530, Dilip M wrote:
> Hi,
> 
> ..I recently install GIT on Ubuntu (hardy) box....I am able to use
> 'gitk' only If I do 'sudo'. Without 'sudo' it complains 'repository
> not found'

Do you have a 0027 umask?

http://www.digizenstudio.com/blog/2008/11/09/weird-git-gui-startup-problem/

HTH.
-- 
Jing Xue
