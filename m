From: David Kastrup <dak@gnu.org>
Subject: Re: Pull is Mostly Evil
Date: Sat, 03 May 2014 10:17:09 +0200
Message-ID: <87iopnwa2i.fsf@fencepost.gnu.org>
References: <5363BB9F.40102@xiplink.com>
	<xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
	<5364A143.1060404@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Sat May 03 10:17:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgV8S-0006fD-IB
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 10:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbaECIRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 04:17:14 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:46377 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaECIRL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 04:17:11 -0400
Received: from localhost ([127.0.0.1]:45418 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WgV89-0004lV-K4; Sat, 03 May 2014 04:17:09 -0400
Received: by lola (Postfix, from userid 1000)
	id 3F361E08B6; Sat,  3 May 2014 10:17:09 +0200 (CEST)
In-Reply-To: <5364A143.1060404@bbn.com> (Richard Hansen's message of "Sat, 03
	May 2014 03:56:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248026>

Richard Hansen <rhansen@bbn.com> writes:

> These three usage patterns are at odds; it's hard to change the
> default behavior of 'git pull' to favor one usage case without harming
> another.  Perhaps this is why there's so much disagreement about what
> 'git pull' should do.

Should a screwdriver be turning clockwise or counterclockwise by
default?  There are valid arguments for either.

-- 
David Kastrup
