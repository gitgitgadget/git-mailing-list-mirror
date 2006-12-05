X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Adding spell checker to GIT
Date: Tue, 5 Dec 2006 21:35:33 +0530
Message-ID: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 16:05:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m9LKcQZ7pXhPEqBI/lDqR3r4Kz4A4BGZ6UPAlDhIL3pcwCM4SbC1/beZhND2Qsl//bC7MtJK3HwAiaCNenqzTT4bK6nBVNugp3O6pRisw5R5llARiI8dwVEHg/ungA0dbQKa0L7xwKxhAgWjljBh86aa62fKGg+3X+0H5XZGPkE=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33351>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grcnf-0005o2-OZ for gcvg-git@gmane.org; Tue, 05 Dec
 2006 17:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968396AbWLEQFg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 11:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968401AbWLEQFg
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 11:05:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:5848 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S968396AbWLEQFf (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 11:05:35 -0500
Received: by nf-out-0910.google.com with SMTP id o25so261998nfa for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 08:05:34 -0800 (PST)
Received: by 10.49.107.3 with SMTP id j3mr1004452nfm.1165334733539; Tue, 05
 Dec 2006 08:05:33 -0800 (PST)
Received: by 10.49.11.7 with HTTP; Tue, 5 Dec 2006 08:05:33 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi All,
         I am just thought of a idea to integrate a spell checker with
git so that when we check in the code the code comments are spell
checked before being put into the tree,maybe have a optimized
dictionary search.
what about this...? is it appropriate ...?

Regards
Deepak

-- 
