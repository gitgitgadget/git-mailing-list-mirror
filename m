From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] merge-one-file: remove empty directories
Date: Sun, 20 Nov 2005 10:08:23 -0800
Message-ID: <4380BB97.7070407@zytor.com>
References: <17279.1674.22992.607091@cargo.ozlabs.ibm.com> <20051119140736.GA24901@lst.de> <Pine.LNX.4.64.0511190957320.13959@g5.osdl.org> <7v4q683qhe.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511200901450.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Christoph Hellwig <hch@lst.de>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sun Nov 20 19:10:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdtcY-00055R-Lg
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 19:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVKTSIz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 13:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVKTSIz
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 13:08:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:60626 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750758AbVKTSIz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 13:08:55 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAKI8Ok5027568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Nov 2005 10:08:25 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511200901450.13959@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12390>

Linus Torvalds wrote:
> 
> Even VMS seems to have it (although if git is ever ported to VMS, I'll 
> just have to shoot myself. I used VMS in -88, and the scars are _still_ 
> fresh).
> 

Yeah, well, WinNT is basically the successor to VMS.  (I have heard from 
several ex-DECers that WNT was done on top of a stolen copy of what was 
supposed-to-have-been the successor to VMS.)

	-hpa
