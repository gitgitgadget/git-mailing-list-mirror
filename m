X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: git-PS1 bash prompt setting
Date: Sun, 26 Nov 2006 16:05:23 +0100
Message-ID: <20061126150523.GB18828@hermes.lan.home.vilz.de>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE> <Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de> <20061126094212.fde8cce7.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 15:06:18 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Content-Disposition: inline
In-Reply-To: <20061126094212.fde8cce7.seanlkml@sympatico.ca>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32350>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoLa9-0002JP-Ov for gcvg-git@gmane.org; Sun, 26 Nov
 2006 16:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935416AbWKZPF4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 10:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935420AbWKZPF4
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 10:05:56 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:43270 "EHLO
 vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP id
 S935416AbWKZPFz (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006
 10:05:55 -0500
Received: from localhost (localhost [127.0.0.1]) by
 vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 179673E6A; Sun, 26
 Nov 2006 16:05:51 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1]) by localhost
 (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M4WvpksDSJzY; Sun, 26 Nov 2006 16:05:29 +0100 (CET)
Received: from localhost (hermes.lan.home.vilz.de [192.168.100.26]) (using
 TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id
 E501D3E67; Sun, 26 Nov 2006 16:05:27 +0100 (CET)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On Sun, Nov 26, 2006 at 09:42:12AM -0500, Sean wrote:
> On Sun, 26 Nov 2006 15:27:07 +0100 (CET)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > But there really is no good place to put it: most commands need a git 
> > repository, and those which do not, are inappropriate to put an option 
> > "--show-ps1" into. Except maybe repo-config. Thoughts?
> 
> What about just making it an option to the git wrapper?

I glued that in my system bashrc with the extension, that it shows to me
user.email out of repo-config, which is also very handy. So I am always
reminded to set my user.credentials in .git/config and i always know which 
role i play in the repository i am working at.

