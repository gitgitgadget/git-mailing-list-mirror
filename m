From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4 (alternate)] Add '--fixed-strings' option to "git log
 --grep" and friends
Date: Wed, 27 Feb 2008 11:47:36 -0800
Message-ID: <7vpruitc4n.fsf@gitster.siamese.dyndns.org>
References: <1204028528-18941-1-git-send-email-jnareb@gmail.com>
 <1204028528-18941-2-git-send-email-jnareb@gmail.com>
 <7vfxvf2osk.fsf@gitster.siamese.dyndns.org>
 <200802271020.21662.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 20:48:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSGc-00059b-CE
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757219AbYB0Trw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757181AbYB0Trw
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:47:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756911AbYB0Trw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 14:47:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77B1D24FF;
	Wed, 27 Feb 2008 14:47:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B56D724FC; Wed, 27 Feb 2008 14:47:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75292>

Jakub Narebski <jnareb@gmail.com> writes:

>> So I am reluctant to
>> see it grab a short-and-sweet -F option letter that might have
>> better uses, but I do not have major objection against a more
>> explicit --fixed-strings.
>
> This version doesn't use '-F' short option.

Thanks for re-rolling, but after having slept on it, I think
your original is just fine, so I'll take it with short and sweet
"-F" option.
