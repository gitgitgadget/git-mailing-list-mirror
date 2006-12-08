X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] Allow building GIT in a different directory from the
 source directory
Date: Fri, 08 Dec 2006 19:14:30 +0100
Message-ID: <4579AB86.7060400@xs4all.nl>
References: <elc6j2$vej$1@sea.gmane.org> <elc84p$4cs$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 18:14:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 9
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <elc84p$4cs$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33716>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GskFD-0007OZ-Lg for gcvg-git@gmane.org; Fri, 08 Dec
 2006 19:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760797AbWLHSOn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 13:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760800AbWLHSOn
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 13:14:43 -0500
Received: from main.gmane.org ([80.91.229.2]:60514 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760797AbWLHSOm
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 13:14:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GskF0-0002lD-Gz for git@vger.kernel.org; Fri, 08 Dec 2006 19:14:34 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 08 Dec 2006 19:14:34 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 08 Dec 2006 19:14:34
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:

> Perhaps we should add this to INSTALL file, or to comments in either
> Makefile, or configure.ac?

yes, will do. 

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
