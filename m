From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] branch: change install_branch_config() to use skip_prefix()
Date: Thu, 27 Feb 2014 13:05:44 +0100
Message-ID: <87r46o4v6v.fsf@fencepost.gnu.org>
References: <530F1DED.50308@yandex.ru> <530F248B.6030506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 27 13:06:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIzj0-0001yt-Db
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 13:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbaB0MF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 07:05:57 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:42745 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbaB0MF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 07:05:56 -0500
Received: from localhost ([127.0.0.1]:41783 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WIzis-0000Ns-T0; Thu, 27 Feb 2014 07:05:55 -0500
Received: by lola (Postfix, from userid 1000)
	id 7FEBFE06D5; Thu, 27 Feb 2014 13:05:44 +0100 (CET)
In-Reply-To: <530F248B.6030506@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 27 Feb 2014 12:42:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242812>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Dmitry,
>
> Thanks for your patch.  Please see my comments below.
>
> On 02/27/2014 12:13 PM, Dmitry S. Dolzhenko wrote:
>> Change install_branch_config() function to use skip_prefix()
>> for getting short name of remote branch.
>
> English tweak suggestion:
>
> Change THE install_branch_config() function to use skip_prefix()
> for getting THE short name of THE remote branch.

Change install_branch_config() to use skip_prefix()
for getting the short name of the remote branch.

-- 
David Kastrup
