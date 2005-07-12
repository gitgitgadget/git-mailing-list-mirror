From: Marc Singer <elf@buici.com>
Subject: Why is there no git-update-cache --modified (aka I give up)
Date: Mon, 11 Jul 2005 22:52:18 -0700
Message-ID: <20050712055218.GA18192@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 12 07:53:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsDhY-000549-Kp
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 07:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVGLFwU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 01:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVGLFwU
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 01:52:20 -0400
Received: from florence.buici.com ([206.124.142.26]:43419 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262376AbVGLFwT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 01:52:19 -0400
Received: (qmail 18280 invoked by uid 1000); 12 Jul 2005 05:52:18 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  # git-diff-cache HEAD

is really nice.  But, do I really have to invoke git-update-cache with
every modified file?  I could write a script to cul the filenames from
git-diff-cache, but I'm having a hard time believing that that is how
others are preparing their commits.
