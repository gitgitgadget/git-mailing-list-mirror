From: gerhard.oettl.ml@ogersoft.at
Subject: Re: [user] git-svn and svn cp
Date: Tue, 20 Nov 2007 14:06:04 +0100
Message-ID: <4742DBBC.9000809@ogersoft.at>
References: <47416F68.9070908@ogersoft.at> <20071119162612.GA10122@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 14:04:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuSmD-0006c0-7U
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 14:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757640AbXKTNEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 08:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757696AbXKTNEI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 08:04:08 -0500
Received: from h082218134240.host.wavenet.at ([82.218.134.240]:51066 "EHLO
	h082218134240.host.wavenet.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755714AbXKTNEH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2007 08:04:07 -0500
Received: from [192.168.1.101] (85-124-70-106.work.xdsl-line.inode.at [85.124.70.106])
	(authenticated bits=0)
	by h082218134240.host.wavenet.at (8.13.8/8.13.8/SuSE Linux 0.8) with ESMTP id lAKD3pLf004938
	for <git@vger.kernel.org>; Tue, 20 Nov 2007 14:04:04 +0100
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071119162612.GA10122@soma>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65545>

Eric Wong schrieb:
> gerhard.oettl.ml@ogersoft.at wrote:
>> Does svn-git dont know about lightweight svn copies?

> Older versions of the Perl SVN bindings have a broken do_switch()
> SVN 1.4.4+ has this fix which allows do_switch() to be used

Thanks this sadisfies my question and its time to dive deeper into git 
and git-svn ...


gerhard
