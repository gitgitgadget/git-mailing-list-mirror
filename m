X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH (amend)] gitweb: Slight visual improvements to commitdiff view
Date: Thu, 26 Oct 2006 16:34:39 -0700 (PDT)
Message-ID: <20061026233439.37073.qmail@web31811.mail.mud.yahoo.com>
References: <200610261843.10529.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 26 Oct 2006 23:34:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EHD1bEj/eLgMN2iLY/pp0JvXoUeIaGna5ppmzbxu/FdMP8Hb164MaWKtDGY0iPaxn3X0oaEQ5IhNZIfucJNf3e9504sdiY46+2Lijs5e2Gf2RvN/ehLtTVzk3jrqnealewSFB+H6eOIxUVgWGRa8M2rOAkWcXjUo/ZfaeUa3O9Y=  ;
X-YMail-OSG: KMJkWsgVM1khLylo20CeiGSBwAONYiM05FF3LrKcTRXexS0nZTE0DsU39kuGdKktKvEp6cub_1jAbl4ohU9Zj0EqACWo8tKgl8ExscNDBva9uqzB20Jhyg9HtOadsE3LSZZ3VoxjMA--
In-Reply-To: <200610261843.10529.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30266>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdEkM-0008Cb-OB for gcvg-git@gmane.org; Fri, 27 Oct
 2006 01:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1945993AbWJZXel (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945994AbWJZXel
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 19:34:41 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:28771 "HELO
 web31811.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1945993AbWJZXek (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 19:34:40 -0400
Received: (qmail 37075 invoked by uid 60001); 26 Oct 2006 23:34:39 -0000
Received: from [64.215.88.90] by web31811.mail.mud.yahoo.com via HTTP; Thu,
 26 Oct 2006 16:34:39 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Can you please explain what both patches actually do?

"slight visual improvements to commitdiff view" leaves
much, _much_ to be desired and is hardly a commit message
suitable to live in git.git.

Please describe what you found objectionable, why, how
you decided to fix it and why you decided to fix it that way.

Thanks,
   Luben
