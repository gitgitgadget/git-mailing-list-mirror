From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Wed, 17 Oct 2007 18:13:28 +0200
Message-ID: <86myuhg1nb.fsf@lola.quinscape.zz>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org> <ee77f5c20710152307n48431a6eu5dc95ee504968e4e@mail.gmail.com> <856417h9cj.fsf@lola.goethe.zz> <200710171810.56215.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 18:20:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiBdN-00022X-9R
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 18:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763729AbXJQQUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 12:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760852AbXJQQUR
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 12:20:17 -0400
Received: from main.gmane.org ([80.91.229.2]:46043 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758075AbXJQQUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 12:20:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IiBco-0001qh-TC
	for git@vger.kernel.org; Wed, 17 Oct 2007 16:20:02 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 16:20:02 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 16:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:7wT7dZD+X/06uIse2GrxrVfsPq4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61391>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> tisdag 16 oktober 2007 skrev David Kastrup:
>> "David Symonds" <dsymonds@gmail.com> writes:
>> 
>> > On 16/10/2007, David Kastrup <dak@gnu.org> wrote:
>> >> Geert Bosch <bosch@adacore.com> writes:
>> >>
>> >> > On Oct 15, 2007, at 13:53, David Symonds wrote:
>> >> >> That's also why I suggested "skip"; you might not be able to test a
>> >> >> particular commit, but you might also not *want* to test a particular
>> >> >> commit for some reason.
>> >> >
>> >> > Skip seems a great choice: it directly expresses the wish to
>> >> > not consider a certain commit. The reason is unimportant.
>> >>
>> >> But it is an _action_, while "good" and "bad" are properties.
>> >
>> > "skipped", then.
>> 
>> "good" and "bad" are descriptive.  "to be skipped" would be necessary
>> to fit it.
>
> Yet another very short word: void.

It is not "yet another": I already explained why it does not fit.

-- 
David Kastrup
