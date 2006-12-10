X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [ANNOUNCE] CGit v0.1-pre
Date: Mon, 11 Dec 2006 00:42:34 +0100
Message-ID: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 23:42:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fjeytyp3dyfvrzmsu2FktyUz6u85eOliEpOZiudD0W58D77o3qqDPzuA+jHYfGIJ9t2E8uOFHUroW/vokUbkpmfwPocRbd1gL6N0g0Yb4vU8gf0dFvBVj+ODOnYroaoK4NKoy3cjO69VITdGjnxBpclZoBXm5RTlFEkOEouG3c4=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33964>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtYJb-000187-Kp for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759854AbWLJXmg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 18:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762540AbWLJXmg
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 18:42:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:8335 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1759854AbWLJXmg (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 18:42:36 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1815779nfa for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 15:42:34 -0800 (PST)
Received: by 10.82.127.15 with SMTP id z15mr222905buc.1165794154305; Sun, 10
 Dec 2006 15:42:34 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Sun, 10 Dec 2006 15:42:34 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

CGit is another cgi-app for git.

It is written in C (using libgit.a), and implements an internal page
cache. A PoC version is available for cloning at

  git://hjemli.net/pub/git/cgit

and it is also (barely) selfhosted at

  http://hjemli.net/git/


For a quick summary of the cache algorithm, the project README is here:

  http://hjemli.net/git/cgit/view/?id=5917c37ce30b3f0a374c9fa376955f51f1d7bfbf

Enjoy!

-- 
