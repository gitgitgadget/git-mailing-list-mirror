From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 20:47:59 -0700
Message-ID: <4272FFEF.2090701@zytor.com>
References: <200504292314.j3TNE1P23342@unix-os.sc.intel.com>	<200504300021.j3U0La023762@unix-os.sc.intel.com> <20050430052318.1bd4b189.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: tony.luck@intel.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 05:42:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRis6-00088M-P7
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 05:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVD3DsI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 23:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVD3DsI
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 23:48:08 -0400
Received: from terminus.zytor.com ([209.128.68.124]:8642 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262493AbVD3DsG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 23:48:06 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3U3lxqe019915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Apr 2005 20:48:00 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Edgar Toernig <froese@gmx.de>
In-Reply-To: <20050430052318.1bd4b189.froese@gmx.de>
X-Spam-Status: No, score=-5.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Edgar Toernig wrote:
> 
> Another dependency :-(   I can live without http-pull but not
> without commit-tree.
> 

Then feel free to rip curl_getdate out of the libcurl sources and making 
them standalone.

	-hpa
