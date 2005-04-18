From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another base64 patch
Date: Mon, 18 Apr 2005 16:23:18 +1000
Message-ID: <42635256.7020701@zytor.com>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org> <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org> <425E0D62.9000401@zytor.com> <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org> <425EA152.4090506@zytor.com> <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org> <20050414191157.GA27696@outpost.ds9a.nl> <425EC3B4.6090908@zytor.com> <20050414214756.GA31249@outpost.ds9a.nl> <Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org> <425F1394.5020709@zytor.com> <Pine.LNX.4.62.0504162107040.22904@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, bert hubert <ahu@ds9a.nl>,
	Christopher Li <git@chrisli.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 08:19:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNPbr-0007mz-N8
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 08:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVDRGXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 02:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVDRGXq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 02:23:46 -0400
Received: from terminus.zytor.com ([209.128.68.124]:24717 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261757AbVDRGXp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 02:23:45 -0400
Received: from [192.168.1.102] ([150.203.164.151])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3I6NPmp007955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 17 Apr 2005 23:23:28 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0504162107040.22904@qynat.qvtvafvgr.pbz>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Lang wrote:
> 
> note that default configs of ext2 and ext3 don't qualify as sane 
> filesystems by this definition.

Not using dir_index *IS* insane.

	-hpa
