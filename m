From: "Le" <le_wen@distributel.ca>
Subject: Branch name with space
Date: Tue, 02 Dec 2008 12:34:18 -0500
Message-ID: <4935719A.8000705@distributel.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:50:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ZOH-00028M-GL
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 18:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbYLBRtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 12:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbYLBRtM
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 12:49:12 -0500
Received: from ottexbe01.corp.distributel.ca ([206.80.252.36]:41587 "EHLO
	ottexbe01.corp.distributel.ca" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754144AbYLBRtL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2008 12:49:11 -0500
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Dec 2008 12:49:11 EST
thread-index: AclUpCgyKmKD3oa0TrqUBLjgQySyLg==
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4073
Received: from [192.168.1.46] ([192.168.1.46]) by ottexbe01.corp.distributel.ca with Microsoft SMTPSVC(6.0.3790.3959); Tue, 2 Dec 2008 12:33:57 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8) Gecko/20071008 Iceape/1.1.5 (Ubuntu-1.1.5-1ubuntu0.7.10)
X-OriginalArrivalTime: 02 Dec 2008 17:33:58.0222 (UTC) FILETIME=[282DA6E0:01C954A4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102164>

Hi, there,

I tried to rename a branch to a new name with space in it. It complained :
git-branch -M 'test 1' or test\ 1
fatal: Invalid branch name: refs/heads/test 1

Is there a way the get round this problem?

Thanks!

Le
