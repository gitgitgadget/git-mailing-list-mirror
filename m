From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] format-patch: Use --mbox by default.
Date: Sun, 08 Jan 2006 14:14:57 -0800
Message-ID: <43C18EE1.4050807@zytor.com>
References: <20060108140109.909925BE8D@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 08 23:15:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eviog-00032V-NO
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 23:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbWAHWPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 17:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWAHWPG
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 17:15:06 -0500
Received: from terminus.zytor.com ([192.83.249.54]:13538 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161223AbWAHWPF
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 17:15:05 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k08MEvCL004416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 8 Jan 2006 14:14:57 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <20060108140109.909925BE8D@nox.op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14337>

Andreas Ericsson wrote:
> 
> The patches generated also had bad mail headers for sendmail (of
> postfix 2.2.2 at least) to use directly (From: line must be on top,
> Subject: last of header)

Sounds like a bug report against postfix is in order.

	-hpa
