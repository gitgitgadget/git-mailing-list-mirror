From: Gelonida <gelonida@gmail.com>
Subject: Re: git clone / git pull to USB memory stick (FAT) and symlinks
Date: Thu, 11 Nov 2010 19:09:21 +0100
Message-ID: <ibhbgi$643$1@dough.gmane.org>
References: <ibh605$adm$1@dough.gmane.org> <7vk4kjhhjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 19:09:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbac-0003qZ-64
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 19:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955Ab0KKSJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 13:09:34 -0500
Received: from lo.gmane.org ([80.91.229.12]:54643 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755939Ab0KKSJd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 13:09:33 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PGbaW-0003oG-JG
	for git@vger.kernel.org; Thu, 11 Nov 2010 19:09:32 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 19:09:32 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 19:09:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 ""
In-Reply-To: <7vk4kjhhjh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161283>

On 11/11/2010 06:54 PM, Junio C Hamano wrote:
> Gelonida <gelonida@gmail.com> writes:

> 
> If you do need a working tree on the stick, and the stick has a FAT
> derived filesystem (which would be the most common), then you would need
> 
>> git config --add core.fileMode false
> 
> and perhaps "core.symlinks false" also would help

WIll try core,symlinks
