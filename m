From: Miles Bader <miles@gnu.org>
Subject: set-upstream for existing branch...?
Date: Thu, 17 Feb 2011 14:19:11 +0900
Message-ID: <buoei77xmpc.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 06:19:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpwH8-0007Mq-Ez
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 06:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660Ab1BQFTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 00:19:21 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:58166 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1BQFTU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 00:19:20 -0500
Received: from mailgate3.nec.co.jp ([10.7.69.160])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p1H5JDOc003749;
	Thu, 17 Feb 2011 14:19:13 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id p1H5JDK17732; Thu, 17 Feb 2011 14:19:13 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.50])
	by vgate01.nec.co.jp (8.14.4/8.14.4) with ESMTP id p1H5FGaG008326;
	Thu, 17 Feb 2011 14:19:12 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay21.aps.necel.com with ESMTP; Thu, 17 Feb 2011 14:19:12 +0900
Received: from dhlpc061 ([10.114.96.71] [10.114.96.71]) by relay21.aps.necel.com with ESMTP; Thu, 17 Feb 2011 14:19:12 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 5206B52E1DB; Thu, 17 Feb 2011 14:19:12 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167042>

Is there a convenient, intuitive, way to set (or change) @{upstream} for
the current branch, without doing anything else...?

Thanks,

-Miles

-- 
Run away!  Run away!
