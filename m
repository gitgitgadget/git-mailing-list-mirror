X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Deepak Barua" <dbbarua@gmail.com>
Subject: Adding spell checker to GIT
Date: Tue, 5 Dec 2006 22:09:53 +0530
Message-ID: <b5a19cd20612050839y30d06e3bk3a718ef29d0e9328@mail.gmail.com>
References: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 16:40:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a76/Mwh3dYPEkykwtP+cNEE4bkvApP0GPsfrdI+ta/4EDBlTLI/KZbThEvEiJ0+Y3S+aq76n02jnfvuSXHvwDDAfGmx7+BE3IyxarpubiIIP5Y++PkywKcjhtd92LM+W6nZL9UF92CpQu4YVp97brNGx5A4ieOXEBff05F1h4GU=
In-Reply-To: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33354>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrdKu-00035L-Li for gcvg-git@gmane.org; Tue, 05 Dec
 2006 17:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968437AbWLEQj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 11:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968440AbWLEQj5
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 11:39:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:45007 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S968437AbWLEQjz (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 11:39:55 -0500
Received: by nf-out-0910.google.com with SMTP id o25so271790nfa for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 08:39:53 -0800 (PST)
Received: by 10.49.36.6 with SMTP id o6mr1091072nfj.1165336793684; Tue, 05
 Dec 2006 08:39:53 -0800 (PST)
Received: by 10.49.11.7 with HTTP; Tue, 5 Dec 2006 08:39:53 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi Jakub & Johannes,
                              Thank you for your help i will consider
the precommit-hook.

Regards
Deepak

---------- Forwarded message ----------
From: Deepak Barua <dbbarua@gmail.com>
Date: Dec 5, 2006 9:35 PM
Subject: Adding spell checker to GIT
To: git@vger.kernel.org


Hi All,
        I am just thought of a idea to integrate a spell checker with
git so that when we check in the code the code comments are spell
checked before being put into the tree,maybe have a optimized
dictionary search.
what about this...? is it appropriate ...?

Regards
Deepak

--
Code Code Code Away


-- 
