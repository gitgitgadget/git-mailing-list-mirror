From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Add history and blame to git_difftree_body()
Date: Mon, 2 Oct 2006 12:32:17 -0700 (PDT)
Message-ID: <20061002193217.86165.qmail@web31814.mail.mud.yahoo.com>
References: <efor2e$d0i$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Oct 02 21:34:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUTWb-00025Q-MJ
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 21:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965378AbWJBTcU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 15:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965382AbWJBTcU
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 15:32:20 -0400
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:22664 "HELO
	web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965378AbWJBTcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 15:32:18 -0400
Received: (qmail 86167 invoked by uid 60001); 2 Oct 2006 19:32:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=n/w9SAw8amldhVHBBBEJX8RHdYjgMSZwrYJAqDCOzEM9OufhTie9s8DKZCv9eBmJsRArVTrchQpxkVyvbYhL2SYv7Hdz8Te6U6qsLc/z6VCPyiB0c9A0HMreBW+6ofE0yUFyi8ur0j9vNMbna461I08I5D6QeXjEWt2QTBm0j5o=  ;
Received: from [64.215.88.90] by web31814.mail.mud.yahoo.com via HTTP; Mon, 02 Oct 2006 12:32:17 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <efor2e$d0i$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28230>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Luben Tuikov wrote:
> 
> > Add blame and history to Deleted files.
> > Add blame and history to Modified or Type changed files.
> > Add blame and history to Renamed or Copied files.
> 
> Blame has to be added conditionally (gitweb_have_blame).

Can you please not edit the CC field when you reply?
I can see that only the GIT mailing list was left,
but my email had been removed.

Thanks,
   Luben
