From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Testing for a merge conflict without a working copy
Date: Tue, 21 Sep 2010 08:45:16 -0600
Message-ID: <4C98C4FC.1080904@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 21 16:45:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy466-0002wS-VL
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 16:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163Ab0IUOpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 10:45:25 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:40772 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab0IUOpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 10:45:24 -0400
Received: (qmail 18721 invoked by uid 399); 21 Sep 2010 08:45:22 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.196.198.56)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Sep 2010 08:45:22 -0600
X-Originating-IP: 75.196.198.56
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100825 Lightning/1.0b3pre Thunderbird/3.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156726>

  If I simply want to determine whether a merge would conflict, is there 
a way to do it without a working copy?

Thanks!

Josh
