X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: exclude in diff
Date: Wed, 1 Nov 2006 14:39:55 -0800 (PST)
Message-ID: <38936.67721.qm@web31811.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 1 Nov 2006 22:40:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=lSwWRLGOJk8rSGVdTZRtLYFalJhtZggffX/QJftC4dggZij4kBGQXLjqT7bBogU4gI/MNStuZDNyaFG9PlqQuBiBZXblVrFfImTR9/qbwsvBJ2PpVltGfywkNQXAxZ/+zdtaFpRtuGf9ET65At7OA090FY11kU4s3kmQl2XXH50=  ;
X-YMail-OSG: quvUvLMVM1mme_g7wWf301cqAzWKQ1X1Xz0D98epkJVabA2Q.AmJl1r4liA_gsSCCgcYAqHv9VtgcXh6zYHlQdtLyz4E9iCeOVgAsSL18AYYdg--
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30672>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfOka-0004AG-GO for gcvg-git@gmane.org; Wed, 01 Nov
 2006 23:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752532AbWKAWj4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 17:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbWKAWj4
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 17:39:56 -0500
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:22706 "HELO
 web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1752528AbWKAWj4 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006
 17:39:56 -0500
Received: (qmail 68690 invoked by uid 60001); 1 Nov 2006 22:39:55 -0000
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Wed,
 01 Nov 2006 14:39:55 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

Anyone up for adding -x and -X (--exclude and --exclude-from) options
to git-diff and friends?

Thanks,
   Luben
