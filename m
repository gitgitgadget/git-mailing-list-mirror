From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Antw: Re: Enhancement Request: "locale" git option
Date: Mon, 08 Dec 2014 08:20:13 +0100
Message-ID: <54855F3D020000A10001836C@gwsmtp1.uni-regensburg.de>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
 <CAN0XMOL5ZZgEJ3zaXOAcxyX47iTM-DQv=+PNsdVrjD4aWwx2iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 08:20:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxscK-0006yY-Es
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 08:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbaLHHUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 02:20:17 -0500
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:33897 "EHLO
	rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbaLHHUQ convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-git@vger.kernel.org:2:1>);
	Mon, 8 Dec 2014 02:20:16 -0500
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 049623B6C9
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 08:20:15 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id D8CF543230
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 08:20:14 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Mon, 08 Dec 2014 08:20:14 +0100
X-Mailer: Novell GroupWise Internet Agent 14.0.1 
In-Reply-To: <CAN0XMOL5ZZgEJ3zaXOAcxyX47iTM-DQv=+PNsdVrjD4aWwx2iw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261000>

>>> Ralf Thielow <ralf.thielow@gmail.com> schrieb am 04.12.2014 um 20:02 in
Nachricht
<CAN0XMOL5ZZgEJ3zaXOAcxyX47iTM-DQv=+PNsdVrjD4aWwx2iw@mail.gmail.com>:
> Hi Ulrich,
> 
> 2014-12-04 8:32 GMT+01:00 Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>:
>> Hi!
>>
>> I'm native German, but German git messages confuse me (yopu'll have to 
> correlate them with the man pages). At the moment git uses the
> 
> What in particular makes the German git messages confusing you? What
> `git version` do you use?
> Maybe we can find something to improve in the translation.

The problem is (as others found out already) that all documentation I have use english Git messages, and lots of documentation is in English.

You could compare it to C++ (for example): If you read the language reference in English, you can only be confused by German compiler messages, and if you have a German book on C++, the phrases the book uses are quite likely not the ones the compiler uses...

Back to Git: Assuming (pure Science Fiction) that you participate in several projects using Git: One from a French maintainer expects that Git messages are in French, one Project uses English, another Project uses German... The a per-project locale setting would make sense (despite of the fact that I believe that every international project should use English for communication (just because it's a kind of "industry standard", not giving any personal preference).

Regards,
Ulrich

> 
> Thanks,
> Ralf
