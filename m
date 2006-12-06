X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Fwd: git pull and merging.
Date: Wed, 6 Dec 2006 16:18:52 +0530
Message-ID: <cc723f590612060248jb151a75y9e9ea316f1c6086f@mail.gmail.com>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	 <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net>
	 <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com>
	 <Pine.LNX.4.63.0612061019350.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	 <cc723f590612060205p1fd26cd7u3c7efc723b0177de@mail.gmail.com>
	 <el65rh$tfj$3@sea.gmane.org>
	 <cc723f590612060236k7839942el8d048eedfdee3682@mail.gmail.com>
	 <cc723f590612060248y6f730a54l3a2aadfa6500d36d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 10:49:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DGU9WYI4ZFYltyo9LxnD4379Df4nQC/fWuqstriqWHpDUHpYIJE/EYteDEPDKiQu46JwGLdatjK0gBcfyakefMNy63oJ0qMgtVGlsyzYzpjnVvEt9nAs1eP7rSpG03jaKSeh7JpfY0NzrNqfEW89PsXDG6wIDtj76YM0bBGh84g=
In-Reply-To: <cc723f590612060248y6f730a54l3a2aadfa6500d36d@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33433>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GruKl-0005Qe-8J for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760478AbWLFKsz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760479AbWLFKsz
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:48:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:32001 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760480AbWLFKsy (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 05:48:54 -0500
Received: by nf-out-0910.google.com with SMTP id o25so518080nfa for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 02:48:53 -0800 (PST)
Received: by 10.48.216.8 with SMTP id o8mr1978517nfg.1165402132762; Wed, 06
 Dec 2006 02:48:52 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Wed, 6 Dec 2006 02:48:52 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

After printing some debug echo i got this one which seems to be working for me

[branch "devel"]
        remote = origin
