From: Miles Bader <miles@gnu.org>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Fri, 22 Oct 2010 13:07:56 +0900
Message-ID: <buoeibi6fab.fsf@dhlpc061.dev.necel.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	<m3ocar5fmo.fsf@localhost.localdomain> <4CBFFD79.1010808@alum.mit.edu>
	<1287660007.24161.10.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Oct 22 06:08:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P98vx-00060N-40
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 06:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281Ab0JVEIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 00:08:42 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:40337 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab0JVEIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 00:08:42 -0400
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o9M481pn004540;
	Fri, 22 Oct 2010 13:08:01 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o9M481D29802; Fri, 22 Oct 2010 13:08:01 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.54])
	by vgate01.nec.co.jp (8.14.4/8.14.4) with ESMTP id o9M43W9S003662;
	Fri, 22 Oct 2010 13:08:00 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Fri, 22 Oct 2010 13:08:00 +0900
Received: from dhlpc061 ([10.114.96.148] [10.114.96.148]) by relay41.aps.necel.com with ESMTP; Fri, 22 Oct 2010 13:08:00 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id E3415124042; Fri, 22 Oct 2010 13:07:56 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <1287660007.24161.10.camel@drew-northup.unet.maine.edu> (Drew
	Northup's message of "Thu, 21 Oct 2010 07:20:07 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159636>

Drew Northup <drew.northup@maine.edu> writes:
> Ok, so what will "git stage" do when a change of a file is already
> staged and it is executed again (on new changes)?

It stages the newly updated file?

This seems entirely obvious and intuitive, far more so than "git add"...

-Miles

-- 
Happiness, n. An agreeable sensation arising from contemplating the misery of
another.
