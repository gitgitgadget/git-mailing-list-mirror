From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 6/8] CodingGuidelines: call the conditional statement "if ()", not "if()"
Date: Thu, 01 May 2014 20:36:41 +0200
Message-ID: <87d2fxz6py.fsf@fencepost.gnu.org>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-7-git-send-email-gitster@pobox.com>
	<87lhulziv6.fsf@fencepost.gnu.org>
	<xmqqfvktcqsx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 01 20:36:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfvqi-0006Rj-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 20:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbaEASgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 14:36:44 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:58757 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbaEASgn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 14:36:43 -0400
Received: from localhost ([127.0.0.1]:57799 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wfvqc-0005l7-Sg; Thu, 01 May 2014 14:36:43 -0400
Received: by lola (Postfix, from userid 1000)
	id CBCCBDF343; Thu,  1 May 2014 20:36:41 +0200 (CEST)
In-Reply-To: <xmqqfvktcqsx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 01 May 2014 11:11:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247824>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>>> - - We try to avoid assignments inside if().
>>> + - We try to avoid assignments inside "if ()" condition.
>>
>> That's not grammatical.
>
> OK,
>
> 	... inside the condition part of an "if ()" statement.
>
> then?

       ... in the condition of an "if" statement

is what I would write.  "if ()" statement is mixing name and shorthand
for the statement.

-- 
David Kastrup
