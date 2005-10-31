From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild
 bug)
Date: Mon, 31 Oct 2005 07:57:30 -0800
Message-ID: <43663EEA.5050102@zytor.com>
References: <43652934.8000308@zytor.com> <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net> <20051031064105.GV8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 17:00:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWc2k-0000fP-BG
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 16:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVJaP5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 10:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVJaP5v
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 10:57:51 -0500
Received: from terminus.zytor.com ([192.83.249.54]:20185 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932289AbVJaP5u
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 10:57:50 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9VFvUbD029348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 31 Oct 2005 07:57:31 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20051031064105.GV8041@shell0.pdx.osdl.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10860>

Chris Wright wrote:
> 
> It's fine for FC3.  Certain irony that git now effectively requires
> subversion.  I'm all for splitting these out, but have no time until
> later in the week.  BTW, mind pushing the tag?
> 

The git-core RPM definitiely needs to be split.  Doubly ironic that it's 
called "core".

	-hpa
