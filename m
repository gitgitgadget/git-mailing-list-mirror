From: David Kastrup <dak@gnu.org>
Subject: Re: AW: Understanding behavior of git blame -M
Date: Sat, 16 Aug 2014 09:02:55 +0200
Message-ID: <87sikwdihs.fsf@fencepost.gnu.org>
References: <71BF70CE41AEE741896AF3A5450D86F11F28C762@DEFTHW99EH3MSX.ww902.siemens.net>
	<874mxderwj.fsf@fencepost.gnu.org>
	<71BF70CE41AEE741896AF3A5450D86F11F28C786@DEFTHW99EH3MSX.ww902.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Sokolov\, Konstantin \(ext\)" <konstantin.sokolov.ext@siemens.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 09:06:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIY4P-0006IV-LT
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 09:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbaHPHEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 03:04:14 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:38146 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbaHPHEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 03:04:13 -0400
Received: from localhost ([127.0.0.1]:37188 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1XIY1z-00030B-JX; Sat, 16 Aug 2014 03:04:03 -0400
Received: by lola (Postfix, from userid 1000)
	id EB5C0E17E0; Sat, 16 Aug 2014 09:02:55 +0200 (CEST)
In-Reply-To: <71BF70CE41AEE741896AF3A5450D86F11F28C786@DEFTHW99EH3MSX.ww902.siemens.net>
	(Konstantin Sokolov's message of "Fri, 15 Aug 2014 20:54:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255319>

"Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com> writes:

> Hi David,
>
> thank you very much for the exhaustive answer. The keyword "hunk" made
> me try a little bit more. So I realized that -M works as expected when
> at least three lines are moved.
>
> From your answer I discern that you find the current behavior
> correct.

I don't say any such thing and don't imply it.

-- 
David Kastrup
