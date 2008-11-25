From: Gary Yang <garyyang6@yahoo.com>
Subject: How to hide a git repository?
Date: Mon, 24 Nov 2008 16:32:58 -0800 (PST)
Message-ID: <962463.96236.qm@web37905.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 01:34:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4lsf-0000s9-W1
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 01:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbYKYAdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 19:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbYKYAdA
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 19:33:00 -0500
Received: from web37905.mail.mud.yahoo.com ([209.191.91.167]:42782 "HELO
	web37905.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752546AbYKYAdA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 19:33:00 -0500
Received: (qmail 96282 invoked by uid 60001); 25 Nov 2008 00:32:59 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=pNSTs5FrpyJYGn5gz4ZCoIqhdz5DpSguIDbHYKzQn9GFvos/AJoQx0lqrvoP5oAYBdwHK1Pk5Mh/fotXahWc8qqxb4QuTAqyhWMaVSlbK0576eUQztUozdlqQh4dS8vHrIMVk09FzD9qmSNe1VW9yU83kcbE0o9ukG+kg5sKxaY=;
X-YMail-OSG: WnSpuj8VM1mbKVTFG43bhdSW8sBu9BQMz.VqovSTjMEPiKFdLP84sw6UaYk3LL2GOJECjHj35d6hlyg1LdCzrlt0g1h0idEto2dh.X7F32cxpXfYt.mxnOhoGD0xP0zpAELpEPVS5b5O.vJsAru413sYPnbasQMt1aPibQ2A
Received: from [76.195.33.70] by web37905.mail.mud.yahoo.com via HTTP; Mon, 24 Nov 2008 16:32:58 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101637>


We have two repositories, one is /pub/git/dev/linux/kernel, another is /pub/git/pub/linux/kernel. The /pub/git/pub/linux/kernel is open to public for people to download released code. /pub/git/dev/linux/kernel is used for our development. We would like to hide /pub/git/dev/linux/kernel from public. How to do it?

Why we want to hide /pub/git/dev/linux/kernel from public?
We work on our development at /pub/git/dev/linux/kernel. We push our released code to /pub/git/pub/linux/kernel from /pub/git/dev/linux/kernel once we completed our development.  We do not want people to download code from /pub/git/dev/linux/kernel since it is not stable.  






      
