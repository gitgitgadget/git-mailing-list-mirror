X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Documentation/git-commit.txt
Date: Sun, 10 Dec 2006 09:23:56 +0000
Message-ID: <200612100923.56707.alan@chandlerfamily.org.uk>
References: <200612100011.kBA0BuTo028252@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 09:24:19 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <200612100011.kBA0BuTo028252@laptop13.inf.utfsm.cl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33872>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtKuq-0004rA-VQ for gcvg-git@gmane.org; Sun, 10 Dec
 2006 10:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760593AbWLJJYI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 04:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760594AbWLJJYI
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 04:24:08 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:48811 "EHLO home.chandlerfamily.org.uk"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760593AbWLJJYH
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 04:24:07 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1GtKui-0006Co-RW; Sun, 10 Dec 2006 09:24:04 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sunday 10 December 2006 00:11, Horst H. von Brand wrote:
> Alan Chandler <alan@chandlerfamily.org.uk> wrote:
>
> [...]
>
> > How about the following wording here
> >
> > Instead of staging the content of each file immediately after
> > changing it, you can wait until you have completed all the changes
> > you want to make and then use the `-a` option to tell `git commit`
> > to look for all changes to the content it is tracking and commit it
> > automatically. That
>
>                  ^^^^^^^
>                  files
>                  (or "files whose contents")
>
> > is, this example ...
>
> [Yes, git tracks the contents of files, but it also has a list of
> files whose contents it is tracking]

regardless, I think "it" should become "them"

... it is tracking and commit them automatically. 



-- 
Alan Chandler
