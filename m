X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: git cygwin package?
Date: Fri, 3 Nov 2006 15:50:57 +0100
Message-ID: <20061103145057.GB31349@fiberbit.xs4all.nl>
References: <2495.145.36.45.123.1162557826.squirrel@www.dspsrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Date: Fri, 3 Nov 2006 14:53:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <2495.145.36.45.123.1162557826.squirrel@www.dspsrv.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30858>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg0Nw-0000Fz-3s for gcvg-git@gmane.org; Fri, 03 Nov
 2006 15:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753259AbWKCOvD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 09:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbWKCOvD
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 09:51:03 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:11661 "EHLO
 fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1753259AbWKCOvB (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 09:51:01 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
 (envelope-from <marco.roeland@xs4all.nl>) id 1Gg0Nl-0008Bi-9m; Fri, 03 Nov
 2006 15:50:57 +0100
To: Tim O Callaghan <timo@dspsrv.com>
Sender: git-owner@vger.kernel.org

On Friday November 3rd 2006 at 12:43 Tim O Callaghan wrote:

> Its not just git that needs to be added to cygwin, Asciidoc and a few other tools (i have a list
> somewhere) would also need to be packaged for cygwin too, because the package system re-builds
> their binaries from source for distribution.

Debian has split git into different packages to avoid unnessary
dependencies if you don't need them. Might be a good idea for Cygwin.

A 'git-core' package for Cygwin would already be of great use. The
documentation can then for example be fetched from the respective
documentation branches in the git repository.
-- 
