From: Junio C Hamano <junkio@cox.net>
Subject: [Announce] GIT v0.99.4
Date: Fri, 12 Aug 2005 03:28:41 -0700
Message-ID: <7vzmrn1mau.fsf@assigned-by-dhcp.cox.net>
References: <7v64udqtt0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 12 12:31:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3WnR-00021l-6n
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 12:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVHLK2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 06:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVHLK2o
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 06:28:44 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:21156 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932104AbVHLK2n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 06:28:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812102842.RCJA550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 06:28:42 -0400
To: git@vger.kernel.org
In-Reply-To: <7v64udqtt0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 10 Aug 2005 16:02:51 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In http://www.kernel.org/pub/software/scm/git/, I have placed
the following binary packages:

   git-core-0.99.4.tar.gz
   git-core-0.99.4-1.i386.rpm
   git-core-0.99.4-1.src.rpm
   git-core-debuginfo-0.99.4-1.i386.rpm
   debian/git-core_0.99.4-2.dsc
   debian/git-core_0.99.4-2.tar.gz
   debian/git-core_0.99.4-2_i386.deb
        
Are people interested in seeing these binary packages?  How
about binary packages for platforms other than i386?

If yes, I would need some help generating them.  Before anybody
asks, no, I am not planning to do binary package every time I
push to the "master" branch --- I am only talking about tagged
releases.

On the other hand, if there are not much demand for them, I
would stop bothering.  I am hoping that I could just stop
generating binary packages once major distributions pick up
git-core themselves, so this is an interim request, but
presumably people who volunteer would be the perfect candidates
for the port maintainers for those distributions.
