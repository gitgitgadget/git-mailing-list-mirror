From: Miles Bader <miles.bader@necel.com>
Subject: Re: A few usability question about git diff --cached
Date: Fri, 05 Oct 2007 14:59:35 +0900
Message-ID: <buoejga14qg.fsf@dhapc248.dev.necel.com>
References: <4d8e3fd30710040527j61152b2dh1b073504ba19d490@mail.gmail.com>
	<5ACC5CA7-8314-4035-94EC-190138A25EBD@wincent.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 07:59:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdgE9-0007k9-Rq
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 07:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbXJEF7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 01:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXJEF7s
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 01:59:48 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:53168 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbXJEF7r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 01:59:47 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l955xbrU001969;
	Fri, 5 Oct 2007 14:59:37 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Fri, 5 Oct 2007 14:59:37 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay31.aps.necel.com with ESMTP; Fri, 5 Oct 2007 14:59:37 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id C6864455; Fri,  5 Oct 2007 14:59:36 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <5ACC5CA7-8314-4035-94EC-190138A25EBD@wincent.com> (Wincent Colaiuta's message of "Thu\, 4 Oct 2007 14\:54\:31 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60036>

Wincent Colaiuta <win@wincent.com> writes:
> You're probably right that the option name is confusing, I guess  
> changing it to "--index" would be a good idea, continuing to support  
> "--cached" but marking it as deprecated before finally removing it at  
> some point in the future.

Personally all I want is a short-option alias for --cached!

Hopefully something easily type-able (not uppercase)...

-Miles

-- 
Americans are broad-minded people.  They'll accept the fact that a person can
be an alcoholic, a dope fiend, a wife beater, and even a newspaperman, but if a
man doesn't drive, there is something wrong with him.  -- Art Buchwald
