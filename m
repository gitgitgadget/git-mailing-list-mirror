From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] Add 'git svn help [cmd]' which works outside a
	repo.
Date: Wed, 3 Jun 2009 19:48:39 -0700
Message-ID: <20090604024839.GB19622@dcvr.yhbt.net>
References: <1243732627-82282-1-git-send-email-ben@ben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Jackson <ben@ben.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 04:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC30Z-0004cm-9q
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 04:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbZFDCsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 22:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbZFDCsi
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 22:48:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35307 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271AbZFDCsi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 22:48:38 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173711F7D1;
	Thu,  4 Jun 2009 02:48:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1243732627-82282-1-git-send-email-ben@ben.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120674>

Ben Jackson <ben@ben.com> wrote:
> Previously there was no explicit 'help' command, but 'git svn help'
> still printed the usage message (as an invalid command), provided you
> got past the initialization steps that required a valid repo.
> 
> Signed-off-by: Ben Jackson <ben@ben.com>
> ---
> 
> This was just a minor nit I noticed while working on the 'git-svn reset'
> patch.

Thanks Ben,

Acked and pushed out to git://git.bogomips.org/git-svn

-- 
Eric Wong
