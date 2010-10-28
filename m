From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: How to publish a local initilized repository?
Date: Thu, 28 Oct 2010 13:42:05 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4CC9618D.7000702@atlas-elektronik.com>
References: <4CC95DBC.6080805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Quaas <michaelquaas@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 28 13:42:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBQrw-0000VT-QC
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 13:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0J1LmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 07:42:03 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:55928 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab0J1LmB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 07:42:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 9063A10064;
	Thu, 28 Oct 2010 13:42:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Le5RdoUSIgi6; Thu, 28 Oct 2010 13:42:00 +0200 (CEST)
Received: from mgsrv01.atlas.de (unknown [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 28 Oct 2010 13:41:58 +0200 (CEST)
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 0C0B02717C;
	Thu, 28 Oct 2010 13:41:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <4CC95DBC.6080805@web.de>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160172>

On 10/28/2010 1:25 PM, Michael Quaas wrote:
> Hello,
> 
> I have local repository initialized with git-init. Now I want to share 
> this with others through a repository server. How is the best way to do 
> this? Proberly I can't just push it on the server, can I? Do I have to 
> copy the whole project on the server and then clone it locally? Is it 
> then possible to push and pull from it?
> 

Maybe this will help:

http://progit.org/book/ch4-0.html


Regards,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: The best defense against logic is stupidity.
