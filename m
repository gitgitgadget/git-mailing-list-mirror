From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Wed, 03 Mar 2010 13:49:27 +0900
Message-ID: <buod3zmj9go.fsf@dhlpc061.dev.necel.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com>
	<1267246670-19118-5-git-send-email-lodatom@gmail.com>
	<4B890572.5040604@lsrfire.ath.cx>
	<ca433831002281214q14e6e62bj54cf7227cd32873b@mail.gmail.com>
	<b4087cc51002281426m126a0c07l9f4a38088d0146b1@mail.gmail.com>
	<ca433831003011749h43293f80kd4ec18bd796dea7c@mail.gmail.com>
	<4b8cb38b.870fcc0a.7ebc.1a83@mx.google.com>
	<ca433831003022026pbc172d6ocb5ff2aefe29f462@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 05:49:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmgWl-0007Nm-BN
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 05:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab0CCEtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 23:49:32 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:58052 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab0CCEtc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 23:49:32 -0500
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o234nRTR002026;
	Wed, 3 Mar 2010 13:49:27 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Wed, 3 Mar 2010 13:49:27 +0900
Received: from dhlpc061 ([10.114.113.157] [10.114.113.157]) by relay21.aps.necel.com with ESMTP; Wed, 3 Mar 2010 13:49:27 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 714B452E1FF; Wed,  3 Mar 2010 13:49:27 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <ca433831003022026pbc172d6ocb5ff2aefe29f462@mail.gmail.com> (Mark
	Lodato's message of "Tue, 2 Mar 2010 23:26:36 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141436>

Mark Lodato <lodatom@gmail.com> writes:
> Furthermore, the current behavior of all git tools is to make
> --color turn on color always, so I imagine you would have to make an
> extremely compelling argument to break backwards compatibility.

I don't think the usual backwards-compatibility arguments should really
apply to edge-cases in frippery like --color...

-Miles

-- 
Generous, adj. Originally this word meant noble by birth and was rightly
applied to a great multitude of persons. It now means noble by nature and is
taking a bit of a rest.
