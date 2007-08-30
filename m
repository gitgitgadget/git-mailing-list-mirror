From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 1/1] Add basic test for stg status
Date: Thu, 30 Aug 2007 14:45:29 +0200
Message-ID: <87abs9gphy.fsf@morpheus.local>
References: <11884722703161-git-send-email-davidk@lysator.liu.se> <87lkbtgtpy.fsf@morpheus.local> <87ir6xgssk.fsf@morpheus.local> <20070830120755.GA14181@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 14:45:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQjPA-0005lQ-Ix
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 14:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387AbXH3Mpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 30 Aug 2007 08:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbXH3Mpo
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 08:45:44 -0400
Received: from main.gmane.org ([80.91.229.2]:39957 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbXH3Mpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 08:45:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IQjOz-0001HX-00
	for git@vger.kernel.org; Thu, 30 Aug 2007 14:45:37 +0200
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 14:45:36 +0200
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 14:45:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:ISm+HQHGhAkUfuuRU1BhjBfqRo0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57038>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-08-30 13:34:19 +0200, David K=C3=A5gedal wrote:
>
>> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>>
>> > David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>> >
>> > > Signed-off-by: David K=C3=83=C2=A5gedal <davidk@lysator.liu.se>
>> >
>> > This was probably confused by the fact that the patch itself
>> > contained my name in latin1 encoding.
>>
>> Or not. It's the same problem as before. I'll stop using
>> git-send-email until I or someone else fixes it.
>
> Try "stg mail", since you are already using StGIT. It used to have
> this kind of problem, but it doesn't anymore (at least for me).

Yes, much better. Thank you.

--=20
David K=C3=A5gedal
