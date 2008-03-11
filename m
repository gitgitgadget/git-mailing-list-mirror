From: David Kastrup <dak@gnu.org>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Tue, 11 Mar 2008 18:35:02 +0100
Message-ID: <86abl5f9kp.fsf@lola.quinscape.zz>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com>
	<alpine.LSU.1.00.0803111352200.3873@racer.site>
	<47D6BE8D.3070009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 18:36:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ8Ox-0004KZ-6Q
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 18:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbYCKRfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 13:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbYCKRfV
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 13:35:21 -0400
Received: from main.gmane.org ([80.91.229.2]:45325 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233AbYCKRfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 13:35:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JZ8Nb-0003pq-DB
	for git@vger.kernel.org; Tue, 11 Mar 2008 17:35:11 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 17:35:11 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 17:35:11 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:LYHMm/dPxf2EYf3XNpqK55pCv0c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76884>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Johannes Schindelin schrieb:
>> Hi,
>> 
>> On Tue, 11 Mar 2008, Whit Armstrong wrote:
>> 
>>> tr: Bad string.
>> 
>> What string?
>
> It's this tr, which is the implementation of ./rot13.sh:
>
>    tr '[a-zA-Z]' '[n-za-mN-ZA-M]'
>
> I can't tell what's wrong with it on Solaris, though.

The brackets?

-- 
David Kastrup
