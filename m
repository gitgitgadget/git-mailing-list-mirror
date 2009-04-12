From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2 1/2] Add per-svn-remote ignore-paths config
Date: Sat, 11 Apr 2009 17:59:01 -0700
Message-ID: <20090412005901.GB10656@dcvr.yhbt.net>
References: <1239471978-45479-1-git-send-email-ben@ben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Ben Jackson <ben@ben.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 03:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lso3q-0001Bs-PN
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 03:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbZDLA7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 20:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbZDLA7E
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 20:59:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46159 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213AbZDLA7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 20:59:03 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3F31F7B6;
	Sun, 12 Apr 2009 00:59:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1239471978-45479-1-git-send-email-ben@ben.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116360>

Ben Jackson <ben@ben.com> wrote:
> Signed-off-by: Ben Jackson <ben@ben.com>
> 
> ---
> 
> This version fixes a bug found by Eric Wong (inappropriate cut'n'paste
> use of perl m//o) and extends the test cases to include independent
> tests for command-line and config ignore-paths.

Thanks Ben, this series acked and pushed out to
git://git.bogomips.org/git-svn.git

-- 
Eric Wong
