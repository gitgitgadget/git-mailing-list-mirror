From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Fri, 28 Feb 2014 15:21:39 +0100
Message-ID: <87txbj1fnw.fsf@fencepost.gnu.org>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<20140226202601.GK7855@google.com> <857g8f1ugu.fsf@stephe-leake.org>
	<87fvn335sm.fsf@fencepost.gnu.org> <858usvz5nj.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:21:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOJw-00070I-SL
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbaB1OVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:21:44 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:51048 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbaB1OVo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 09:21:44 -0500
Received: from localhost ([127.0.0.1]:50090 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WJOJn-0002ng-Ez; Fri, 28 Feb 2014 09:21:39 -0500
Received: by lola (Postfix, from userid 1000)
	id 143F3E06C3; Fri, 28 Feb 2014 15:21:39 +0100 (CET)
In-Reply-To: <858usvz5nj.fsf@stephe-leake.org> (Stephen Leake's message of
	"Fri, 28 Feb 2014 08:13:52 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242964>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> "do the right thing" commands also tend to do the wrong thing
>> occasionally with potentially disastrous results when they are used
>> in scripts where the followup actions rely on the actual result.
>
> That is bad, and should not be allowed. On the other hand, I have yet
> to see an actual use case of bad behavior in this discussion.

Huh.

<http://permalink.gmane.org/gmane.comp.version-control.git/242744>

-- 
David Kastrup
