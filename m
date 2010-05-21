From: Andrew Keller <andrew@kellerfarm.com>
Subject: Changing indents
Date: Fri, 21 May 2010 12:01:25 -0400
Message-ID: <C0CDDC0A-A813-41C3-8CEC-40EFADFB5A4A@kellerfarm.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 21 18:01:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUfV-00022W-Gc
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 18:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933811Ab0EUQBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 12:01:37 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:44770 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758284Ab0EUQBf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 12:01:35 -0400
Received: from 13-141-14.client.wireless.msu.edu ([35.13.141.14])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1OFUf4-0001Ju-S5
	for git@vger.kernel.org; Fri, 21 May 2010 12:01:22 -0400
X-Mailer: Apple Mail (2.1078)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147474>

Is it possible to change the indent of a line (or multiple lines) without rewriting the whole line?  Or, more specifically, can a commit exist that modifies the leading whitespace of a line but still allows you to trace the origin of the line to a previous commit?

Thanks,
Andrew Keller
