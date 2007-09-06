From: Miles Bader <miles.bader@necel.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 06 Sep 2007 14:03:40 +0900
Message-ID: <buoir6oo05v.fsf@dhapc248.dev.necel.com>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, "Git" <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:03:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT9Wu-0007Je-MW
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 07:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbXIFFDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 01:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXIFFDo
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 01:03:44 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:50706 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbXIFFDn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 01:03:43 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l8653POJ007865;
	Thu, 6 Sep 2007 14:03:25 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Thu, 6 Sep 2007 14:03:25 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay21.aps.necel.com with ESMTP; Thu, 6 Sep 2007 14:03:25 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 7899D58A; Thu,  6 Sep 2007 14:03:41 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> (Dmitry Kakurin's message of "Wed\, 5 Sep 2007 21\:48\:47 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57819>

Dmitry Kakurin <dmitry.kakurin@gmail.com> writes:
> When I first looked at Git source code two things struck me as odd:
> 1. Pure C as opposed to C++. No idea why. Please don't talk about
> portability, it's BS.

Just to piss you off.

-Miles

-- 
Love is a snowmobile racing across the tundra.  Suddenly it flips over,
pinning you underneath.  At night the ice weasels come.  --Nietzsche
