From: Arnaud Bailly <abailly@oqube.com>
Subject: Gitweb linking to bug-tracking system
Date: Tue, 08 Sep 2009 10:26:56 +0200
Organization: OQube
Message-ID: <85ab15n8of.fsf@oqube.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 10:27:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkw32-0002mU-7Y
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 10:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbZIHI1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 04:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbZIHI1W
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 04:27:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:56901 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbZIHI1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 04:27:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mkw2r-0002jg-F9
	for git@vger.kernel.org; Tue, 08 Sep 2009 10:27:21 +0200
Received: from 80.125.172.55 ([80.125.172.55])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 10:27:21 +0200
Received: from abailly by 80.125.172.55 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 10:27:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80.125.172.55
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Cancel-Lock: sha1:dgVNoUMc47dVkHmO57KQF5EfTxo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 7.0 points;
 *  0.0 RCVD_BY_IP Received by mail server with no name
 *  4.0 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  3.0 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in bl.spamcop.net
 *      [Blocked - see <http://www.spamcop.net/bl.shtml?80.125.172.55>]
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127991>

HEllo,
I have installed gitweb using git version 1.6.3.3 on ubuntu, and
everything is working perfectly. 
However, when a commit have a comment containing a string matching
"DEF[0-9]+", an hyperlink is generated on the web interface which makes
me think it is possible to link to some DTS. Yet I cannot find how to
configure this ? 

Am I missing something ? Is this totally unrelated to DTS ?

Regards,

-- 
Arnaud Bailly -- OQube
<software engineering>
http://www.oqube.com/
