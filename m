From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH RFC 07/10] send-email: Remove horrible mix of tabs and  spaces
Date: Mon, 13 Apr 2009 10:49:17 +0900
Message-ID: <buoljq5cogy.fsf@dhlpc061.dev.necel.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
	<1239476908-25944-2-git-send-email-mfwitten@gmail.com>
	<1239476908-25944-3-git-send-email-mfwitten@gmail.com>
	<1239476908-25944-4-git-send-email-mfwitten@gmail.com>
	<1239476908-25944-5-git-send-email-mfwitten@gmail.com>
	<1239476908-25944-6-git-send-email-mfwitten@gmail.com>
	<1239476908-25944-7-git-send-email-mfwitten@gmail.com>
	<fabb9a1e0904111217t55fc0fd1y8d2b8b3a156e4f21@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 03:50:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtBK6-0007ag-Vp
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 03:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbZDMBt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Apr 2009 21:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbZDMBt0
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 21:49:26 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:55463 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbZDMBtZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Apr 2009 21:49:25 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n3D1nHxA010869;
	Mon, 13 Apr 2009 10:49:17 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Mon, 13 Apr 2009 10:49:17 +0900
Received: from dhlpc061 ([10.114.114.58] [10.114.114.58]) by relay21.aps.necel.com with ESMTP; Mon, 13 Apr 2009 10:49:17 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 2E81952E1FF; Mon, 13 Apr 2009 10:49:17 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <fabb9a1e0904111217t55fc0fd1y8d2b8b3a156e4f21@mail.gmail.com>
	(Sverre Rabbelier's message of "Sat, 11 Apr 2009 21:17:30 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116398>

Sverre Rabbelier <srabbelier@gmail.com> writes:
>> +## WARNING! ACHTUNG! ATTENTION! ADVERTENCIA!
>> +## =A0 Currently, this file uses tabs (like the rest of git source)=
 to
>> +## =A0 delineate code structure. Do NOT under any circumstances mix=
 tabs
>> +## =A0 and spaces across lines that share a relationship in terms o=
f layout.
>> +## =A0 In fact, it would currently be best to use only tabs, so ple=
ase set
>> +## =A0 your editor(s) accordingly. This code is already trashy enou=
gh. Please
>> +## =A0 don't make it worse.
>
> Isn't this a bit overkill? In fact, isn't it overkill a lot?

"Bizarre" is the word I'd use...

[There are places to whine about whitespace conventions, but that place
isn't giant screaming comments in individual source files...]

-miles

--=20
Admiration, n. Our polite recognition of another's resemblance to ourse=
lves.
