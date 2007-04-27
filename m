From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch content
Date: Fri, 27 Apr 2007 20:33:35 +0300
Organization: Private
Message-ID: <d51pzpqo.fsf@cante.net>
References: <ps5qyry4.fsf@cante.net>
	<Pine.LNX.4.64.0704271541010.12006@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 20:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhUqY-0006Y7-2F
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 20:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979AbXD0SG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 14:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756981AbXD0SG6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 14:06:58 -0400
Received: from main.gmane.org ([80.91.229.2]:49689 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756979AbXD0SG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 14:06:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HhUgj-0008Om-7l
	for git@vger.kernel.org; Fri, 27 Apr 2007 19:56:57 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 19:56:57 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Apr 2007 19:56:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:95kolXVBIZazEFQNeUQvwVxk1rA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45741>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 27 Apr 2007, Jari Aalto wrote:
>
>> FEAURE REQUEST
>> --------------
>> 
>> Add sme option to git-format-path to encode thae patch content 
>> (MIME/base64)
>
> Although you ask politely, and have a good explanation why you need it, 
> there is a strong sentiment in some Git developers (most notably, Git's 
> inventor) against this kind of support.
>
> You might have more luck when you decide to implement it yourself, and 
> submit it, though (if it is not too intrusive, I see people adding it, if 
> only to add even more rope to those willing to hang themselves).
>
> Having said that, I think that you can actually teach every mail app 
> (except maybe web-based ones) to respect formatting, including white 
> space.

I hope the development team considers this. There is another uses case
that I can think of too:

- Sending non us-ascii patches (different langauge)

For documentation or code (Java/XML allows UTF-8). 

Jari
