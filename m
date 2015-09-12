From: Andy <silicon.tao@gmail.com>
Subject: Re: error opening
Date: Sat, 12 Sep 2015 16:17:52 +0000 (UTC)
Message-ID: <loom.20150912T181707-598@post.gmane.org>
References: <CAF2U6N0HzgWK-4D2Ednt46u_R+eL2-2C9g9GpczyAvj+pKv-EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 18:20:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZanXg-0007f9-5P
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 18:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbbILQUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 12:20:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:34666 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbbILQUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 12:20:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZanX2-0006ig-D7
	for git@vger.kernel.org; Sat, 12 Sep 2015 18:20:04 +0200
Received: from ip-62-235-154-205.dsl.scarlet.be ([62.235.154.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:20:04 +0200
Received: from silicon.tao by ip-62-235-154-205.dsl.scarlet.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:20:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.235.154.205 (Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277730>

Is apparently a known issue.

Here is a temp fix : https://github.com/git-for-windows/git/issues/376
