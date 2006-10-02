From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Mon, 02 Oct 2006 09:15:16 +0200
Message-ID: <4520BC84.5090800@op5.se>
References: <efc2no$eti$2@sea.gmane.org> <200610012041.15296.jnareb@gmail.com> <7vd59b27c4.fsf@assigned-by-dhcp.cox.net> <200610012127.37113.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Luben Tuikov <ltuikov@yahoo.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 09:15:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUI1L-0003Cr-QO
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 09:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbWJBHPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 03:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWJBHPU
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 03:15:20 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:34754 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932715AbWJBHPT
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Oct 2006 03:15:19 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 4A79F6BD76; Mon,  2 Oct 2006 09:15:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 1ED3A6BD74; Mon,  2 Oct 2006 09:15:17 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610012127.37113.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28218>

Jakub Narebski wrote:
> Junio C Hamano wrote:
> 
>> Doesn't leading drwxr-xr-x mean anything?
> 
> Neither d in drwxr-xr-x, nor trailing / in the name are significant
> enough indicators of directory vs file (tree vs blob) indicator,
> especially that by default git-ls-tree output mixes trees with blobs.
>  

I beg to differ. The trailing slash would indeed help, as peoples eyes 
are generally focused on the mouse-pointer rather than some 5-10" to the 
left of it. If we're worrying that windows folks use \ for 
path-delimiter, I think they'll pick up the difference quick enough.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
