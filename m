From: Miles Bader <miles@gnu.org>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 10:09:55 +0900
Message-ID: <buoy6s07v30.fsf@dhlpc061.dev.necel.com>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	<32541b130906091252i6c96c44buc148bb525d7cde14@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 03:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MECKS-0002ko-MF
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 03:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbZFJBKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 21:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbZFJBKD
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 21:10:03 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:63487 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbZFJBKC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 21:10:02 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n5A19tZS012634;
	Wed, 10 Jun 2009 10:09:55 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay11.aps.necel.com with ESMTP; Wed, 10 Jun 2009 10:09:55 +0900
Received: from dhlpc061 ([10.114.114.32] [10.114.114.32]) by relay11.aps.necel.com with ESMTP; Wed, 10 Jun 2009 10:09:55 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 9C8E752E1D2; Wed, 10 Jun 2009 10:09:55 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <32541b130906091252i6c96c44buc148bb525d7cde14@mail.gmail.com>
	(Avery Pennarun's message of "Tue, 9 Jun 2009 15:52:46 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121240>

Avery Pennarun <apenwarr@gmail.com> writes:
> This would definitely make it easier to explain things to svn users.
> To be honest, I'm not convinced svn's use of the word "revert" is
> really right, though.  Git's isn't *really* right either, since it
> actually makes a new commit, it doesn't remove the old one like it
> sounds like it does.

I think both definitions are quite reasonable.

The sense in which git uses the word -- "make a change reversing an
earlier change" -- is actually very common in programming.

-Miles

-- 
Would you like fries with that?
