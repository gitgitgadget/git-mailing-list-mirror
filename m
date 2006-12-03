X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: jgit performance update
Date: Sun, 3 Dec 2006 16:53:02 +0100
Organization: Dewire
Message-ID: <200612031653.04019.robin.rosenberg.lists@dewire.com>
References: <20061203045953.GE26668@spearce.org> <200612031455.48032.robin.rosenberg.lists@dewire.com> <ekumdo$imo$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 15:51:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <ekumdo$imo$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33114>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqtcl-0002AD-6Y for gcvg-git@gmane.org; Sun, 03 Dec
 2006 16:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753226AbWLCPuu convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 10:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbWLCPuu
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 10:50:50 -0500
Received: from [83.140.172.130] ([83.140.172.130]:59145 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1753226AbWLCPut convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 10:50:49
 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 397A9802A94; Sun,  3 Dec 2006 16:47:01 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 14737-08; Sun,  3 Dec
 2006 16:47:01 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id EAEC9800199; Sun,  3 Dec 2006 16:46:58 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

s=F6ndag 03 december 2006 15:19 skrev Jakub Narebski:
> Robin Rosenberg wrote:
> > CVS-induced brain damage, I should track the content. next version.
> > filenames are so much handier to work with).
>
> Git uses <path> as _revision limiter_, not as output filter. Shouldn'=
t
> jgit do the same?
It's egit, i.e. the eclipse plugin I'm referring to so it's a user inte=
rface=20
thing and it uses the path name. =20

