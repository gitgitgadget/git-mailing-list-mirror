X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command for reverting all patches below particular commit
Date: Thu, 09 Nov 2006 11:27:28 +0100
Organization: At home
Message-ID: <eiuvop$1gt$1@sea.gmane.org>
References: <4552FE43.7020804@calsoftinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 9 Nov 2006 10:27:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 13
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31192>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi77k-0003dj-2J for gcvg-git@gmane.org; Thu, 09 Nov
 2006 11:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754795AbWKIK1E (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 05:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754796AbWKIK1E
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 05:27:04 -0500
Received: from main.gmane.org ([80.91.229.2]:397 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1754795AbWKIK1B (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 05:27:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gi77I-0003Zm-T1 for git@vger.kernel.org; Thu, 09 Nov 2006 11:26:41 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 11:26:40 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 09 Nov 2006
 11:26:40 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Umesh Deshpande wrote:

> Hi,
> I want to revert a particular commit, but because of dependency issues I 
> am not able to do so. The revert operation fails.

Cannot you resolve conflicts during revert, and commit resolved result
as revert of a commit?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

