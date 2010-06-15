From: Phillip Susi <psusi@cfl.rr.com>
Subject: No working tree repository
Date: Tue, 15 Jun 2010 13:56:07 -0400
Message-ID: <4C17BEB7.90403@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 20:06:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOaWh-0002qg-6Y
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 20:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555Ab0FOSGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 14:06:14 -0400
Received: from exhub016-1.exch016.msoutlookonline.net ([207.5.72.163]:57684
	"EHLO EXHUB016-1.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755935Ab0FOSGO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 14:06:14 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2010 14:06:13 EDT
Received: from [10.1.1.235] (72.242.190.170) by smtpx16.msoutlookonline.net
 (207.5.72.190) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 15 Jun
 2010 10:56:09 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149213>

I'd like to keep a local copy of the kernel repository mainly for
searching the history.  The working tree uses up nearly 400mb of disk
space that I do not normally need.  How can I remove the working tree,
and keep only the packed repository so I can review the logs, and only
check out a working copy if I actually want to edit or compile the sources?
