From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git.el: Support for showing unknown/ignored
 directories.
Date: Wed, 27 Feb 2008 11:48:30 -0800
Message-ID: <7vejaytc35.fsf@gitster.siamese.dyndns.org>
References: <87zludorqs.fsf@wine.dyndns.org>
 <20080222153051.GA20984@diana.vm.bytemark.co.uk>
 <8763whkmxf.fsf@wine.dyndns.org>
 <20080222171052.GA23012@diana.vm.bytemark.co.uk>
 <20080227112746.GA10786@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 20:51:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSIh-00063F-Cz
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759012AbYB0Tst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 14:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759001AbYB0Tst
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:48:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758567AbYB0Tss convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 14:48:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 976732514;
	Wed, 27 Feb 2008 14:48:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 85D4B250A; Wed, 27 Feb 2008 14:48:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75295>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-02-22 18:10:52 +0100, Karl Hasselstr=C3=B6m wrote:
> ...
>> That fixed the problem. Thanks!
>>
>> > Signed-off-by: Alexandre Julliard <julliard@winehq.org>
>>
>> Tested-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
>
> Junio, did you see this bugfix? (I just realized you weren't cc'ed, s=
o
> I guess not.)

No, and thanks.

So I'll take

    From: Alexandre Julliard <julliard@winehq.org>
    Message-ID: <8763whkmxf.fsf@wine.dyndns.org>
   =20
aka

    http://article.gmane.org/gmane.comp.version-control.git/74730

in this thread with your Tested-by: and apply to fix 3f3d564
(git.el: Support for showing unknown/ignored directories.)?
