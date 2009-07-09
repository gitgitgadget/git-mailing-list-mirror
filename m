From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: Re: default aliases (ci, di, st, co)
Date: Thu, 09 Jul 2009 11:01:55 +0200
Message-ID: <h34bms$8to$1@ger.gmane.org>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 11:05:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpZ5-0002wg-81
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 11:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbZGIJFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 05:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896AbZGIJFH
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 05:05:07 -0400
Received: from main.gmane.org ([80.91.229.2]:51318 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbZGIJFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 05:05:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MOpYs-0003a6-MB
	for git@vger.kernel.org; Thu, 09 Jul 2009 09:05:02 +0000
Received: from dsl-245-91-189.telkomadsl.co.za ([41.245.91.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 09:05:02 +0000
Received: from graemeg by dsl-245-91-189.telkomadsl.co.za with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 09:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-245-91-189.telkomadsl.co.za
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122956>

Ondrej Certik wrote:
> [alias]
>     ci = commit
>     di = diff --color-words
>     st = status
>     co = checkout
> 

I also gave from SVN and I must admit, I did create co, st, ci aliases, 
but basically never used them, so removed them since. Git is not SVN, so 
why treat it as such.

Alternatively, you can put your alias somewhere on a wiki or personal 
web page and just refer user to look at your alias list, instead of 
having to explain to them every time why your git commands are 
non-standard. It might save you some time and effort - in the long run.

Or just learn the full git commands. ;-)


Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
