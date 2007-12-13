From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: [egit] How-to use egit
Date: Wed, 12 Dec 2007 21:47:35 -0500
Message-ID: <20071213024735.GB7492@fawkes>
References: <476032A2.9010308@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 03:48:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2e7P-0001KX-SL
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 03:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbXLMCrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 21:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbXLMCrn
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 21:47:43 -0500
Received: from k2smtpout01-02.prod.mesa1.secureserver.net ([64.202.189.89]:52264
	"HELO k2smtpout01-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751407AbXLMCrm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 21:47:42 -0500
Received: (qmail 18460 invoked from network); 13 Dec 2007 02:47:42 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout01-02.prod.mesa1.secureserver.net (64.202.189.89) with ESMTP; 13 Dec 2007 02:47:42 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 2A40B100099;
	Thu, 13 Dec 2007 02:47:42 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lT6RlTgipInW; Wed, 12 Dec 2007 21:47:36 -0500 (EST)
Received: from fawkes.hq.digizenstudio.com (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id A697A100A37;
	Wed, 12 Dec 2007 21:47:36 -0500 (EST)
Received: by fawkes.hq.digizenstudio.com (Postfix, from userid 1000)
	id 986999ACFB; Wed, 12 Dec 2007 21:47:35 -0500 (EST)
Mail-Followup-To: Wink Saville <wink@saville.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <476032A2.9010308@saville.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68113>

On Wed, Dec 12, 2007 at 11:12:34AM -0800, Wink Saville wrote:
> Robin et. al,
>
>
> I cloned egit from git://repo.or.cz/egit and imported it into my workspace
> following the instructions in INSTALL I did successfully compile although
> there were 1115 warnings but no compilation errors.
>
> I then exported to a archive org.spearce.egit.jar and then copied this file
> to /usr/eclipse/plugin/ I then restarted Eclipse. But I don't see any 
> evidence

I have five jars:

/opt/eclipse/plugins$ ll org.spearce*
-rw-r----- 1 jingxue jingxue 2.5K 2007-12-01 20:45 org.spearce.egit_0.3.0.200712020145.jar
-rw-r----- 1 jingxue jingxue  70K 2007-12-01 20:45 org.spearce.egit.core_0.3.0.200712020145.jar
-rw-r----- 1 jingxue jingxue  14K 2007-12-01 20:45 org.spearce.egit.core.test_0.3.0.200712020145.jar
-rw-r----- 1 jingxue jingxue 107K 2007-12-01 20:45 org.spearce.egit.ui_0.3.0.200712020145.jar
-rw-r----- 1 jingxue jingxue 223K 2007-12-01 20:45 org.spearce.jgit_0.3.0.200712020145.jar

Did you select all the org.spearce projects before exporting?

-- 
Jing Xue
