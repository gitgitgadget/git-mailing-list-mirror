From: David Kastrup <dak@gnu.org>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 08:07:33 +0200
Message-ID: <87zjj656my.fsf@fencepost.gnu.org>
References: <535C47BF.2070805@game-point.net>
	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
	<535D4085.4040707@game-point.net>
	<CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeremy Morton <admin@game-point.net>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 08:09:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weeka-00071h-VV
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 08:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbaD1GJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 02:09:06 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:56002 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbaD1GJF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 02:09:05 -0400
Received: from localhost ([127.0.0.1]:55043 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WeekS-0004tx-63; Mon, 28 Apr 2014 02:09:04 -0400
Received: by lola (Postfix, from userid 1000)
	id B6BC3E0526; Mon, 28 Apr 2014 08:07:33 +0200 (CEST)
In-Reply-To: <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	(Johan Herland's message of "Sun, 27 Apr 2014 21:33:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247235>

Johan Herland <johan@herland.net> writes:

> Obviously, the feature would necessarily have to be optional, simply
> because Git would have to keep understanding the old commit object
> format for a LONG time (probably indefinitely), and there's nothing
> you can do to prevent others from creating old-style commit objects.

Personally, I am _strongly_ opposed.  How I name and juggle my private
branches is nobody else's business in a distributed version control
system.

They are private.  My personal workflow.  Not part of a commit.

-- 
David Kastrup
