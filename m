From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: delay term initialization
Date: Sun, 14 Sep 2014 08:07:30 +0000
Message-ID: <20140914080730.GA6089@dcvr.yhbt.net>
References: <1410681849-3107-1-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 10:07:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT4qc-0006qd-Uk
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbaINIHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 04:07:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51547 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbaINIHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:07:30 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8865844C00A;
	Sun, 14 Sep 2014 08:07:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1410681849-3107-1-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257002>

Eric Wong <normalperson@yhbt.net> wrote:
> On my Debian 7 system, this gives annoying warnings when the output

s/gives/fixes/
