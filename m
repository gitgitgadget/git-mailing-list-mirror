X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: GIT - releases workflow
Date: Tue, 12 Dec 2006 16:44:23 -0600
Message-ID: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 22:44:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i1TI7rEJ49c4wUdYBrTTd0yGtb5LspIWeUZPBY+YxaPNqeGb74RBpky6PoLwoRizS53l2LAw67DZXDNOLqDWERsxYujnJLSqy1J7VAIm+V3UdSGQEmUfG52SzjiHlGI7MRe8F+fYupmt2/uWTK/jqMFk20YEgdwEBJd5Npa9J4I=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34154>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGMO-00070M-Rs for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932512AbWLLWo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWLLWo0
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:44:26 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:3830 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932512AbWLLWoZ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 17:44:25 -0500
Received: by wr-out-0506.google.com with SMTP id i7so2201882wra for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 14:44:25 -0800 (PST)
Received: by 10.78.178.5 with SMTP id a5mr59746huf.1165963463831; Tue, 12 Dec
 2006 14:44:23 -0800 (PST)
Received: by 10.78.179.10 with HTTP; Tue, 12 Dec 2006 14:44:23 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I was wondering if anyone could share ideas on how best to use GIT to
handle releases for those working with a remote GIT repository?  Do
you create a branch and push it to the remote?  Thus you have a new
branch referencing the particular release?

Sean

-- 
