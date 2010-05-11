From: Miles Bader <miles@gnu.org>
Subject: Re: git-gui disagrees with git status
Date: Tue, 11 May 2010 14:41:46 +0900
Message-ID: <buo632vj8px.fsf@dhlpc061.dev.necel.com>
References: <y2m3b1db1e51005101432je9e75a53vbb3781fa33aa83e7@mail.gmail.com>
	<20100510213926.GA7156@spearce.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Winspur <bwinspur@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 11 07:46:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBiI8-0000f7-NM
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 07:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab0EKFl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 01:41:56 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:35297 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab0EKFl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 01:41:56 -0400
Received: from mailgate3.nec.co.jp ([10.7.69.195])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o4B5fmLw020607;
	Tue, 11 May 2010 14:41:48 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o4B5fmn20830; Tue, 11 May 2010 14:41:48 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.54]) by vgate01.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
	id o4B5flu19300; Tue, 11 May 2010 14:41:47 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay31.aps.necel.com with ESMTP; Tue, 11 May 2010 14:41:47 +0900
Received: from dhlpc061 ([10.114.114.96] [10.114.114.96]) by relay41.aps.necel.com with ESMTP; Tue, 11 May 2010 14:41:47 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 237B852E1FC; Tue, 11 May 2010 14:41:47 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20100510213926.GA7156@spearce.org> (Shawn O. Pearce's message of
	"Mon, 10 May 2010 14:39:26 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146867>

"Shawn O. Pearce" <spearce@spearce.org> writes:
> Its more a feature.
>
> git-gui shows all untracked files, recursively expanding any
> directories which contain untracked files.  git status collapses
> them up.

Wait, why is this a feature, exactly...?

It may be well known that git-gui works this way, but that doesn't make
it good behavior for the user.

-Miles

-- 
"Suppose we've chosen the wrong god. Every time we go to church we're
just making him madder and madder." -- Homer Simpson
