From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] builtin/blame.c::find_copy_in_blob: no need to scan for line end
Date: Sat, 22 Feb 2014 16:52:52 +0100
Message-ID: <874n3rf8kr.fsf@fencepost.gnu.org>
References: <1393084157-23137-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 17:03:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHF2m-0006s2-22
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 17:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbaBVQDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 11:03:00 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:45767 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbaBVQC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 11:02:59 -0500
Received: from localhost ([127.0.0.1]:44809 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WHF2Y-0003Oo-Hb
	for git@vger.kernel.org; Sat, 22 Feb 2014 11:02:58 -0500
Received: by lola (Postfix, from userid 1000)
	id B8412E04F5; Sat, 22 Feb 2014 16:52:52 +0100 (CET)
In-Reply-To: <1393084157-23137-1-git-send-email-dak@gnu.org> (David Kastrup's
	message of "Sat, 22 Feb 2014 16:49:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242530>

David Kastrup <dak@gnu.org> writes:

Oh, good grief.  Forgot to sign off, and on rereading, the commit
message is clearly subfabulous.  So forget this one.  The content is
fine, though.

-- 
David Kastrup
