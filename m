From: David Kastrup <dak@gnu.org>
Subject: Re: Pull is Mostly Evil
Date: Fri, 02 May 2014 21:37:25 +0200
Message-ID: <8761lox98q.fsf@fencepost.gnu.org>
References: <5363BB9F.40102@xiplink.com> <87k3a4xjzg.fsf@fencepost.gnu.org>
	<alpine.DEB.2.02.1405021227161.14881@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri May 02 22:53:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKSn-0005pa-UA
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbaEBUxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 16:53:42 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:35787 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbaEBUxl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 16:53:41 -0400
Received: from localhost ([127.0.0.1]:34822 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WgKSg-0003yi-TP; Fri, 02 May 2014 16:53:39 -0400
Received: by lola (Postfix, from userid 1000)
	id 4BD56E0D26; Fri,  2 May 2014 21:37:25 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1405021227161.14881@nftneq.ynat.uz> (David
	Lang's message of "Fri, 2 May 2014 12:31:27 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247977>

David Lang <david@lang.hm> writes:

> On Fri, 2 May 2014, David Kastrup wrote:
>
>> It's just when the merge-left/merge-right/rebase-left/rebase-right
>> decision kicks in that prescribing one git-pull behavior looks like a
>> recipe for trouble.
>
> confusion at least. It's not fatal confusion, people have been using
> it for years after all.

It's one of the most frequent causes for educating newcomers what they
have been doing wrong in the LilyPond project.  Including the occasional
blunder from experienced people who did not notice that they got a
non-ff merge as a mergeday present.

It's one of the main things putting new contributors on edge and causing
anxiety about messing up again.

-- 
David Kastrup
