From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git.el: Support for showing unknown/ignored
 directories.
Date: Wed, 27 Feb 2008 23:46:44 -0800
Message-ID: <7v3ardldzv.fsf@gitster.siamese.dyndns.org>
References: <87zludorqs.fsf@wine.dyndns.org>
 <20080222153051.GA20984@diana.vm.bytemark.co.uk>
 <8763whkmxf.fsf@wine.dyndns.org>
 <20080222171052.GA23012@diana.vm.bytemark.co.uk>
 <20080227112746.GA10786@diana.vm.bytemark.co.uk>
 <7vejaytc35.fsf@gitster.siamese.dyndns.org>
 <20080228070611.GA28085@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 08:47:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUdUU-0001GL-4i
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 08:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbYB1HrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Feb 2008 02:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbYB1HrE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 02:47:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbYB1HrD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2008 02:47:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B6BB26B3;
	Thu, 28 Feb 2008 02:47:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7F66A26B2; Thu, 28 Feb 2008 02:46:54 -0500 (EST)
In-Reply-To: <20080228070611.GA28085@diana.vm.bytemark.co.uk> (Karl
 =?utf-8?Q?Hasselstr=C3=B6m's?= message of "Thu, 28 Feb 2008 08:06:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75364>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> (Would you like this kind of detailed pointer in a reminder, or is th=
e
> threading support in your mailer good enough that just replying to th=
e
> right mail will do it?)

I'd actually like a forwarded message that I can directly feed
to "git am", with Sign-offs and Acked-bys, but being explicit
would be good enough.

I often do not have enough mental and time bandwidth to hunt for
messages more than 2 weeks old in the list archive, so unless
the response is direct reply to the original, I'd rather not
rely on the threading feature. IOW, I can move to grandparent by
typing ^ just fine, but uncles and aunts are harder to find
without reloading my MUA full message archive for N weeks worth.
