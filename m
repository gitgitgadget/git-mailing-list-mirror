X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: StGit repo & gitweb, was Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Thu, 14 Dec 2006 00:57:01 +0100
Organization: At home
Message-ID: <elq3ro$93b$2@sea.gmane.org>
References: <20061207101707.GA19139@spearce.org> <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgog0r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612131232270.3635@wbgn013.biozentrum.uni-wuerzburg.de> <b0943d9e0612131409x4a894f72if9c4d44cfa970be@mail.gmail.com> <Pine.LNX.4.63.0612140048120.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 13 Dec 2006 23:55:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34267>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudwT-0004O9-J0 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751774AbWLMXzN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWLMXzN
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:55:13 -0500
Received: from main.gmane.org ([80.91.229.2]:38945 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751772AbWLMXzM
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:55:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GudwE-00037A-8i for git@vger.kernel.org; Thu, 14 Dec 2006 00:55:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 00:55:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006
 00:55:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

>> BTW, how can I notify people that only pull from the http repository 
>> that it will no longer be updated (rather than them thinking the 
>> development stopped)? One solution would be to create a file with a 
>> meaningful name in the top dir and hope people will notice it.
> 
> IMHO removing it altogether would be a good idea. The website should carry 
> the news of the new repository site.

By the way, would setting http-alternates help? I guess not, not without
having refs copied from the other place...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

