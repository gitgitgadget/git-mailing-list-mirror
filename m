From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Internationalization of git-gui
Date: Sun, 22 Jul 2007 01:05:33 -0700
Message-ID: <7vodi4sw1e.fsf@assigned-by-dhcp.cox.net>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
	<200707211434.56622.stimming@tuhh.de>
	<200707211436.44672.stimming@tuhh.de>
	<200707211437.43524.stimming@tuhh.de>
	<20070722074740.GY32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 10:06:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICWS3-0008WT-DW
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 10:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbXGVIFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 04:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbXGVIFh
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 04:05:37 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39517 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbXGVIFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 04:05:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722080534.HKQA1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 04:05:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SY5Z1X00Q1kojtg0000000; Sun, 22 Jul 2007 04:05:34 -0400
In-Reply-To: <20070722074740.GY32566@spearce.org> (Shawn O. Pearce's message
	of "Sun, 22 Jul 2007 03:47:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53232>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Christian Stimming <stimming@tuhh.de> wrote:
>> Subject: [PATCH] Initial German translation for testing of i18n.
> ...
>> diff --git a/po/de.po b/po/de.po
>> new file mode 100644
>> index 0000000..0592836
>> --- /dev/null
>> +++ b/po/de.po
>> @@ -0,0 +1,265 @@
>> +# Translation of git-gui to German.
>> +# Copyright (C) 2007 Linux Torvalds
>
> I didn't realize Linus wrote German.  ;-)
>
> Or are you assigning the copyright to Linus, much as other chunks
> of Git are copyrighted by Linus?

The convention for xx.po, judging from the way template pot file
is written out, is to name the package's copyright holder, not
translation's, on that line.  So Linus does not have to have
anything to do with the German part, but I think the appropriate
name to place there is yours.
