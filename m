From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH -resend] Add a helper script to send patches with Mozilla
 Thunderbird
Date: Thu, 19 Jun 2008 19:58:57 -0700
Message-ID: <7vfxr8q0b2.fsf@gitster.siamese.dyndns.org>
References: <7vmylhq6lb.fsf@gitster.siamese.dyndns.org>
 <484D6A40.60002@etek.chalmers.se> <485AE9FD.8050508@etek.chalmers.se>
 <7vmylhq6lb.fsf@gitster.siamese.dyndns.org>
 <20080620102212.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lukas Sandstrm <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 05:00:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9WrR-0000AO-5l
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 05:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYFTC7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 22:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbYFTC7a
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 22:59:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbYFTC73 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 22:59:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D2021DBE2;
	Thu, 19 Jun 2008 22:59:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 652EB1DBD9; Thu, 19 Jun 2008 22:59:07 -0400 (EDT)
In-Reply-To: <20080620102212.6117@nanako3.lavabit.com> (nanako3@lavabit.com's
 message of "Fri, 20 Jun 2008 10:22:12 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DEB6A1AA-3E74-11DD-8D26-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85591>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:
>>
>>> The script appp.sh can be used with the External Editor extension f=
or
>>> Mozilla Thunderbird in order to be able to send inline patches in a=
n
>>> easy way.
>>>
>>> Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
>>> ---
>>>
>>> Resending. It would be nice if this ended up in contrib/
>>>
>>> /Lukas
>>>
>>>  Documentation/SubmittingPatches          |    5 +++
>>>  contrib/thunderbird-patch-inline/README  |   20 +++++++++++
>>>  contrib/thunderbird-patch-inline/appp.sh |   55 ++++++++++++++++++=
+++++++++
>>
>> A silly question.  What does "appp" stand for?  AppendPatch does not=
 have
>> that many P's in it.
>
> Silly Junio (^_^).  Count them again.

*Blush*  Sorry for the noise.
